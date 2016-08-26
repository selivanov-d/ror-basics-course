class Model
  include TranslationHelper

  def valid?
    validate!
    true
  rescue *[RuntimeError, ArgumentError]
    false
  end
end