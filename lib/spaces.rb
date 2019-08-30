# frozen_string_literal: true

require 'pg'

class Spaces
  attr_reader :id, :title, :description, :price_per_night, :owner_id

  def initialize(id:, title:, description:, price_per_night:, owner_id:)
    @id = id
    @title = title
    @price_per_night = price_per_night
    @description = description
    @owner_id = owner_id
  end

  def self.all
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'makersbnb_test')
                 else
                   PG.connect(dbname: 'makersbnb')
                 end

    result = connection.exec('SELECT * FROM spaces')
    result = result.map { |space| Spaces.new(id: space['id'], title: space['title'], description: space['description'], price_per_night: space['price_per_night'], owner_id: space['owner_id']) }
  end

  def self.create(title:, description:, price_per_night:, owner_id:)
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'makersbnb_test')
                 else
                   PG.connect(dbname: 'makersbnb')
                 end

    result = connection.query("INSERT INTO spaces (title, description, price_per_night, owner_id) VALUES  ('#{title}', '#{description}', '#{price_per_night}', '#{owner_id}') RETURNING id, title, description,price_per_night, owner_id;")
    Spaces.new(id: result[0]['id '], title: result[0]['title'], description: result[0]['description'], price_per_night: result[0]['price_per_night'], owner_id: result[0]['owner_id'])
  end

end
