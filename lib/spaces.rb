# frozen_string_literal: true

require 'pg'

class Spaces
  attr_reader :id, :title, :description, :price_per_night

  def initialize(id:, title:, description:, price_per_night:)
    @id = id
    @title = title
    @price_per_night = price_per_night
    @description = description
  end

  def self.all
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'makersbnb_test')
                 else
                   PG.connect(dbname: 'makersbnb')
                 end

    result = connection.exec('SELECT * FROM spaces')
    result = result.map { |space| Spaces.new(id: space['id'], title: space['title'], description: space['description'], price_per_night: space['price_per_night']) }
  end

  def self.create(title:, description:, price_per_night:)
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'makersbnb_test')
                 else
                   PG.connect(dbname: 'makersbnb')
                 end

    result = connection.query("INSERT INTO spaces (title, description, price_per_night) VALUES  ('#{title}', '#{description}', '#{price_per_night}') RETURNING id, title, description,      price_per_night;")
    Spaces.new(id: result[0]['id '], title: result[0]['title'], description: result[0]['description'], price_per_night: result[0]['price_per_night'])
  end
end
