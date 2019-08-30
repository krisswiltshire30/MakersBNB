require_relative '../../lib/user.rb'
feature 'authentication' do
  scenario 'a user sees an error if they get their email wrong' do
    User.create(email: 'test@example.com', password: 'password123')
    visit '/'
    click_button 'Sign up'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    fill_in 'password_confirmation', with: 'password123'
    click_button 'Sign up'
    fill_in 'email', with: 'steve@steve.com'
    fill_in 'password', with: 'password'
    click_button 'Login'


    expect(page).to have_content 'Please check your email or password.'
  end
  scenario 'a user sees an error if they get their password wrong' do
    visit '/'
    click_button 'Sign up'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    fill_in 'password_confirmation', with: 'password123'
    click_button 'Sign up'
    fill_in 'email', with: 'steve@steve.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
    expect(page).to have_content 'Please check your email or password.'
  end
end