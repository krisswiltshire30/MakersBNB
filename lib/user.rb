# frozen_string_literal: true

require 'pg'
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

    result = connection.exec("INSERT INTO users (email, password) VALUES ('#{email}','#{password}') RETURNING email,password ")
  end
end
