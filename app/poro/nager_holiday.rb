class NagerHoliday
  attr_reader :holiday_name, :holiday_date

  def initialize(data)
    @holiday_name = data[:localName]
    @holiday_date = data[:date]
  end
end
