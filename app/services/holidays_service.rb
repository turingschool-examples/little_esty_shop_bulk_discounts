class HolidaysService

  def self.get_data
    connection = Faraday.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    parsed = JSON.parse(connection.body, symbolize_names: true )
  end

  def self.holidays
    get_data.map do |data|
      Holiday.new(data)
    end
  end
end
