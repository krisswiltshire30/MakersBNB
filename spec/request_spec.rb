require_relative "../lib/request"

describe Request do

  describe "#create" do
    it "add a new entry to requests table" do
      conn = PG.connect(dbname: 'makersbnb_test')
      request = Request.create(property_id = 1, owner_id = 1, requester_id = 2)
      # fetch all entries in db
      entries = conn.exec("SELECT * FROM requests")
      expect(entries[0]['property_id']).to eq("1")
      expect(entries[0]['owner_id']).to eq("1")
      expect(entries[0]['requester_id']).to eq("2")
    end
  end





end
