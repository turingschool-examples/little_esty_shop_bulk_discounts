class HolidayFacade #responsible for building POROS(Plain Old Ruby Objects) that reflect the portions of the API data
  def self.next_3_upcoming_holidays
    results = HolidayService.next_3_upcoming_holidays #call on the service
    
    results.map do |result| # PORO Creation
      Holiday.new(result)
    end
  end
end