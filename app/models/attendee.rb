class Attendee < ActiveRecord::Base
  LIMIT_ATTENDEE = 80

  validates_presence_of   :name
  validates_presence_of   :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => User::EMAIL_REGEX
  validates_presence_of :doc
  
  attr_accessible :name, :email, :doc, :compay
  
  before_create :set_token
  after_create :send_mail_after_create
  before_destroy :send_mail_before_delete
  
  symbolize :status, :allow_blank => true, :in => Hash[*PagSeguro::Notification::STATUS.map { |k,v| [v, k] }.flatten]
  symbolize :payment_method, :allow_blank => true, :in => Hash[*PagSeguro::Notification::PAYMENT_METHOD.map { |k,v| [v, k] }.flatten]
  
  def update_payment_data(notification)
    old_status    = self.status

    self[:notes]  = notification.notes
    self[:buyer]  = notification.buyer.to_json
    self[:status] = notification.status
    self[:processed_at]   = notification.processed_at
    self[:transaction_id] = notification.transaction_id
    self[:payment_method] = notification.payment_method
    self.save!

    send_emails_before_change_status if self.status != old_status
  end
  
  def final_status
    case self.status
    when :completed, :approved
      :completed
    when :canceled, :refunded
      :canceled
    else
      :pending
    end
  end
  
  def pending?
    final_status == :pending
  end
  
  def completed?
    final_status == :completed
  end
  
  def canceled?
    final_status == :canceled
  end
  
  def really_pending?
    (!status.nil? && final_status == :pending)
  end
  
  def self.overload?
    Attendee.count >= LIMIT_ATTENDEE
  end
  
  def send_mail_after_create
    spawn do
      Contact.deliver_attendee_created(self)
    end
  end

  private
  
    def send_mail_before_delete
      spawn do
        Contact.deliver_attendee_unregister(self)
      end
    end
  
    def send_emails_before_change_status
      if completed?
        spawn do
          Contact.deliver_attendee_confirmation(self)
        end
      elsif canceled?
        spawn do
          Contact.deliver_attendee_problem(self)
        end
      end
    end
    
    def set_token
      self[:token] = Digest::SHA1.hexdigest("#{Time.now}#{email}").slice(0,30).upcase
    end
end
