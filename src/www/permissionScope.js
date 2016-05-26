import exec from 'cordova/exec';

exports.init = (config, success, error) => {
  exec(success, error, 'PermissionScope',  'initialize', [ config ]);
};

const types = [
  'Notifications',
  'LocationInUse',
  'LocationAlways',
  'Contacts',
  'Events',
  'Microphone',
  'Camera',
  'Photos',
  'Reminders',
  'Bluetooth',
  'Motion'
];

types.forEach((type) => {
  const addPermissionMethod = `add${type}Permission`;
  const checkPermissionMethod = `check${type}Permission`;
  exports[addPermissionMethod] = (message, success, error) => {
    exec(success, error, 'PermissionScope', 'addPermission', [ type, message ] );
  };
  exports[checkPermissionMethod] = (success, error) => {
    exec(success, error, 'PermissionScope', 'checkPermission', [ type ] );
  };
})

exports.checkPermissions = (success, error) => {
  exec(success, error, 'PermissionScope',  'checkPermissions');
};
