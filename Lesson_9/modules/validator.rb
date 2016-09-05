module Validator
  EXISTING_VALIDATORS = [:presence, :format, :type, :positive_number]

  def self.extended(base)
    base.send :include, InstanceMethods
  end

  def validate(*args)
    attr_name, validator_name, valid_value = parse_args(args)

    unless EXISTING_VALIDATORS.include? validator_name
      raise ArgumentError, I18n.t('errors.unknown_validator', validation_name: validator_name)
    end

    add_validator(attr_name, validator_name, valid_value)

    define_method 'validate!', validate_method_proc

    define_method 'valid?', valid_method_proc
  end

  module InstanceMethods
    def validate_presence(attr_name, attr_value, valid_value = true)
      return unless valid_value

      raise AttributeError unless [true, false].include? valid_value

      if attr_value.nil? || attr_value == ''
        raise RuntimeError, I18n.t('errors.validations.property_not_present',
          name: attr_name
        )
      end
    end

    def validate_positive_number(attr_name, attr_value, _valid_value)
      raise RuntimeError, I18n.t('errors.validations.property_value_not_positive_number',
        name: attr_name
      ) unless attr_value.to_f > 0
    end

    def validate_format(attr_name, attr_value, valid_value)
      raise AttributeError unless valid_value.instance_of? Regexp

      unless attr_value =~ valid_value
        raise RuntimeError, I18n.t('errors.validations.wrong_property_format',
          name: attr_name
        )
      end
    end

    def validate_type(attr_name, attr_value, valid_value)
      unless attr_value.is_a? valid_value
        raise RuntimeError, I18n.t('errors.validations.wrong_property_type',
          name: attr_name,
          klass: self.class,
          valid_type: valid_value,
          given_type: attr_value.class
        )
      end
    end
  end

  private

  def add_validator(attr_name, validator_name, valid_value)
    all_model_validators = instance_variable_get(:@validations) || {}

    single_attr_validators = all_model_validators[attr_name] || {}

    single_attr_validators[validator_name] = valid_value

    all_model_validators[attr_name] = single_attr_validators

    instance_variable_set(:@validations, all_model_validators)
  end

  def parse_args(args)
    attr_name = args[0]
    validator_name = args[1]
    validation_rule = (args.size == 3) ? args[2] : true

    [attr_name, validator_name, validation_rule]
  end

  def validate_method_proc
    proc do
      all_model_validators = self.class.instance_variable_get(:@validations)

      all_model_validators.each do |attr_name, single_attr_validators|
        single_attr_validators.each do |validator_name, valid_value|
          validator_function_name = "validate_#{validator_name}"

          attr_value = instance_variable_get(:"@#{attr_name}")

          send(validator_function_name, attr_name, attr_value, valid_value)
        end
      end
    end
  end

  def valid_method_proc
    proc do
      begin
        validate!
      rescue
        false
      end

      true
    end
  end
end
