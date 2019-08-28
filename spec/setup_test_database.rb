require 'pg'



def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE spaces RESTART identity;")
  connection.exec("TRUNCATE requests RESTART identity;")
end
