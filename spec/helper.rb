def add_two_entries 
  Request.create(property_id = 1, owner_id = 1, requester_id = 2)
  Request.create(property_id = 2, owner_id = 2, requester_id = 3)
end 