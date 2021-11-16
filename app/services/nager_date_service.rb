class NagerDateService
  def self.get_three_upcoming_holidays
    holiday_json[0..2]
    #get first 3 holidays
  end
  #dont need parameters/initialize because we are only accessing a static endpoint
  private
  def self.connection
    Faraday.new('https://date.nager.at/api/v2/NextPublicHolidays/US')
    #establishing connection and gets request
  end
  def self.holiday_json
    response = connection.get
    #calls connection method
    JSON.parse(response.body, symbolize_names: true)
    #returns response by turning into ruby like object
  end
end
