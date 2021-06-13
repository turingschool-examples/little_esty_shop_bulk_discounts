# <h3>Upcomming Holidays</h3>
# <% @holidays.each do |holiday| %>
# <%= holiday[:localName]%>
# <%= holiday[:date]%>
# <% end %>
#
# index test
# it 'has holiday info' do
#
#   visit "/bulk_discounts"
#   expect(page).to have_content("Upcomming Holidays")
#   # expect(page).to have_content()
# end
#
# for the index page: @holidays = HolidayService.public_holidays[0..2]
