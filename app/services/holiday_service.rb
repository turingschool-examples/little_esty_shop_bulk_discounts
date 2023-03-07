require 'faraday'

class HolidayService
  def self.parse_api
    response = connection.get
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    url = "https://date.nager.at/api/v3/NextPublicHolidays/US"
    Faraday.new(url: url)
  end
end