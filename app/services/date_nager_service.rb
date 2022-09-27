class DateNagerService
  def self.get_holidays
    get_uri("https://date.nager.at/api/v3/NextPublicHolidays/us")
  end

  def self.get_uri(uri)
    response = HTTParty.get(uri)
    JSON.parse(response.body, symbolize_names: true)
  end

end