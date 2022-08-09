require 'date'

class NagerSearch


  def service
    NagerService.new
  end

  def holiday_list
    @_holidays = service.get_url.map do |h|
      if h[:date] > Date.today.to_s
        Holiday.new(h)
      end
    end.compact
  end

  def next_3_holidays
    holiday_list.first(3)
  end
end
