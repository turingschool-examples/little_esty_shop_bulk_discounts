class HolidayService
  def self.get_holidays
    response = Faraday.get("https://date.nager.at/Api/v2/NextPublicHolidays/us")
    parsed = JSON.parse(response.body, symbolize_names: true)
    holidays = parsed.map do |data|
      Holiday.new(data)
    end
    holidays[0..2]
  end
end
