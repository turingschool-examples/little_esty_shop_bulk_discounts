class HolidayService < ApiService
  def self.get_holidays
    endpoint = 'https://date.nager.at/Api/v2/NextPublicHolidays/us'
    parsed_json = get_data(endpoint)
    three_holidays = parsed_json[0..2]
    three_holiday_hashes = three_holidays.map do |holiday_hash|
      Holiday.new(holiday_hash)
    end
  end
end
