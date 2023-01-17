class HolidaysFacade
  def self.next_holidays
    json = HolidaysService.next_us_holidays
    json.map.with_index do |data|
      Holiday.new(data)
    end
  end

  def self.next_3_holidays
    next_holidays.first(3)
  end
end