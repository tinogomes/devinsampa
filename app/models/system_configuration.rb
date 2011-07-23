# encoding: utf-8
class SystemConfiguration < ActiveRecord::Base
  DEFAULT_KEYS = {:limit_attendee => 130, :can_register_attendee => false}

  serialize :values, Hash

  validate :validate_limit_attendee
  validate :validate_can_register_attendee

  def values
    read_attribute(:values) || {}
  end

  def method_missing(meth, *args, &blk)
    def attr_name(name)
      name[0..(name.length-2)]
    end

    keys = DEFAULT_KEYS.keys.map {|k| k.to_s}
    m = meth.to_s
    at = attr_name(m).to_sym
    # instance.can_register_attendee
    if keys.include?(m)
      self.values[meth]
    # instante.can_register_attendee = true
    elsif keys.map{|k| "#{k}="}.include?(m)
      self.values[at] = args.first
    # instante.can_register_attendee?
    elsif keys.map{|k| "#{k}?"}.include?(m)
      !!(self.values[at])
    else
      super(meth, args, &blk)
    end
  end

  def self.current
    (SystemConfiguration.last || SystemConfiguration.create(DEFAULT_KEYS))
  end

  def self.method_missing(meth, *args, &blk)
    # SystemConfiguration.can_register_attendee
    if DEFAULT_KEYS.keys.include?(meth)
      SystemConfiguration.current.values[meth]
    else
      super(meth, args, &blk)
    end
  end

  private
    def validate_limit_attendee
      if values[:limit_attendee].kind_of?(Fixnum)
        errors.add_to_base("limit_attendee invalid number") unless (0..1_000_000).include?(values[:limit_attendee])
      else
        errors.add_to_base("limit_attendee want to be a number value between 0 and 1.000.000")
      end
    end

    def validate_can_register_attendee
      errors.add_to_base("can_register_attendee want be true/false value") unless ([TrueClass, FalseClass].include?(values[:can_register_attendee].class))
    end
end
