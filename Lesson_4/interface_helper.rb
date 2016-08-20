module InterfaceHelper
  COMMANDS = {
      back: 'back',
      exit: 'exit'
  }

  def self.generate_menu(menu_items)
    menu_items.each_pair do |command_key, command_description|
      puts "[#{command_key}] -- #{command_description}"
    end
  end

  def self.print_exit_button_and_prompt
    print_delimiter
    print_exit_button
    print_empty_line
    print_prompt
  end

  def self.print_back_button_and_prompt
    print_delimiter
    print_back_button
    print_empty_line
    print_prompt
  end

  def self.flash_message(message)
    return if message.nil?

    clear_console
    puts message
    sleep 1
  end

  def self.flash_error(message = 'Неправильная команда!')
    flash_message message
  end

  # решение с очисткой консоли бессовестно нагуглил :)
  # see -- http://stackoverflow.com/questions/3170553/how-can-i-clear-the-terminal-in-ruby
  def self.clear_console
    system 'clear' or system 'cls'
  end

  # в принципе, ничего страшного в том, чтобы оставить эти методы публичными я не вижу, но, раз уж они не используются нигде, кроме более "высоких" методов типа InterfaceHelper.print_exit_button_and_prompt, решил их спрятать

  # не очень понимаю, как это работает, но нашёл такое решения, когда хотел сделать приватные методы класса
  class << self
    private
    def print_prompt
      print '> '
    end

    def print_back_button
      puts '[back] -- Вернуться назад'
    end

    def print_exit_button
      puts '[exit] -- Выйти из программы'
    end

    def print_delimiter
      puts '----'
    end

    def print_empty_line
      puts ''
    end
  end
end
