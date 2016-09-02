module Validator
  def validate_format(format, value)
    (value =~ Regexp.new(format)) != nil
  end

  def validate_length(string, options)
    defaults = {min: 0, max: Float::INFINITY}

    defaults.merge options

    string.size >= options[:min] && string.size <= options[:max]
  end

  def validate_presence(value)
    !value.nil?
  end

  def validate_class(value, class_name)
    value.instance_of? class_name
  end
end