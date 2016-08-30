class StationsListController < ApplicationController
  PARENT_SCREEN = :station_action_selection

  def run
    flash_error
  end
end