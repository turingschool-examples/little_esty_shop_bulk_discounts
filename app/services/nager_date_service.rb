require 'faraday'
require 'json'

class NagerDateService

  def conn
    Faraday.new(
      url: 'https://date.nager.at/swagger/index.html',
      headers: {
        accept: 'application/json'
       }
    )
  end

  def get_upcoming_holidays
    resp = conn.get("https://date.nager.at/Api/v2/NextPublicHolidays/US")
    holidays = JSON.parse(resp.body, symbolize_names: true).map do |holiday|
      holiday[:name]
    end
  end
end
