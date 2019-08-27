 require 'spec_helper'

feature 'show list of spaces' do
  scenario 'list spaces' do
    visit '/'
    click_button('Show Spaces')
    expect(page).to have_content "Avaliable Spaces"
  end 
end 