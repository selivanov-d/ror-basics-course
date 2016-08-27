class BaseModel
  def valid?
    validate!
    true
  rescue RuntimeError, ArgumentError
    false
  end
end