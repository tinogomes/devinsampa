class Attendee < ActiveRecord::Base
  LIMIT_ATTENDEE = 80

  validates_presence_of   :name
  validates_presence_of   :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => User::EMAIL_REGEX
  validates_presence_of :doc
  
  attr_accessible :name, :email, :doc, :compay
  
  after_update :send_emails_after_change_status
  before_create :set_token
  after_create :send_mail_after_create
  before_destroy :send_mail_before_delete
  
  symbolize :status, :allow_blank => true, :in => Hash[*PagSeguro::Notification::STATUS.map { |k,v| [v, v.to_s] }.flatten]
  symbolize :payment_method, :allow_blank => true, :in => Hash[*PagSeguro::Notification::PAYMENT_METHOD.map { |k,v| [v, v.to_s] }.flatten]
  
  def update_payment_data(notification)
    self[:notes]  = notification.notes
    self[:buyer]  = notification.buyer.to_json
    self[:status] = notification.status
    self[:processed_at]   = notification.processed_at
    self[:transaction_id] = notification.transaction_id
    self[:payment_method] = notification.payment_method
    self.save!
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
  
  def send_mail_will_unregister
    return false unless status.nil?
    self.will_unregister = true
    result = self.save
    if result
      spawn do
        Contact.deliver_attendee_will_unregister(self)
      end
    end
    result
  end

  private
  
    def send_mail_before_delete
      spawn do
        Contact.deliver_attendee_unregister(self)
      end
    end
  
    def send_emails_after_change_status
      if self.changed.include?("status")
        if self.completed?
          spawn do
            Contact.deliver_attendee_confirmation(self)
          end
        elsif self.canceled?
          spawn do
            Contact.deliver_attendee_problem(self)
          end
        elsif !self.status.nil?
          spawn do
            Contact.deliver_attendee_pending(self)
          end
        end
      end
    end
    
    def set_token
      self[:token] = Digest::SHA1.hexdigest("#{Time.now}#{email}").slice(0,30).upcase
    end
    
end
