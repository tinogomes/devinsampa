# encoding: utf-8
require "ostruct"

class PagesController < ApplicationController
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  caches_page :index, :museum, :php, :agenda, :presentations, :feedback

  def php
    text = auto_link("Quer invadir? Vai ler o código em http://github.com/tinogomes/devinsampa e depois a gente conversa, ok?")
    render :text => text
  end

  def contact
    @contact = OpenStruct.new

    load_contact_with_params

    if request.post? && params[:contact].delete([:phone]).blank?
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

  def presentations
    @presentations = Presentation.all :order => "title"
  end

  def agenda
    @agenda = Agenda.all
  end

  def not_found
    render :status => :not_found, :layout => true
  end

  def redirecting
    redirect_to params[:to] || "/"
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