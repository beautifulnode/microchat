Model = require 'LazyBoy'
Model.create_connection("catchat")
Model.load('models')

Message = Model('Message')

describe 'Message', ->
  it 'should be valid', (done) ->
    msg = Message.create author: 'twilson63', body: 'Hello World'
    msg.save (err, saved_msg) -> 
      saved_msg.author.should.eql 'twilson63'
      done()