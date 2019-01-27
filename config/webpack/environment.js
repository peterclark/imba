const { environment } = require('@rails/webpacker')
const imba = require('./loaders/imba')
environment.loaders.append('imba', imba)

module.exports = environment
