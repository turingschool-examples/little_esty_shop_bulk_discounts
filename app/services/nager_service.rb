class NagerService
  def self.holiday_info
    response = Faraday.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.next_three_holidays
    holiday = holiday_info.map do |info|
      NagerHoliday.new(info)
    end
    holiday[0..2]
  end
end
