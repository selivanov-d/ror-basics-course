require 'yaml'
require 'i18n'
require 'abstract_method'

I18n.load_path = Dir["#{__dir__}/i18n/*.yml"]
I18n.config.available_locales = :ru
I18n.locale = :ru

require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'

require_relative 'helpers/views_helper'

require_relative 'models/base_model'
require_relative 'models/train'
require_relative 'models/train/cargo_train'
require_relative 'models/train/passenger_train'

require_relative 'models/carriage'
require_relative 'models/carriage/cargo_carriage'
require_relative 'models/carriage/passenger_carriage'

require_relative 'models/station'
require_relative 'models/route'

require_relative 'views/views'

require_relative 'controllers/application_controller'
require_relative 'controllers/existing_trains_selection_controller'
require_relative 'controllers/main_screen_controller'
require_relative 'controllers/new_train_creation_dialog_controller'
require_relative 'controllers/new_train_type_selection_controller'
require_relative 'controllers/station_action_selection_controller'
require_relative 'controllers/station_creation_dialog_controller'
require_relative 'controllers/stations_list_controller'
require_relative 'controllers/stations_list_selection_controller'
require_relative 'controllers/train_action_selection_controller'
require_relative 'controllers/train_actions_screen_controller'
require_relative 'controllers/train_move_to_station_dialog_controller'
require_relative 'controllers/trains_on_station_list_controller'

app = ApplicationController.new
app.run