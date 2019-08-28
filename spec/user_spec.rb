# frozen_string_literal: true

require './lib/user.rb'
require 'pg'

describe 'Creates a user' do
  it 'creates a new' do
    user = User.create(email: 'thing@thingy.com', password: 'password')
    connection = PG.connect(dbname: 'makersbnb_test')
    result = connection.exec("select * from users where email = 'thing@thingy.com'")
    expect(result[0]['email']).to eq('thing@thingy.com')
    expect(result[0]['password']).to eq('password')
  end
end
