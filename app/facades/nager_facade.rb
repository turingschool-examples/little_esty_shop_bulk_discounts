require './app/poros/holiday'
require './app/services/nager_service'

class NagerFacade
  def holidays
    service.holidays
  end

  private

  def service
    NagerService.new
  end
end