import db from './firestore.imba'

let movies = []

tag Movie < li
  prop title
  prop year
  prop seen

  def setup
    update data

  def mount
    db.collection('movies').doc(id).onSnapshot do |movie|
      if movie:exists
        update movie.data

  def update movie
    title = movie:title
    year  = movie:year
    seen  = movie:seen
    Imba.commit

  def destroy
    db.collection('movies').doc(id).delete().then do
      console.log "movie #{id} deleted."

  def toggleSeen
    db.collection('movies').doc(id).update(seen: !seen)

  def render
    <self.seen=(seen)>
      <span.title :tap.toggleSeen> 
        <strong> title
        ' ('
        year
        ')'
      <span>
        <i.fas.fa-times :tap.destroy>

tag App
  prop title

  # def load url
  #   const data = await window.fetch(url)
  #   return data.json

  # def setup
  #   movies = await load('movies')
  #   Imba.commit

  def load collection
    const data = await db.collection(collection).get()
    return data

  def setup
    data = await load('movies')
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
