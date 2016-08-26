require 'yaml'
require 'i18n'

# можно было бы загружать файлы из определённой директории через метод I18n.load_path, но что-то у меня не получилось.
messages_file = File.join(File.dirname(__FILE__), 'i18n', 'ru.yml')
messages = YAML.load_file(messages_file)

I18n.config.available_locales = :ru
I18n.locale = :ru
I18n.backend.store_translations(:ru , messages)

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

app = ApplicationController.new
app.run