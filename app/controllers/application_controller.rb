class ApplicationController < ActionController::Base
  before_action :holiday_data

  def holiday_data
    @holidays = HolidayFacade.new.upcoming_holidays
  end
end
