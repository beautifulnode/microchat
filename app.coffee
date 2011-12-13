express = require 'express'
app = express.createServer()

# app config
Model = require 'LazyBoy'
Message = null

app.configure 'development', ->
  Model.create_connection 'catchat'
  
app.configure 'production', ->
  Model.create_connection
    url: process.env.COUCH_URL
    port: 80
    db: process.env.COUCH_DB
    auth:
      username: process.env.USERNAME
      password: process.env.PASSWORD
  
app.configure ->
  app.use express.logger()

  Model.load('models')
  Message = Model('Message')
  
# app body
app.get '/', (req, resp) -> resp.json status: 'success'

app.post '/messages', express.bodyParser(), (req, resp) ->
  (Message.create req.body).save (err, msg) -> resp.json msg

app.get '/messages', (req, resp) ->
  Message.view 'gtDate', req.query, (err, msgs) -> resp.json msgs

app.listen process.env.VMC_APP_PORT or 3000, -> console.log 'Listening...'