require_relative('../db/sql_runner.rb')

class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end # end INIT#

  def save()
    sql = "INSERT INTO artists(name)
    VALUES($1)
    RETURNING *;
    "
    result = SqlRunner.run(sql, [@name])
    @id = result[0]['id'].to_i
  end # end SAVE

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    results = SqlRunner.run(sql, [@id])
    albums = results.map{|album_hash| Album.new(album_hash)}
    return albums
  end

  def update()
    sql = "UPDATE artists SET name
    = $1 WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end




  # CLASS METHODS:

  def Artist.find(an_id)
    sql = "SELECT * FROM artists WHERE id = $1;"
    result = SqlRunner.run(sql, [an_id])
    found_artist = Artist.new(result[0])
    return found_artist
  end

  def Artist.list_all
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map { |artist_hash| Artist.new(artist_hash)}
  end


  def Artist.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end



end # end CLASS ARTIST
