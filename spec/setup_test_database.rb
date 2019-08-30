# frozen_string_literal: true

require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test') 
  connection.exec('TRUNCATE spaces, users, requests RESTART identity;')
end
