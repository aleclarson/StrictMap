
assertType = require "assertType"
Property = require "Property"
isDev = require "isDev"
Type = require "Type"
sync = require "sync"

__store__ = Symbol "StrictMap.__store__"

type = Type "StrictMap"

type.inherits null

type.defineOptions
  types: if isDev then Object else Object.isRequired
  values: Object

type.initInstance ({ types, values }) ->

  if isDev

    # Define the internal value store.
    this[__store__] = {}

    # Define a computed property for each value type.
    prop = Property { configurable: no }
    sync.each types, (type, key) =>
      prop.define this, key,
        get: -> this[__store__][key]
        set: (newValue) ->
          assertType newValue, type, key
          this[__store__][key] = newValue

  values and sync.each values, (value, key) => this[key] = value
  return

module.exports = type.build()
