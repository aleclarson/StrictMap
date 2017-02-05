"use strict";

StrictMap = require ".."

describe "StrictMap(types)", ->

  it "validates every property setter", ->
    map = StrictMap {a: Number}
    expect -> map.a = "string"
      .toThrowError "'a' must be a Number!"

  # NOTE: This will only throw in strict mode.
  it "freezes itself to prevent new properties", ->
    map = StrictMap {a: Number}
    expect -> map.b = "lolwut"
      .toThrowError "Can't add property b, object is not extensible"

describe "StrictMap::update(values)", ->

  it "sets multiple properties at once", ->
    map = StrictMap {a: String, b: Boolean, c: Number}
    map.b = yes
    map.c = 1
    map.update update = {a: "foo", b: no}
    expect map.a
      .toBe update.a
    expect map.b
      .toBe update.b
    expect map.c
      .toBe 1

  it "validates each value before setting", ->
    map = StrictMap {a: String, b: Boolean}
    expect -> map.update {a: 1, b: yes}
      .toThrowError "'a' must be a String!"
    expect -> map.update {a: "", b: 1}
      .toThrowError "'b' must be a Boolean!"
