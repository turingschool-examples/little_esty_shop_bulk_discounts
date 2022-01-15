require 'rails_helper'

describe Discount do
  describe 'relationship' do
    it { should belong_to :merchant }
    # discount has_many items ( discount can be applied to all merchant items )
    # item_discounts belongs to item ( will need a discount items joins table )
    # item_discount belongs to discount
  end
end
