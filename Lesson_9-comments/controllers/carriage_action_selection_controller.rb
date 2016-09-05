class CarriageActionSelectionController < ApplicationController
  PARENT_SCREEN = :main_screen

  def run
    case @@user_input
    when '1'
      if Train.all.any?
        @@screen = :train_to_add_carriage_selection
      else
        flash_error(I18n.t('train.interface.message_no_trains_exists'))
      end
    when '2'
      if Train.all.any?
        @@screen = :train_to_remove_carriage_selection
      else
        flash_error(I18n.t('train.interface.message_no_trains_exists'))
      end
    when '3'
      if Carriage.all.any?
        @@screen = :train_carriages_list
      else
        flash_error(I18n.t('carriage.interface.message_no_carriages_exists'))
      end
    when '4'
      if Carriage.all.any?
        @@screen = :carriage_to_take_space_selection
      else
        flash_error(I18n.t('carriage.interface.message_no_carriages_exists'))
      end
    else
      flash_error
    end
  end
end
