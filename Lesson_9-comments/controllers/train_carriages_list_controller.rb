class TrainCarriagesListController < ApplicationController
  PARENT_SCREEN = :carriage_action_selection

  def run
    if Train.all.any?
      train = Train.find @@user_input

      if train
        if train.carriages.any?
          @@screen_vars = { train: train }
          @@screen = :carriages_in_train
        else
          flash_message(I18n.t('train.interface.message_no_carriages_in_this_train'))
        end
      else
        flash_message(I18n.t('train.interface.message_no_such_train'))
      end
    else
      flash_error(I18n.t('train.interface.message_no_trains_exists'))
    end
  end
end
