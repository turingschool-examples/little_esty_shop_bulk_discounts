class NagerService

  def get_url
    response = HTTParty.get("https://date.nager.at/api/v3/PublicHolidays/2022/US")
    JSON.parse(response.body, symbolize_names: true)
  end
end
