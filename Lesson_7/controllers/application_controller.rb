class ApplicationController
  include Views

  @@screen = :main_screen
  @@screens = {}
  @@action_vars = {}
  @@user_input = nil

  def run
    @@route = Route.new(Station.new('Москва'), Station.new('Петушки')) # fake route

    flash_message(I18n.t('interface.intro'))

    begin
      loop do
        clear_console

        controller = class_from_screen_name

        render @@screen

        @@user_input = user_command

        if @@user_input == I18n.t('interface.command.back') && @@screen != :main_screen
          @@screen = controller::PARENT_SCREEN
          next
        end

        @@screens[@@screen] ||= controller.new
        @@screens[@@screen].run
      end

    rescue RuntimeError, ArgumentError => e
      flash_error(e.message)
      retry
    end
  end

  # фэйковый, в сущности, метод, который возвращает все станции единственного маршрута аппликации
  def stations
    @@route.stations_list
  end

  private

  def abort_application
    abort I18n.t('interface.exit')
  end

  def user_command
    gets.chomp
  end

  def class_from_screen_name
    controller = @@screen.to_s.split('_').map!(&:capitalize).join
    Object.const_get("#{controller}Controller")
  end
end
