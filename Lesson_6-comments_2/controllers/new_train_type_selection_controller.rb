class NewTrainTypeSelectionController < ApplicationController
  PARENT_SCREEN = :train_action_selection

  def run
    case @@user_input
      when '1'
        @@screen = :new_train_creation_dialog
        @@action_vars = {type: :passenger_train}
      when '2'
        @@screen = :new_train_creation_dialog
        @@action_vars = {type: :cargo_train}
      else
        flash_error
    end
  end
end