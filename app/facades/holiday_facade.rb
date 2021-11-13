class HolidayFacade
  def self.create_holidays
    json = NagerDateService.get_three_upcoming_holidays

    json.map do |data|
      HolidayDate.new(data)
    end
  end
end
