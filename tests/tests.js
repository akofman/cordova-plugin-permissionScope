exports.defineAutoTests = function() {

  describe('PermissionScope (window.PermissionScope)', function () {
    var fns = [
      'addNotificationsPermission',
      'addLocationWhileInUsePermission',
      'addLocationAlwaysPermission',
      'addContactsPermission',
      'addEventsPermission',
      'addMicrophonePermission',
      'addCameraPermission',
      'addPhotosPermission',
      'addRemindersPermission',
      'addBluetoothPermission',
      'addMotionPermission'
    ];

    it('should exist', function() {
      expect(PermissionScope).toBeDefined();
    });

    fns.forEach(function(fn) {
      it('should contain a ' + fn + ' function', function () {
        expect(typeof PermissionScope[fn]).toBeDefined();
        expect(typeof PermissionScope[fn] === 'function').toBe(true);
      });
    })
  });
};

exports.defineManualTests = function(contentEl, createActionButton) {
  PermissionScope.addMicrophonePermission('Please enable access to your Microphone');
  PermissionScope.addCameraPermission('Please enable access to your Camera');
  PermissionScope.addPhotosPermission('Please enable access to your Photos');

  createActionButton('show', function() {
    PermissionScope.show();
  });
};
