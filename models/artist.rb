require_relative('../db/sql_runner')
require_relative('album')

class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def albums()
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    values = [@id]
    album_hashes = SqlRunner.run(sql, values)
    album_object = album_hashes.map{|album_hash| Album.new(album_hash) }
    return album_object
  end

  def save()
    sql = "INSERT INTO artists
    (
      name
    )
    VALUES
    (
    $1
    )
    RETURNING *
    "
    values = [@name]
    @id = SqlRunner.run( sql, values )[0]["id"].to_i()
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql ="SELECT * FROM artists"
    artist_hashes = SqlRunner.new(sql)
    artist_objects = artist_hashes.map{|person| Artist.new(person)}
    return artist_objects
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    artist_hash = result.first()
    return nil if artist_hash == nil
    artist = Artist.new(artist_hash)
    return artist
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end


end
