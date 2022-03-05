class Holiday
  attr_reader :name, :date

  def initialize(data)
    @name = data[:name]
    @date = data[:date]
  end

  def self.date_format
    @date.strftime('%B %d, %Y')
  end
end
