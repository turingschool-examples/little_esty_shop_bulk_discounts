class DiscountsController < ApplicationController
  def index
    @discounts = Discount.all
    @holidays = HolidayFacade.create_holidays
  end

  def show
  end
end
