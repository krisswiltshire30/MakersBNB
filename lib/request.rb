require 'pg'

class Request

  def self.create(property_id, owner_id, requester_id)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

    sql = "INSERT INTO requests (property_id, owner_id, requester_id) VALUES('#{property_id}', '#{owner_id}', '#{requester_id}');"
    conn.exec(sql)
  end

  def self.list_for_guest(requester_id)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

    sql = "SELECT * FROM requests WHERE requester_id = #{requester_id};"
    conn.exec(sql)
  end 

  def self.list_for_host(owner_id)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end
    sql = "SELECT * FROM requests WHERE owner_id = #{owner_id};"
    conn.exec(sql)
  end
end 









