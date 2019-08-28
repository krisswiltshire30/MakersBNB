require_relative '../lib/spaces.rb'

describe Spaces do
  it 'creates a new space' do
    connection = PG.connect(dbname: 'makersbnb_test')
    space = Spaces.create(title: 'Studio in Clapham', description:'super cheap and nice flat near tube station', price_per_night: 45.00 )
    expect(Spaces.all.length).to eq 1
    # expect(Spaces.all.first).to eq 1
    expect(Spaces.all.first.title).to eq 'Studio in Clapham'
    expect(Spaces.all.first.description).to eq 'super cheap and nice flat near tube station'
    expect(Spaces.all.first.price_per_night).to eq '45.0'
  end
end