"use strict"
(->
  global = Function("return this")()
  return  unless global.jasmine and global.expect

  ofType = (val) ->
    types = [].slice.call(arguments, 1)
    valType = (if val is null then "null" else typeof val)
    types.indexOf(valType) > -1

  getMessage = (assertion, message, args) ->
    until ofType(message, "string", "number", "boolean")
      switch
        when ofType(message, "undefined", "null")
          message = "You cannot use `" + message + "` as a custom message"
        when ofType(message, "function")
          message = message.apply(assertion, args)
        when message and ofType(message.toString, "function") and message.toString().indexOf("[object ") isnt 0
          message = message.toString()
        when JSON and ofType(JSON.stringify, "function")
          message = JSON.stringify(message)
    message.toString()

  wrapExpect = (expect, customMessage) ->
    (actual) ->
      assertion = expect(actual)
      unless ofType(customMessage, "undefined", "null")
        assertion.message = ->
          getMessage assertion, customMessage, arguments
      assertion

  defineSince = ->
    global.since = (customMessage) ->
      expect: wrapExpect(global.expect, customMessage)
    return

  defineSince()
  return
)()