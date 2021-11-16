class HolidayFacade
  def self.create_holidays
    json = NagerDateService.get_three_upcoming_holidays

    json.map do |data|
      HolidayDate.new(data)
    end
    #abstracting by showing instance variables
    #abstracting out by creating poros through a facade instead of putting the service in the controller.
  end
end
