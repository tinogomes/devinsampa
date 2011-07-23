# encoding: utf-8
class Agenda < ActiveRecord::Base
  default_scope :order => "segment DESC, start_time"
  belongs_to :presentation

  def what_happen
    presentation || self.event
  end

end