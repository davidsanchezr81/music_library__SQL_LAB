require('pry-byebug')
require_relative('models/artist.rb')
require_relative('models/album.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'Jimmy Hendrix'})
artist1.save()

album1 = Album.new({
  'genre' => 'Rock',
  'title' => 'Jimmy Hendrix Experience',
 'artist_id' => artist1.id
 })
 album1.save()

 album2 = Album.new({
   'genre' => 'Rock',
   'title' => 'Are you experienced',
  'artist_id' => artist1.id
  })
album2.save()

Artist.list_all()
Album.list_all()




binding.pry

nil
