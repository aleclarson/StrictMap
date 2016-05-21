var Type, __store__, assertType, define, sync, type;

require("isDev");

assertType = require("assertType");

define = require("define");

Type = require("Type");

sync = require("sync");

__store__ = Symbol("StrictMap.__store__");

type = Type("StrictMap");

type.inherits(null);

type.optionTypes = {
  types: isDev ? Object.Maybe : Object,
  values: Object.Maybe
};

type.initInstance(function(arg) {
  var key, types, value, values;
  types = arg.types, values = arg.values;
  if (isDev) {
    this[__store__] = {};
    define(this, sync.map(types, function(type, key) {
      return {
        configurable: false,
        get: function() {
          return this[__store__][key];
        },
        set: function(newValue) {
          assertType(newValue, type, key);
          return this[__store__][key] = newValue;
        }
      };
    }));
  }
  if (values) {
    for (key in values) {
      value = values[key];
      this[key] = value;
    }
  }
});

module.exports = type.build();

//# sourceMappingURL=../../map/src/StrictMap.map
