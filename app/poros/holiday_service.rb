require 'httparty'

class HolidayService 


  def get_url(url)

    response = HTTParty.get(url, headers: { })
  end
end