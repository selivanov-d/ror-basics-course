class CarriageSpaceValueInputDialogController < ApplicationController
  PARENT_SCREEN = :carriage_to_take_space_selection

  def run
    carriage = @@action_vars[:carriage]

    case carriage.type
    when I18n.t('carriage.cargo.type')
      carriage.take_space(@@user_input)

      flash_message(I18n.t('carriage.cargo.interface.space_taken'))
    when I18n.t('carriage.passenger.type')
      carriage.take_seats(@@user_input)

      flash_message(I18n.t('carriage.passenger.interface.seats_taken'))
    end

    @@screen = :carriage_to_take_space_selection
  end
end
