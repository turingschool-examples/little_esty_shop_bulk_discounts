class NagerService 

  def self.fetch_api
    response = connection.get
    # require 'pry'; binding.pry
    x = JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    url = "https://date.nager.at/api/v3/NextPublicHolidays/US"
    Faraday.new(url: url)
  end
end