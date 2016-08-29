class MainScreenController < ApplicationController
  def run
    abort_application if @@user_input == I18n.t('interface.command.exit')

    case @@user_input
    when '1'
      @@screen = :train_action_selection
    when '2'
      @@screen = :station_action_selection
    when '3'
      @@screen = :carriage_action_selection
    else
      flash_error
    end
  end
end
