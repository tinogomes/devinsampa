class Agenda < ActiveRecord::Base
  belongs_to :speaker

  def what_happen
    speaker ? "<a href='/palestrantes#speaker-#{speaker.id}'>#{speaker.name} - #{speaker.presentation}</a>" : self.event
  end

end