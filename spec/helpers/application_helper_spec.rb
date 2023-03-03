require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe 'display_percent_off(percentage_discount)' do

    it 'should format the percent discount as a percent' do

      expect(float_to_percent(0.25)).to eq('25%')
      expect(float_to_percent(0.50)).to eq('50%')
    end
  end
end