require_relative "../lib/request"

describe Request do

  describe "#create" do
    it "add a new entry to requests table" do
      conn = PG.connect(dbname: "makersbnb_test")
      request = Request.create(property_id = 1, owner_id = 1, requester_id = 2)
      request = Request.create(property_id = 2, owner_id = 1, requester_id = 3)
      # fetch all entries in db
      entries = conn.exec("SELECT * FROM requests;")
      expect(entries[0]['property_id']).to eq("1")
      expect(entries[0]['owner_id']).to eq("1")
      expect(entries[0]['requester_id']).to eq("2")
      expect(entries[1]['property_id']).to eq("2")
      expect(entries[1]['owner_id']).to eq("1")
      expect(entries[1]['requester_id']).to eq("3")
    end
  end

  describe "#list_for_guest" do
    it "list request entries based on requester_id" do
        conn = PG.connect(dbname: "makersbnb_test")
        # add three request entries to db
        Request.create(property_id = 1, owner_id = 1, requester_id = 2)
        Request.create(property_id = 2, owner_id = 1, requester_id = 3)
        Request.create(property_id = 3, owner_id = 1, requester_id = 2)
        requests = Request.list_for_guest(requester_id = 2)
        expect(requests[0]["property_id"]).to eq("1")
        expect(requests[0]["owner_id"]).to eq("1")
        expect(requests[0]["requester_id"]).to eq("2")
        expect(requests[1]["property_id"]).to eq("3")
        expect(requests[1]["owner_id"]).to eq("1")
        expect(requests[1]["requester_id"]).to eq("2")
    end
  end





end
