class Agenda < ActiveRecord::Base
  belongs_to :presentation

  def what_happen
    presentation || self.event
  end

end