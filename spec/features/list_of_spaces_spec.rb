# frozen_string_literal: true

require 'spec_helper'
require 'pg'

feature 'show list of spaces' do
  scenario 'list spaces' do
    visit '/user/index'
    click_button('Show spaces')
    expect(page).to have_content 'Avaliable Spaces'
  end
  scenario 'list spaces with title' do
    connection = PG.connect(dbname: 'makersbnb_test')

    connection.exec("INSERT INTO spaces (title) VALUES ('Cosy cottage in Cotswolds');")
    connection.exec("INSERT INTO spaces (title) VALUES ('4-bedroom flat in Belgravia');")
    connection.exec("INSERT INTO spaces (title) VALUES ('Studio flat in Central London');")
    visit '/user/index'
    click_button('Show spaces')
    expect(page).to have_content 'Cosy cottage in Cotswolds'
    expect(page).to have_content '4-bedroom flat in Belgravia'
    expect(page).to have_content 'Studio flat in Central London'
  end

  scenario 'list spaces with title' do
    connection = PG.connect(dbname: 'makersbnb_test')

    connection.exec("INSERT INTO spaces (title, description) VALUES ('Cosy cottage in Cotswolds', 'Really nice.');")
    connection.exec("INSERT INTO spaces (title, description) VALUES ('4-bedroom flat in Belgravia', 'Also really nice, and smells good.');")
    connection.exec("INSERT INTO spaces (title, description) VALUES ('Studio flat in Central London', 'Just ok.');")
    visit '/user/index'
    click_button('Show spaces')
    expect(page).to have_content 'Really nice.'
    expect(page).to have_content 'Also really nice, and smells good.'
    expect(page).to have_content 'Just ok.'
  end
end
