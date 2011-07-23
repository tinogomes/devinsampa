# encoding: utf-8
class Object
  def not_nil?
    !self.nil?
  end
end

class Nil
  def not_nil?
    false
  end
end

class ActiveRecord::Base
  def invalid?
    !self.valid?
  end
end