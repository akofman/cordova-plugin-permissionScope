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
  const requestPermissionMethod = `request${type}Permission`;
  exports[addPermissionMethod] = (message, success, error) => {
    exec(success, error, 'PermissionScope', 'addPermission', [ type, message ] );
  };
  exports[requestPermissionMethod] = (success, error) => {
    exec(success, error, 'PermissionScope', 'requestPermission', [ type ] );
  };
})

exports.show = (success, error) => {
  exec(success, error, 'PermissionScope',  'show');
};
