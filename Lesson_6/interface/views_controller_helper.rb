module ViewsControllerHelper
  def generate_menu(menu_items)
    menu_items.each_pair do |command_key, command_description|
      puts "[#{command_key}] -- #{command_description}"
    end
  end

  def print_message(message_key, scope)
    puts I18n.t(message_key, scope: scope)
  end

  def print_exit_button_and_prompt
    print_delimiter
    print_exit_button
    print_empty_line
    print_prompt
  end

  def print_back_button_and_prompt
    print_delimiter
    print_back_button
    print_empty_line
    print_prompt
  end

  def flash_message(message_key, scope)
    return if message_key.nil?

    clear_console
    print_message(message_key, scope)
    sleep 1
  end

  def flash_error(message_key = :default, scope = [:errors])
    flash_message(message_key, scope)
  end

  # решение с очисткой консоли бессовестно нагуглил :)
  # see -- http://stackoverflow.com/questions/3170553/how-can-i-clear-the-terminal-in-ruby
  def clear_console
    system 'clear' or system 'cls'
  end

  private
  def print_prompt
    print '> '
  end

  def print_back_button
    print_message(:button_back, [:interface])
  end

  def print_exit_button
    print_message(:button_exit, [:interface])
  end

  def print_delimiter
    puts '----'
  end

  def print_empty_line
    puts ''
  end
end
