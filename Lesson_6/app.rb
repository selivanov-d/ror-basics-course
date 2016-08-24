require 'yaml'
require 'i18n'

messages_file = File.join(File.dirname(__FILE__), 'i18n', 'messages.yml')
messages = YAML.load_file(messages_file)

I18n.config.available_locales = :ru
I18n.locale = :ru
I18n.backend.store_translations(:ru , messages)

require_relative 'modules/validator'

require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'

require_relative 'models//train'
require_relative 'models/cargo_train'
require_relative 'models/passenger_train'
require_relative 'models/carriage'
require_relative 'models/cargo_carriage'
require_relative 'models/passenger_carriage'
require_relative 'models/station'
require_relative 'models/route'


require_relative 'interface/station_interface'
require_relative 'interface/train_interface'

require_relative 'interface/views_controller_helper'
require_relative 'views/views_controller'
require_relative 'interface/controller'


di = Controller.new

di.run