class NagerFacade
    def self.holidays
      parsed = NagerService.holidays
      parsed[0..2].map do |data|
        Holiday.new(data)
    end
  end
end
