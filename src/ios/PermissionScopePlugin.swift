import Foundation

@objc(PermissionScopePlugin) class PermissionScopePlugin: CDVPlugin {
  private let LOG_TAG = "PermissionScopePlugin"
  private var permissions: [String: () -> NSObject]?
  private var pscope: PermissionScope?

  override func pluginInitialize() {
    super.pluginInitialize()
    self.pscope = PermissionScope()
    self.permissions = [
      "addNotificationsPermission": { NotificationsPermission() },
      "addLocationWhileInUsePermission": { LocationWhileInUsePermission() },
      "addLocationAlwaysPermission": { LocationAlwaysPermission() },
      "addContactsPermission": { ContactsPermission() },
      "addEventsPermission": { EventsPermission() },
      "addMicrophonePermission": { MicrophonePermission() },
      "addCameraPermission": { CameraPermission() },
      "addPhotosPermission": { PhotosPermission() },
      "addRemindersPermission": { RemindersPermission() },
      "addBluetoothPermission": { BluetoothPermission() },
      "addMotionPermission": { MotionPermission() }
    ]
  }

  func addPermission(command: CDVInvokedUrlCommand) {
    print(command.methodName)
    pscope!.addPermission(permissions![command.argumentAtIndex(0) as! String]!() as! Permission, message: command.argumentAtIndex(1) as! String)
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
    self.commandDelegate!.sendPluginResult(pluginResult, callbackId: command.callbackId)
  }

  func show(command: CDVInvokedUrlCommand) {
    pscope!.show({ finished, results in
      print("got results \(results)")
      }, cancelled: { (results) -> Void in
      print("thing was cancelled")
    })
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
    self.commandDelegate!.sendPluginResult(pluginResult, callbackId: command.callbackId)
  }
}
