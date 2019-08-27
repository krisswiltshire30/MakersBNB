 require 'spec_helper'
 require 'pg'

feature 'show list of spaces' do
  scenario 'list spaces' do
    visit '/'
    click_button('Show Spaces')
    expect(page).to have_content "Avaliable Spaces"
  end
  scenario 'list spaces with title' do
    connection = PG.connect(dbname: 'makersbnb_test')

    connection.exec("INSERT INTO spaces (title) VALUES ('Cosy cottage in Cotswolds');")
    connection.exec("INSERT INTO spaces (title) VALUES ('4-bedroom flat in Belgravia');")
    connection.exec("INSERT INTO spaces (title) VALUES ('Studio flat in Central London');")
    visit '/'
    click_button('Show Spaces')
    expect(page).to have_content "Cosy cottage in Cotswolds"
    expect(page).to have_content "4-bedroom flat in Belgravia"
    expect(page).to have_content "Studio flat in Central London"
  end
end