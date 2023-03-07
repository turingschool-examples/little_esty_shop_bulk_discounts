class HolidayService
  def self.conn
    Faraday.new("https://date.nager.at") #connects base API (allows use of http verbs)
  end

  def self.next_3_upcoming_holidays
    response = conn.get("/api/v3/NextPublicHolidays/US") #selecting a specific endpoint from the base
    JSON.parse(response.body, symbolize_names: true)[0..2] #parses the response as a hash
    
  end
end