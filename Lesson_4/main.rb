require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_train'
require_relative 'passenger_train'

require_relative 'interface_helper'
require_relative 'train_interface'
require_relative 'station_interface'

require_relative 'dispatcher_interface'

interface = DispatcherInterface.new
interface.run
