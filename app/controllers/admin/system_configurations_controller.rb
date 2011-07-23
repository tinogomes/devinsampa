# encoding: utf-8
class Admin::SystemConfigurationsController < Admin::AdminController
  before_filter :load_system_configuration

  def edit
  end

  def update

    @system_configuration.limit_attendee = params[:system_configuration][:limit_attendee].to_i
    @system_configuration.can_register_attendee = (params[:system_configuration][:can_register_attendee] == "1")

    if @system_configuration.save
      flash[:notice] = "Os dados foram atualizados com sucesso..."
    else
      flash[:error] = "Não foi possível atualizar, verifique"
    end
    render :action => "edit"
  end

  private
    def load_system_configuration
      @system_configuration = SystemConfiguration.current.clone
    end

end
