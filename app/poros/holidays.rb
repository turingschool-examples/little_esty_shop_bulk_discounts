class Holidays
  attr_reader :data, :holiday_first, :holiday_second, :holiday_third

  def initialize(data)
    @data = data
    @holiday_first = @data[0]
    @holiday_second = @data[1]
    @holiday_third = @data[2]
  end
end
