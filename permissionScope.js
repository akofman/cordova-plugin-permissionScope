'use strict';

var _exec = require('cordova/exec');

var _exec2 = _interopRequireDefault(_exec);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.init = function (config, success, error) {
  (0, _exec2.default)(success, error, 'PermissionScope', 'initialize', [config]);
};

var fns = ['addNotificationsPermission', 'addLocationWhileInUsePermission', 'addLocationAlwaysPermission', 'addContactsPermission', 'addEventsPermission', 'addMicrophonePermission', 'addCameraPermission', 'addPhotosPermission', 'addRemindersPermission', 'addBluetoothPermission', 'addMotionPermission'];

fns.forEach(function (fn) {
  exports[fn] = function (message, success, error) {
    (0, _exec2.default)(success, error, 'PermissionScope', 'addPermission', [fn, message]);
  };
});

exports.show = function (success, error) {
  (0, _exec2.default)(success, error, 'PermissionScope', 'show');
};