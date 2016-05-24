import exec from 'cordova/exec';

exports.addMicrophonePermission = (message, success, error) => {
  exec(success, error, 'PermissionScope',  'addMicrophonePermission', [ message ] );
};

exports.show = (success, error) => {
  exec(success, error, 'PermissionScope',  'show');
};
