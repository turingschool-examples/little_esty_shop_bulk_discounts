require 'httparty'

class HolidayService 
  def united_states
    get_url("/US")
  end
  
  def get_url(url)
    response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays#{url}")
    JSON.parse(response.body, symboilize_names: true)
  end
end