require 'pg'

class Request

  def self.create(property_id, owner_id, requester_id)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

    sql = "INSERT INTO requests (property_id, owner_id, requester_id) VALUES('#{property_id}', #{owner_id}, #{requester_id})"
    conn.exec(sql)
  end







  
end
