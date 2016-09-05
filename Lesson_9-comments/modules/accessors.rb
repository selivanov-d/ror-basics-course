module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      attr_name = "@#{name}".to_sym
      attr_with_history_name = "@#{name}_history".to_sym

      define_method("#{name}=") do |value|
        instance_variable_set(attr_name, value)

        history = send("#{name}_history") || []
        history << value
        instance_variable_set(attr_with_history_name, history)
      end

      define_method(name) do
        instance_variable_get(attr_name)
      end

      define_method("#{name}_history") do
        instance_variable_get(attr_with_history_name)
      end
    end
  end

  def strong_attr_accessor(validation_pair)
    validation_pair.each do |attr_name, valid_value|
      attr_name_symbol = "@#{attr_name}".to_sym

      define_method("#{attr_name}=") do |value|
        raise ArgumentError, I18n.t('errors.validations.wrong_property_type',
          name: attr_name,
          klass: self.class,
          valid_type: valid_value,
          given_type: value.class
        ) unless value.instance_of? valid_value

        instance_variable_set(attr_name_symbol, value)
      end

      define_method(attr_name_symbol) do
        instance_variable_get(attr_name_symbol)
      end
    end
  end
end
