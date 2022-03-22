class HolidayService 
  def self.conn
    Faraday.new(url: "https://date.nager.at/api/v3/NextPublicHolidays/")
  end

  def self.holidays(country)
    response = conn.get("#{country}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
