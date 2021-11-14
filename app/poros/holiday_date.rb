class HolidayDate
  attr_reader :name, :date

  def initialize(holiday_hash)
    @name = holiday_hash[:name]
    @date = holiday_hash[:date]
  end
end
