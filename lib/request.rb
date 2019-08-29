require 'pg'

class Request

  def self.create(property_id, owner_id, requester_id)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

    sql = "INSERT INTO requests (property_id, owner_id, requester_id, status) VALUES('#{property_id}', '#{owner_id}', '#{requester_id}', 'pending');"
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

  def self.list_for_space(space_id)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end
    sql = "SELECT * FROM requests WHERE property_id = #{space_id};"
    data = conn.exec(sql)
    # encapsulate data into Request instance
    data.map{ |entry|
      Request.new(entry['id'], entry['property_id'], entry['requester_id'], entry['owner_id'], entry['status'])
    }
  end

  # instance method

  def initialize(id, property_id, requester_id, owner_id, status)
    @id = id
    @property_id = property_id
    @requester_id = requester_id
    @owner_id = owner_id
    @status = status
  end

  def reject_request
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end
    sql = "UPDATE requests SET status = 'denied' WHERE id = #{@id};"
    conn.exec(sql)
  end

  def accept_request
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end
    sql = "UPDATE requests SET status = 'accepted' WHERE id = #{@id}"
    conn.exec(sql)
  end

  def reject_other_requests 
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

  end 
  attr_reader :id, :property_id, :requester_id, :owner_id, :status

end
