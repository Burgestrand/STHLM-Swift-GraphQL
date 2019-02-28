class Types::Uuid < GraphQL::Schema::Scalar
  Format = /^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-4[a-fA-F0-9]{3}-[8|9|aA|bB][a-fA-F0-9]{3}-[a-fA-F0-9]{12}$/

  description "A v4 UUID, transported as a string"

  def self.coerce_input(input_value, context)
    unless input_value.is_a?(String) && input_value.match?(Format)
      raise GraphQL::CoercionError, "#{input_value.inspect} is not a valid UUID"
    end

    input_value
  end

  def self.coerce_result(ruby_value, context)
    ruby_value.to_s
  end
end