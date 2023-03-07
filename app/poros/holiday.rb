class Holiday
  attr_reader :name,
              :date

  def initialize(data)
    # require 'pry'; binding.pry
    @name = data[:name]
    @date = data[:date]
  end
end