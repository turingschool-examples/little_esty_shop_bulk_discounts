class ApplicationController < ActionController::Base
  before_action :holidays

  def holidays
    @holidays ||= HolidayService.get_holidays
  end
end
