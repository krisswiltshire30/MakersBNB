# frozen_string_literal: true

feature 'user can sign up for makersbnb' do
  scenario 'user can input user details' do
    visit '/'
    click_button 'Sign up'
    fill_in 'email', with: 'steve@steve.com'
    fill_in 'password', with: 'password'
    fill_in 'password_confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Log in to MakersBNB')
  end
end
