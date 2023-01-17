class Holiday

  attr_reader :name,
              :date,
              :country_code

  def initialize(data)
    @name = data[:localName]
    @date = data[:date]
    @country_code = data[:countryCode]
  end
end