import Foundation

@objc(PermissionScopePlugin) class PermissionScopePlugin: CDVPlugin {
  private let LOG_TAG = "PermissionScopePlugin"
  private var pscope: PermissionScope?

  override func pluginInitialize() {
    super.pluginInitialize()
    self.pscope = PermissionScope()
  }

  func addMicrophonePermission(command: CDVInvokedUrlCommand) {
    pscope!.addPermission(MicrophonePermission(), message: command.argumentAtIndex(0) as! String)
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
