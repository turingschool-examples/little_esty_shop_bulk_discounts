class HolidayService
  def self.holiday_info(country_code)
    response = Faraday.get "https://date.nager.at/api/v3/NextPublicHolidays/#{country_code}"
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end
end
