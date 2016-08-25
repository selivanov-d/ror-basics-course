module ViewsHelper
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

  def clear_console
    system 'clear' or system 'cls'
  end

  private
  def print_prompt
    print '> '
  end

  def print_back_button
    print_message({path: [:interface, :button_back]})
  end

  def print_exit_button
    print_message({path: [:interface, :button_exit]})
  end

  def print_delimiter
    puts '----'
  end

  def print_empty_line
    puts ''
  end
end
