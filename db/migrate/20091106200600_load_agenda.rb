class LoadAgenda < ActiveRecord::Migration
  def self.up
    agenda = [
      {:start_time => '08:00', :end_time => '09:00', :event => 'Credenciamento e Café da Manhã'},
      {:start_time => '09:00', :end_time => '10:00', :event => 'Palestra I'},
      {:start_time => '10:00', :end_time => '11:00', :event => 'Palestra II'},
      {:start_time => '11:00', :end_time => '12:00', :event => 'Palestra III'},
      {:start_time => '12:00', :end_time => '13:30', :event => 'Intervalo para almoço'},
      {:start_time => '13:30', :end_time => '14:30', :event => 'Palestra IV'},
      {:start_time => '14:30', :end_time => '15:30', :event => 'Palestra V'},
      {:start_time => '15:30', :end_time => '16:00', :event => 'Coffee-break'},
      {:start_time => '16:00', :end_time => '17:00', :event => 'Palestra VI'},
      {:start_time => '17:00', :end_time => '18:00', :event => 'Palestra VII'},
      {:start_time => '18:00', :end_time => '', :event => 'Encerramento'}
    ]

    agenda.each {|a| Agenda.create a }
  end

  def self.down
  end
end
