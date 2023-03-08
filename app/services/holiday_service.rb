class HolidayService
  def self.conn
    Faraday.new("https://date.nager.at")
  end

  def self.next_3_upcoming_holidays
    response = conn.get("/api/v3/NextPublicHolidays/US")
    JSON.parse(response.body, symbolize_names: true)[0..2]
  end
end