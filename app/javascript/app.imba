import db from './firestore.imba'

let movies = []

tag Movie < li

  const movieDB = db.collection('movies')

  prop title
  prop year
  prop seen

  def self.all
    await movieDB.get

  def setup
    update data

  def mount
    movieDB.doc(id).onSnapshot do |movie|
      if movie:exists
        update movie.data
      else
        const index = movies.findIndex do |m|
          m:id == id
        movies.splice(index, 1)
      Imba.commit

  def update movie
    title = movie:title
    year  = movie:year
    seen  = movie:seen

  def destroy
    movieDB.doc(id).delete()

  def toggleSeen
    movieDB.doc(id).update(seen: !seen)

  def render
    <self.seen=(seen)>
      <span.title :tap.toggleSeen>
        <strong>
          title
          <small css:opacity='.5'> " {year}"
      <span>
        <i.fas.fa-times :tap.destroy css:color='darkred'>

tag App
  prop title

  def setup
    data = await Movie.all
    data.forEach do |doc|
      let movie = doc.data
      movie:id = doc:id
      movies.push movie
    Imba.commit

  def addMovie
    return unless @title
    let movie = { title: @title, seen: false, year: 2002 }
    db.collection('movies')
      .add(movie)
      .then do |doc|
        movie:id = doc:id
        movies.push movie
        @title = ''

  def render
    <self>
      <form.header :submit.prevent.addMovie>
        <input[@title] placeholder='Add...'>
        <button type='submit'> 'Add movie'
      <ul> for movie in movies
        <Movie id=movie:id data=movie>

Imba.mount <App.vbox>, Imba.document:body
