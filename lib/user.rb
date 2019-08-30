# frozen_string_literal: true

require 'pg'
require 'bcrypt'
class User
  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end

  def self.create(email:, password:)
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'makersbnb_test')
                 else
                   PG.connect(dbname: 'makersbnb')
                 end
    encrypt_password = BCrypt::Password.create(password)
    result = connection.exec("INSERT INTO users (email, password) VALUES ('#{email}','#{encrypt_password}') RETURNING email, id ")
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.authenticate(email:, password:)
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'makersbnb_test')
                 else
                   PG.connect(dbname: 'makersbnb')
                 end
    result = connection.exec("SELECT * FROM users WHERE email = '#{email}'")
    return if result.nil?
    return unless BCrypt::Password.new(result[0]['password']) == password
    return unless result[0]['email']== email
    User.new(id: result[0]['id'], email: result[0]['email'])
  end
end
