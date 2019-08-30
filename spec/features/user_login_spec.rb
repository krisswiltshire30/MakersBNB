# frozen_string_literal: true

require 'pg'
require 'spec_helper'

feature 'find user in database' do
  scenario 'signing up' do
    visit '/'
    click_button 'Sign up'
    fill_in 'email', with: 'steve@steve.com'
    fill_in 'password', with: 'password'
    fill_in 'password_confirmation', with: 'password'
    click_button 'Sign up'
    fill_in 'email', with: 'steve@steve.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
    expect(page).to have_content('Hello, steve@steve.com')
  end
end
