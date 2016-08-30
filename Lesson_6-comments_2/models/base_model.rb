class BaseModel
  abstract_method :validate!

  def valid?
    validate!
    true
  rescue RuntimeError, ArgumentError
    false
  end
end