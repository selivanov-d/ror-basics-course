class Station < BaseModel
  include InstanceCounter

  NAME_FORMAT = /^[а-я]{3,50}$/i

  attr_reader :name, :trains_list

  validate :name, :format, NAME_FORMAT

  @@created = {}

  def initialize(name)
    @name = name

    @@created[self.name] = self

    @trains_list = {}

    validate!
  end

  def take_train_in(train)
    raise ArgumentError, I18n.t('station.error.message_wrong_train_type') unless train.is_a? Train

    @trains_list[train.number] = train
  end

  def remove_train(train)
    raise ArgumentError, I18n.t('station.error.message_wrong_train_type_to_delete') unless train.is_a? Train

    train.current_station = nil
    @trains_list.delete train.number

    train
  end

  def self.all
    @@created
  end

  def to_s
    @name
  end

  def each_train
    trains_list.each_value do |train|
      yield(train)
    end
  end
end
