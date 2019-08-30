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
    data = conn.exec("SELECT * FROM requests WHERE requester_id = #{requester_id};")
    data.map{ |entry|
      Request.new(entry['id'], entry['property_id'], entry['requester_id'], entry['owner_id'], entry['status'])
    }
  end

  def self.list_for_host(owner_id)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end
    sql = "SELECT * FROM requests WHERE owner_id = #{owner_id};"
    data = conn.exec(sql)
    data.map{ |entry|
      Request.new(entry['id'], entry['property_id'], entry['requester_id'], entry['owner_id'], entry['status'])
    }
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

  def self.reject_other_requests(request_array, accepted_id)
    # This method reject all requests in the array excepet the one with specifed id
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

    request_array.each do |request|
      if request.id == accepted_id
        request.accept_request
      else
        request.reject_request
      end
    end

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

  # following methods are used to fetch detail based on ids
  def self.fetch_info(id)
    connection = if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'makersbnb_test')
    else
      PG.connect(dbname: 'makersbnb')
    end

    puts id
    entries = connection.exec("SELECT * FROM users WHERE id = #{id};")
    entries[0]['email']
  end

  def self.fetch_space_info(space_id)
    connection = if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'makersbnb_test')
    else
      PG.connect(dbname: 'makersbnb')
    end
    entries = connection.exec("SELECT * FROM spaces WHERE id = #{space_id};")
    entries[0]
  end






  attr_reader :id, :property_id, :requester_id, :owner_id, :status

end
