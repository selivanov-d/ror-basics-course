class Model
  include TranslationHelper

  def valid?
    validate!
  end
end