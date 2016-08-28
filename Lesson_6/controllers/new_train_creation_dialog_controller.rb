class NewTrainCreationDialogController < ApplicationController
  PARENT_SCREEN = :new_train_type_selection

  def run
    case @@action_vars[:type]
      when :passenger_train
        train = Train::PassengerTrain.new(@@user_input)
      when :cargo_train
        train = Train::CargoTrain.new(@@user_input)
    end

    train.route = @@route

    flash_message(I18n.t('train.interface.message_train_created_successfully', train_type: train.type, train_number: train.number))

    @@screen = :train_actions_screen
    @@screen_vars = {train_number: train.number}
    @@action_vars = {train: train}
  end
end