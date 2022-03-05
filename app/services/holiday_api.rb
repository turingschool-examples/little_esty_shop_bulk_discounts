class HolidayApi

  def conn 
    Faraday.new(url: "https://date.nager.at")
  end

  def upcoming_holidays(count)
    resp = conn.get("api/v3/NextPublicHolidays/US")
    json = JSON.parse(resp.body, symbolize_names: true)
    json[0...count]
  end
end