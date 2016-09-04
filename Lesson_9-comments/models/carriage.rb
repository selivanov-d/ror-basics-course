class Carriage < BaseModel
  NUMBER_FORMAT = /^[\d\w]{4}$/

  include Manufacturer

  attr_reader :number

  @@created = {}

  def initialize
    @number = generate_number

    @@created[@number] = self

    validate!
  end

  def self.find(number)
    @@created[number]
  end

  def self.all
    @@created
  end

  def self.each_created
    @@created.each_value do |carriage|
      yield(carriage)
    end
  end

  private

  def generate_number
    rand(36**4).to_s(36)
  end
end
