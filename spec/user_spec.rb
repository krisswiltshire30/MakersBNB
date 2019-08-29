# frozen_string_literal: true

require './lib/user.rb'
require 'pg'
require 'bcrypt'

describe 'Creates a user' do
  it 'creates a new' do
    user = User.create(email: 'thing@thingy.com', password: 'password')
    connection = PG.connect(dbname: 'makersbnb_test')
    result = connection.exec("select * from users where email = 'thing@thingy.com'")
    expect(result[0]['email']).to eq('thing@thingy.com')
  end

  it 'use bcrypt to encrypt password' do
    expect(BCrypt::Password).to receive(:create).with('password123')

    User.create(email: 'test@test.com', password: 'password123')
  end
end
