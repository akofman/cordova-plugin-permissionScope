'use strict';

var _exec = require('cordova/exec');

var _exec2 = _interopRequireDefault(_exec);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.init = function (config, success, error) {
  (0, _exec2.default)(success, error, 'PermissionScope', 'initialize', [config]);
};

var types = ['Notifications', 'LocationInUse', 'LocationAlways', 'Contacts', 'Events', 'Microphone', 'Camera', 'Photos', 'Reminders', 'Bluetooth', 'Motion'];

types.forEach(function (type) {
  var addPermissionMethod = 'add' + type + 'Permission';
  var checkPermissionMethod = 'check' + type + 'Permission';
  exports[addPermissionMethod] = function (message, success, error) {
    (0, _exec2.default)(success, error, 'PermissionScope', 'addPermission', [type, message]);
  };
  exports[checkPermissionMethod] = function (message, success, error) {
    (0, _exec2.default)(success, error, 'PermissionScope', 'checkPermission', [type, message]);
  };
});

exports.checkPermissions = function (success, error) {
  (0, _exec2.default)(success, error, 'PermissionScope', 'checkPermissions');
};