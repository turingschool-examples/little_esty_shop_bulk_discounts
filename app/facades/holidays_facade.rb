class HolidaysFacade

  def self.holidays
    json = HolidaysService.get_data
    json[0..2].map do |data|
      Holiday.new(data)
    end
  end
end
