class HolidayFacade
  def self.info
    get_holiday_name_and_date.map do |holiday|
      HolidayInfo.new(holiday)
    end
  end

  def self.get_holiday_name_and_date
    holiday_name_date = HolidayService.parse_api
    holiday_name_date[0..2].map do |holiday|
      [holiday[:name], holiday[:date]]
    end
  end
end