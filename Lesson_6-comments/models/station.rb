class Station < Model
  include InstanceCounter

  attr_reader :name, :trains_list

  NAME_FORMAT = /^[а-я]{3,50}$/i

  @@created = {}

  def initialize(name)
    @name = name

    validate!

    @@created[self.name] = self

    @trains_list = {}
  end

  def take_train_in(train)
    raise ArgumentError.new(get_message({path: [:station, :error, :message_wrong_train_type]})) unless train.is_a? Train

    @trains_list[train.number] = train
  end

  def remove_train(train)
    raise ArgumentError.new(get_message({path: [:station, :error, :message_wrong_train_type_to_delete]})) unless train.is_a? Train

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

  private
  def validate!
    if (@name =~ NAME_FORMAT) == nil
      raise ArgumentError.new(get_message({path: [:station, :validation, :wrong_name_format]}))
    end
  end
end
