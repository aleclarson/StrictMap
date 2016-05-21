
require "isDev"

assertType = require "assertType"
define = require "define"
Type = require "Type"
sync = require "sync"

__store__ = Symbol "StrictMap.__store__"

type = Type "StrictMap"

type.inherits null

type.optionTypes =
  types: if isDev then Object.Maybe else Object
  values: Object.Maybe

type.initInstance ({ types, values }) ->

  if isDev

    # Define the internal value store.
    this[__store__] = {}

    # Define a computed property for each value type.
    define this, sync.map types, (type, key) ->
      configurable: no
      get: -> this[__store__][key]
      set: (newValue) ->
        assertType newValue, type, key
        this[__store__][key] = newValue

  if values
    for key, value of values
      this[key] = value

  return

module.exports = type.build()
