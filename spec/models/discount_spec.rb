require 'rails_helper'

describe Discount, type: :model do
  it 'relationship' do
    it { should belong_to(:merchant) }
  end
end
