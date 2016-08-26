require 'yaml'
require 'i18n'

messages_file = File.join(File.dirname(__FILE__), 'i18n', 'ru.yml')
messages = YAML.load_file(messages_file)

I18n.config.available_locales = :ru
I18n.locale = :ru
I18n.backend.store_translations(:ru , messages)

load 'modules/manufacturer.rb'
load 'modules/instance_counter.rb'

load 'helpers/views_helper.rb'
load 'helpers/translation_helper.rb'

load 'models/model.rb'
load 'models/train.rb'
load 'models/cargo_train.rb'
load 'models/passenger_train.rb'

load 'models/carriage.rb'
load 'models/cargo_carriage.rb'
load 'models/passenger_carriage.rb'

load 'models/station.rb'
load 'models/route.rb'

load 'views/views.rb'

load 'controllers/controller.rb'

di = ApplicationController.new

di.run