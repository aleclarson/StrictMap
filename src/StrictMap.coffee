
assertType = require "assertType"
Property = require "Property"
isDev = require "isDev"
Type = require "Type"
sync = require "sync"

type = Type "StrictMap"

type.inherits null

type.defineArgs [Object]

type.defineValues (types) ->

  _types: types

  _map: {}

isDev and
type.initInstance ->

  prop = Property {configurable: no}
  sync.each @_types, (type, key) =>
    prop.define this, key,
      get: -> @_map[key]
      set: (newValue) ->
        assertType newValue, type, key
        @_map[key] = newValue
        return

type.defineMethods

  freeze: ->
    Object.freeze this

  update: (newValues) ->
    for key, newValue of newValues
      if isDev
        unless type = @_types[key]
          throw Error "Unsupported key: '#{key}'"
        assertType newValue, type, key
      @_map[key] = newValue
    return this

module.exports = type.build()
