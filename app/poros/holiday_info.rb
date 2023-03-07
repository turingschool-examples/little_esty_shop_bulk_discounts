class HolidayInfo
  attr_reader :holiday_name, 
              :holiday_date

  def initialize(info)
    @holiday_name = info[0]
    @holiday_date = info[1]
  end
end