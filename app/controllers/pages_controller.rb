require "ostruct"

class PagesController < ApplicationController
  caches_action :index, :banners, :talker, :register, :contact, :speakers, :agenda
  
  def index
  end

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
  
  def banners
  end
  
  def talker
  end
  
  def register
  end
  
  def speakers
    @speakers = Speaker.all :order => "name"
  end
  
  def agenda
    @agenda = Agenda.all :order => "start_at"
  end
  
  private
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

class Agenda
  def self.all(*args)
    agenda = []
    
    items = [
      ["08:00", "08:50", "Credenciamento", nil],
      ["08:50", "09:00", "Abertura", nil],
      ["09:00", "09:40", "Palestra I", 1],
      ["09:40", "10:20", "Palestra II", nil],
      ["10:20", "10:40", "Coffee-break", nil],
      ["10:40", "11:20", "Palestra III", nil],
      ["11:20", "12:00", "Palestra IV", nil],
      ["12:00", "14:00", "Intervalo para almoço (*)", nil],
      ["14:00", "14:40", "Palestra V", nil],
      ["14:40", "15:20", "Palestra VI", nil],
      ["15:20", "15:40", "Coffee-break", nil],
      ["15:40", "16:20", "Palestra VII", nil],
      ["16:20", "17:00", "Palestra VIII", nil],
      ["17:00", "17:40", "Palestra XI", nil],
      ["17:40", "18:00", "Sorteiros e encerramento", nil],
      ["18:00", "Cansar", "#horaextra", nil],
    ]
    
    
    items.each do |item|
      os = OpenStruct.new :start_at => item[0], :end_at => item[1], :event => item[2], :speaker_id => item[3]
      
      def os.speaker
        return nil if self.speaker_id.nil?
        @speaker ||= Speaker.find(speaker_id) rescue nil
      end
      
      def os.what_happen
        speaker ? "<a href='/palestrantes#speaker-#{speaker.id}'>#{speaker.name} - #{speaker.presentation}</a>" : self.event
      end
      agenda << os
    end
    
    agenda
  end
end