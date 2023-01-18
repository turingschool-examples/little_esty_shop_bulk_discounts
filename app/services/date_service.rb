require 'httparty'

class DateService
  def self.next_three_holidays
    response = HTTParty.get 'https://date.nager.at/api/v2/NextPublicHolidays/us'
    holidays = []
    response.each do |holiday| 
      holidays << holiday["name"]
    end
    holidays[0..2]
  end
end