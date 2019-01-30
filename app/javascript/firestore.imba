const firebase = require('firebase/app')
require('firebase/firestore')

const config = {
  apiKey:        "AIzaSyDrbiDJzawsWtufKvqNxV9zN4v0q3P6lQg",
  authDomain:    "movies-c8082.firebaseapp.com",
  databaseURL:   "https://movies-c8082.firebaseio.com",
  projectId:     "movies-c8082",
  storageBucket: "movies-c8082.appspot.com",
}

firebase.initializeApp(config)
const db = firebase.firestore()

export default db
