Model = require 'LazyBoy'
Message = Model.define 'Message',
  author: String
  body: String
  
Message.addView 'gtDate',
  map: (doc) ->
    if doc.model_type == 'Message'
      emit doc.dateCreated, doc