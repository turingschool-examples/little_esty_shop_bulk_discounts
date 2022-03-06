class Holiday
  attr_reader :name,
              :date

  def initialize(data)
  	@name = data[:localName]
	  @date = format_date(data[:date])
  end

  def format_date(date_string)
    date_format = Time.parse(date_string)
    date_format.strftime("%A, %B %d, %Y")
  end

  def self.get(data)
    data.map {|data| Holiday.new(data)}
  end
end
