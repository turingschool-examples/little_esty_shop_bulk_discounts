class HolidayFacade
  def self.next_3_upcoming_holidays
    results = HolidayService.next_3_upcoming_holidays
    
    results.map do |result|
      Holiday.new(result)
    end
  end
end