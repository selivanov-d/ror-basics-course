require 'yaml'
require 'i18n'

I18n.load_path = File.expand_path('i18n', __FILE__)
I18n.config.available_locales = :ru
I18n.locale = :ru

require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'

require_relative 'helpers/views_helper'
require_relative 'helpers/translation_helper'

require_relative 'models/model'
require_relative 'models/train'
require_relative 'models/cargo_train'
require_relative 'models/passenger_train'
require_relative 'models/carriage'
require_relative 'models/cargo_carriage'
require_relative 'models/passenger_carriage'
require_relative 'models/station'
require_relative 'models/route'

require_relative 'views/views'
require_relative 'controllers/controller'

di = ApplicationController.new

di.run