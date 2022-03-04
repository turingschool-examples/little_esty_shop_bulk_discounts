class HolidayService
  def get_url(url)
    response = HTTParty.get("https://date.nager.at#{url}")
    data = JSON.parse(response.body, symbolize_names: true)
  end

  def upcoming_us_holidays
    holidays = get_url("/api/v2/NextPublicHolidays/US")
    holidays[0..2]
  end
end
