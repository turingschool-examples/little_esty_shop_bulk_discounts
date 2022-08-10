class Holiday
  attr_accessor :name, :date
  def initialize(data)
    @name = data[:name]
    @date = data[:date]
  end
end
