require 'pg'


class Spaces

  attr_reader :id, :title, :description

  def intialize(id:, title:, description:)
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
    result.map { |space| space['title']}
  end


end