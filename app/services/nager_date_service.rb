class NagerDateService
  def self.get_three_upcoming_holidays
    holiday_json[0..2]
  end
  #dont need parameters/initialize because we are only accessing a static endpoint
  private
  def self.connection
    Faraday.new('https://date.nager.at/api/v2/NextPublicHolidays/US') do |faraday|
      faraday.adapter Faraday.default_adapter
      # used get request to get the data. new is default nothing. faraday adapter does the shit
    end
  end
  def self.holiday_json
    #calls connection method
    response = connection.get
    #returns response
    JSON.parse(response.body, symbolize_names: true)
  end
end
