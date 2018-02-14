require_relative('../db/sql_runner.rb')


class Album

  attr_accessor :genre, :title
  attr_reader :id, :artist_id

  def initialize(options)
    @genre = options['genre']
    @title = options['title']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums(
    genre, title, artist_id)
    VALUES( $1, $2, $3)
    RETURNING *;"

    values = [@genre, @title, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end # end SAVE

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    result = SqlRunner.run(sql, [@artist_id])
    return Artist.new(result[0])
  end

  def update()
    sql = "UPDATE albums
    SET (genre,
    title)
    = ($1, $2)
    WHERE id = $3
    ;"
    values = [@genre, @title, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end

# CLASS METHODS

  def Album.find(an_id)
    sql = "SELECT * FROM albums WHERE id = $1;"
    result = SqlRunner.run(sql, [an_id])
    found_album = Album.new(result[0])
    return found_album
  end

  def Album.list_all
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map { |album_hash| Album.new(album_hash)}
  end

  def Album.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end # end DELETE_ALL


end # end CLASS ALBUM
