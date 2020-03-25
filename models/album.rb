require_relative('../db/sql_runner')
require_relative('artist')

class Album

  attr_accessor :title, :genre
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums(
      title,
      genre,
      artist_id

    )
    VALUES(
      $1, $2, $3
      )
      RETURNING *"
      values = [@title, @genre, @artist_id]
      @id =  SqlRunner.run(sql, values)[0]["id"].to_i

  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run( sql,values )
    artist_hash = results[0]
    artist = Artist.new(artist_hash)
    return artist
  end

  def update
    sql = "UPDATE albums SET(
       title,
       genre,
       artist_id
     )=
     ($1, $2, $3
     )
     WHERE id = S4"
     values = [@title,@genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    album_hashes = SqlRunner.run(sql)
    albums = album_hashes.map { |album_hash| Album.new( album_hash ) }
    return albums
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT *
    FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    album = Album.new(results.first)
    return album
  end

end
