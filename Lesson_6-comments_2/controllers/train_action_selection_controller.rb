class TrainActionSelectionController < ApplicationController
  PARENT_SCREEN = :main_screen

  def run
    case @@user_input
      when '1'
        @@screen = :new_train_type_selection
      when '2'
        if Train.all.size > 0
          @@screen = :existing_trains_selection
        else
          flash_error(I18n.t('train.interface.message_no_trains_exists'))
        end
      else
        flash_error
    end
  end
end