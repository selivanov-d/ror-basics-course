module TranslationHelper
  def get_message(message)
    key = message[:path].pop
    scope = message[:path]

    I18n.t(key, scope: scope)
  end

  def flash_message(message = {})
    return if message.empty?

    clear_console
    print_message(message)
    sleep 1
  end

  def print_message(message)
    if message.instance_of? String
      puts message
    elsif message.instance_of? Hash
      puts get_message(message)
    end
  end

  def flash_error(message = {path: [:errors, :default]})
    flash_message(message)
  end
end