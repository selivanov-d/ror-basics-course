class CarriageToTakeSpaceSelectionController < ApplicationController
  PARENT_SCREEN = :carriage_action_selection

  def run
    if Carriage.find @@user_input
      carriage = Carriage.find @@user_input

      @@screen = :carriage_space_value_input_dialog
      @@action_vars = { carriage: carriage }
      @@screen_vars = { carriage: carriage }
    else
      flash_error
    end
  end
end
