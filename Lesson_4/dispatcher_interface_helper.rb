module DispatcherInterfaceHelper
  def print_message(path, vars = {})
    puts get_message(path, vars)
  end

  def get_message(path, vars = {})
    message = path.inject(@messages, :fetch)
    message % vars
  end

  def generate_menu(menu_items)
    menu_items.each_pair do |command_key, command_description|
      puts "[#{command_key}] -- #{command_description}"
    end
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

  def flash_message(message, vars = {})
    return if message.nil?

    clear_console
    print_message message, vars
    sleep 1
  end

  def flash_error(message = %w(errors wrong_command), vars = {})
    flash_message message
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
    print_message(%w(interface button_back))
  end

  def print_exit_button
    print_message(%w(interface button_exit))
  end

  def print_delimiter
    puts '----'
  end

  def print_empty_line
    puts ''
  end
end
