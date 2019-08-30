require_relative '../../lib/request.rb'
require_relative '../../lib/user.rb'
require_relative '../../lib/spaces.rb'
feature 'booking' do

  scenario 'user can book a space' do

    User.create(email: 'test@example.com', password: 'password123')
    visit '/'
    click_button 'Sign up'
    fill_in 'email', with: 'host@example.com'
    fill_in 'password', with: 'password123'
    fill_in 'password_confirmation', with: 'password123'
    click_button 'Sign up'
    fill_in 'email', with: 'host@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Login'
    click_button 'Add space'
    fill_in 'title', with: 'Nice flat'
    fill_in 'description', with: 'very good flat'
    fill_in 'price_per_night', with: 45.00
    click_button 'add'
    click_button 'Logout'
    click_button 'Sign up'
    fill_in 'email', with: 'guest@example.com'
    fill_in 'password', with: 'password1231'
    fill_in 'password_confirmation', with: 'password1231'
    click_button 'Sign up'
    fill_in 'email', with: 'guest@example.com'
    fill_in 'password', with: 'password1231'
    click_button 'Login'
    click_button 'Show spaces'
    click_button 'Book'
    expect(page).to have_content 'Request was sent.'
  end
end