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
      expect(entries[0]['status']).to eq("pending")
      expect(entries[1]['status']).to eq("pending")
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

  describe "#list_for_host" do
    it "list the requests by the owner_id" do
      conn = PG.connect(dbname: "makersbnb_test")
      Request.create(property_id = 1, owner_id = 1, requester_id = 2)
      Request.create(property_id = 2, owner_id = 2, requester_id = 3)
      Request.create(property_id = 3, owner_id = 2, requester_id = 2)
      requests = Request.list_for_host(owner_id = 2)
      expect(requests[0]["property_id"]).to eq("2")
      expect(requests[0]["requester_id"]).to eq("3")
      expect(requests[1]["property_id"]).to eq("3")
      expect(requests[1]["requester_id"]).to eq("2")
    end
  end

  describe "#list_for_space" do
    it "fetch requests from database and encapsulate in Request instance" do
      conn = PG.connect(dbname: "makersbnb_test")
      Request.create(property_id = 1, owner_id = 1, requester_id = 2)
      Request.create(property_id = 2, owner_id = 2, requester_id = 3)
      Request.create(property_id = 2, owner_id = 2, requester_id = 2)
      entries = Request.list_for_space(space_id=2)
      expect(entries[0].id).to eq("2")
      expect(entries[1].id).to eq("3")
      expect(entries[0].requester_id).to eq("3")
      expect(entries[1].requester_id).to eq("2")
    end
  end

  describe "#reject_request" do
    it "reject request by the host and denied the status" do
      conn = PG.connect(dbname: "makersbnb_test")
      # add_two_entries
      Request.create(property_id = 1, owner_id = 1, requester_id = 2)
      Request.create(property_id = 2, owner_id = 2, requester_id = 3)
      Request.create(property_id = 2, owner_id = 2, requester_id = 2)

      entries = Request.list_for_space(space_id=2)
      entries[1].reject_request
      entries = conn.exec("SELECT * FROM requests;")
      expect(entries[2]['status']).to eq("denied")
    end
  end

  describe "#accept_request" do
    it "accept request" do
      conn = PG.connect(dbname: "makersbnb_test")
      Request.create(property_id = 1, owner_id = 1, requester_id = 2)
      Request.create(property_id = 2, owner_id = 2, requester_id = 3)
      Request.create(property_id = 2, owner_id = 2, requester_id = 2)
      entries = Request.list_for_space(space_id=2)
      entries[1].accept_request
      entries = conn.exec("SELECT * FROM requests;")
      expect(entries[2]['status']).to eq("accepted")
    end

    it "denied other request when the host accept one of them" do
      conn = PG.connect(dbname: "makersbnb_test")
      Request.create(property_id = 1, owner_id = 1, requester_id = 2)
      Request.create(property_id = 2, owner_id = 2, requester_id = 3)
      Request.create(property_id = 2, owner_id = 2, requester_id = 2)
      entries = Request.list_for_space(space_id=2)
      # owner accept the request #3 therefore request #2 should be reject
      # assuming that these two requests conflict
      Request.reject_other_requests(entries, 3)
      entries = conn.exec("SELECT * FROM requests;")
      expect(entries[1]['status']).to eq("denied")


    end
  end






end
