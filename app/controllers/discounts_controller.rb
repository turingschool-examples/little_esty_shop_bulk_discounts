class DiscountsController < ApplicationController
  def index
    @holidays = HolidayFacade.create_holidays
  end
end
