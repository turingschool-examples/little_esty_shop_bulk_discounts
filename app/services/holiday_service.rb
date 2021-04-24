class HolidayService
  def self.get_holidays
    resp = Faraday.get 'https://date.nager.at/Api/v2/NextPublicHolidays/US'
    json_array = JSON.parse(resp.body, { symbolize_names: true })

    json_array.map do |holiday|
      holiday[:localName]
    end
  end
end