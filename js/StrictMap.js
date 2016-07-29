var Property, Type, __store__, assertType, sync, type;

require("isDev");

assertType = require("assertType");

Property = require("Property");

Type = require("Type");

sync = require("sync");

__store__ = Symbol("StrictMap.__store__");

type = Type("StrictMap");

type.inherits(null);

type.defineOptions({
  types: isDev ? Object : Object.isRequired,
  values: Object
});

type.initInstance(function(arg) {
  var prop, types, values;
  types = arg.types, values = arg.values;
  if (isDev) {
    this[__store__] = {};
    prop = Property({
      configurable: false
    });
    sync.each(types, (function(_this) {
      return function(type, key) {
        return prop.define(_this, key, {
          get: function() {
            return this[__store__][key];
          },
          set: function(newValue) {
            assertType(newValue, type, key);
            return this[__store__][key] = newValue;
          }
        });
      };
    })(this));
  }
  values && sync.each(values, (function(_this) {
    return function(value, key) {
      return _this[key] = value;
    };
  })(this));
});

module.exports = type.build();

//# sourceMappingURL=map/StrictMap.map
