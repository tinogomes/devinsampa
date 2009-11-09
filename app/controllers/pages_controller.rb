require "ostruct"

class PagesController < ApplicationController
  FLAG_FILE = "#{RAILS_CACHE_STORE}/disabled.txt"

  before_filter :enable_or_disable_cache
  caches_action :index, :banners, :register, :talker, :speakers, :agenda, :if => Proc.new { |c| !File.exists?(FLAG_FILE) }
  
  def contact
    @contact = OpenStruct.new
    
    load_contact_with_params
    
    if request.post?
      if contact_valid?(@contact)
        spawn do
          logger.info "Trying send email from #{@contact.inspect}"
          Contact.deliver_from_site(@contact, params[:contact][:receive_a_copy] == "1")
        end
        
        flash[:notice] = "Sua mensagem foi encaminhada."
        @contact.subject = ""
        @contact.description = ""
      else
        flash[:error] = "Não foi possível enviar seu email."
      end
    end
  end
  
  def speakers
    @speakers = Speaker.all :order => "name"
  end
  
  def agenda
    @agenda = Agenda.all :order => "start_time"
  end
  
  private
    def enable_or_disable_cache
      cached = params[:cached]

      unless cached.nil?
        if cached == "on"
          FileUtils.rm_f(FLAG_FILE) if File.exists?(FLAG_FILE)
        else
          
          `rake tmp:cache:clear`
          FileUtils.touch(FLAG_FILE)
        end
      end
    end
    
    def contact_valid?(contact)
      contact.errors = []
      contact.errors << :name unless valid_contact_name?(contact)
      contact.errors << :email unless valid_contact_email?(contact)
      contact.errors << :subject unless valid_contact_subject?(contact)
      contact.errors << :description unless valid_contact_description?(contact)
      contact.errors.size == 0
    end
    
    def valid_contact_name?(contact)
      return false unless contact
      return false if contact.name.blank?
      true
    end
    
    def valid_contact_email?(contact)
      return false unless contact
      return false if contact.email.blank?
      return false unless User::EMAIL_REGEX.match(contact.email)
      true
    end
    
    def valid_contact_subject?(contact)
      return false unless contact
      return false if contact.subject.blank?
      true
    end
      
    def valid_contact_description?(contact)
      return false unless contact
      return false if contact.description.blank?
      true
    end
    
    def load_contact_with_params
      if params[:contact]
        contact = params[:contact]
        @contact.name = contact[:name] unless contact[:name].blank?
        @contact.email = contact[:email] unless contact[:email].blank?
        @contact.subject = contact[:subject] unless contact[:subject].blank?
        @contact.description = contact[:description] unless contact[:description].blank?
      end
    end
end