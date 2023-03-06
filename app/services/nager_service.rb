require 'httparty'

class NagerService
  def holidays
    response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/US?n=3")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed.map { |holiday| holiday[:name] }.first(3)
  end
end