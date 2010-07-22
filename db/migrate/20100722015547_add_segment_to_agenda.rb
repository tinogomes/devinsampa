class AddSegmentToAgenda < ActiveRecord::Migration
  def self.up
    add_column :agendas, :segment, :string

    Agenda.reset_column_information
    Agenda.update_all :segment => 'Desenvolvimento'
    agenda = Agenda.all.collect {|item| h = item.attributes; %w(created_at updated_at id presentation_id).each {|w| h.delete(w)}; h["segment"] = "Boas Práticas de Desenvolvimento"; h }
    agenda.each {|a| Agenda.create(a) }
  end

  def self.down
    remove_column :agendas, :segment
  end
end
