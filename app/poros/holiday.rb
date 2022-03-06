require 'time'
class Holiday
  attr_reader :name, :date

  def initialize(data)
    @name = data[:name]
    @date = data[:date]
  end

  def date_format
    Date.parse(@date).strftime('%B %d, %Y')
  end
end
