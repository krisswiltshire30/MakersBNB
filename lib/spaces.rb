require 'pg'


class Spaces

  attr_reader :id, :title, :description

  def initialize(id:, title:, description:)
    @id = id
    @title = title
    @description = description
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec("SELECT * FROM spaces")
    result =  result.map { |space| Spaces.new(id: space['id'], title: space['title'], description: space['description'])}
  end


end