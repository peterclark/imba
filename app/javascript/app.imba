import db from './firestore.imba'

let movies = []

tag Movie < li

  def ontap
    data:seen = !data:seen

  def render
    <self.movie .seen=(data:seen)>
      <span.title> data:title
      <span.year> data:year

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
      movies.push doc.data
    Imba.commit

  def addMovie
    return unless @title
    movies.push { title: @title, year: null, seen: false }
    @title = ''

  def render
    <self>
      <form.header :submit.prevent.addMovie>
        <input[@title] placeholder='Add...'>
        <button type='submit'> 'Add movie'
      <ul> for movie in movies
        <Movie[movie]>

Imba.mount <App.vbox>, Imba.document:body
