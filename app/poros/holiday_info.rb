class HolidayInfo
  attr_reader :next_three, :info
  def initialize(country_code)
    holiday_data = HolidayService.holiday_info(country_code)
    @next_three = holiday_data.first(3)
    @info = @next_three.map do |holiday|
      holiday.values_at(:localName, :date)
    end
  end
end
