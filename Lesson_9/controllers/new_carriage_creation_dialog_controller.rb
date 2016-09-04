class NewCarriageCreationDialogController < ApplicationController
  PARENT_SCREEN = :carriage_action_selection

  def run
    train = @@action_vars[:train]

    case train
    when Train::CargoTrain
      carriage = Carriage::CargoCarriage.new(@@user_input)
    when Train::PassengerTrain
      carriage = Carriage::PassengerCarriage.new(@@user_input)
    end

    train.add_carriage(carriage)

    flash_message(I18n.t('train.interface.message_carriage_added'))

    @@screen = :carriage_action_selection
  end
end
