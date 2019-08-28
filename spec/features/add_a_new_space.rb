require 'spec_helper'
 require 'pg'

feature 'add new space' do
  scenario 'add space' do
    visit '/'
    click_button('Add Space')
    fill_in 'title', with: 'Studio in Clapham'
    fill_in 'description', with: 'super cheap and nice flat near tube station'
    fill_in 'price_per_night', with: 45.00
    click_button 'add'
    expect(page).to have_content 'Studio in Clapham'
    expect(page).to have_content 'super cheap and nice flat near tube station'
    expect(page).to have_content "45.00"
  end



end
