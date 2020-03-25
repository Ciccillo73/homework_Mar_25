require('pry-byebug')
require_relative('../models/artist')
require_relative('../models/album')

Album.delete_all()

Artist.delete_all()

artist1 = Artist.new({
  'name' => 'Metallica'
  })


artist1.save()

artist2 = Artist.new({
  'name' => 'Iron Maiden'
  })


artist2.save()


album1 = Album.new({
  'artist_id'=> artist1.id,
  'title'=> 'Master of Puppets',
  'genre'=> 'Heavy Metal'
  })

album1.save()

album2 = Album.new({
  'artist_id'=> artist2.id,
  'title'=> 'The Number of the Beast',
  'genre'=> 'Heavy Metal'
  })

album2.save()



binding.pry
nil
