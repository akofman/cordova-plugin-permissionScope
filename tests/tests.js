exports.defineAutoTests = function() {

  describe('PermissionScope (window.PermissionScope)', function () {
    it('should exist', function() {
      expect(PermissionScope).toBeDefined();
    });

    it('should contain a addMicrophonePermission function', function () {
      expect(typeof PermissionScope.addMicrophonePermission).toBeDefined();
      expect(typeof PermissionScope.addMicrophonePermission === 'function').toBe(true);
    });

    it('should contain a show function', function () {
      expect(typeof PermissionScope.show).toBeDefined();
      expect(typeof PermissionScope.show === 'function').toBe(true);
    });
  });
};

exports.defineManualTests = function(contentEl, createActionButton) {
  PermissionScope.addMicrophonePermission('Please enable your Microphone');

  createActionButton('show', function() {
    PermissionScope.show();
  });
};
