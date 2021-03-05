class Holiday
  def initialize(json_data)
    @data = json_data
  end

  def next_three_holidays
    holidays = ""

    @data.each do |holiday|
      holidays += "#{holiday[:name]}, #{holiday[:date]} "
    end
    holidays = holidays[0..-2]
  end
end
