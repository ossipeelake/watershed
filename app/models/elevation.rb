class Elevation
  include ActiveModel::Serialization

  attr_reader :date, :value

  def initialize(attributes)
    @date = attributes[:date]
    @value = attributes[:value]
  end

  def self.all
    elevations = ElevationService.fetch(1.month.ago, Date.tomorrow)
    elevations.map { |e| self.new(e) }
  end
end
