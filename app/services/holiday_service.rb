class HolidayService
  def self.connection
    Faraday.new('https://date.nager.at/api/v3/NextPublicHolidays/us')
  end

  def self.find_holiday
    response = connection.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
