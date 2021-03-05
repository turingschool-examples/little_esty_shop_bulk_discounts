class HolidayService < ApiService
  def self.get_dates
    holidays = "https://date.nager.at/Api/v2/NextPublicHolidays/us"
    data = get_data(holidays)
    data = data[0..2]
    holidays = data.map do |date|
      Holiday.new(date)
    end
  end
end