require 'httparty'
class NagerService
  def self.holidays
    response = HTTParty.get('https://date.nager.at/api/v3/NextPublicHolidays/US')
    body = response.body

    parse = JSON.parse(body, symbolize_names: true)
  end
end
