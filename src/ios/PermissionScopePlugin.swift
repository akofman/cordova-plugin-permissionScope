import Foundation

@objc(PermissionScopePlugin) class PermissionScopePlugin: CDVPlugin {
  private let LOG_TAG = "PermissionScopePlugin"
  private var permissions: [String: () -> NSObject]?
  private var config: [String: () -> NSObject]?
  private var pscope: PermissionScope?

  override func pluginInitialize() {
    super.pluginInitialize()
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

  private func isDefined(configItem: AnyObject!) -> Bool {
    return configItem != nil && !(configItem as! String).isEmpty
  }

  func initialize(command: CDVInvokedUrlCommand) {
    self.pscope = PermissionScope()
    let config = command.argumentAtIndex(0)

    if (config != nil) {
      if (self.isDefined(config["headerLabel"])) {
        self.pscope!.headerLabel.text = config["headerLabel"] as? String
      }
      if (self.isDefined(config["bodyLabel"])) {
        self.pscope!.bodyLabel.text = config["bodyLabel"] as? String
      }
      if (self.isDefined(config["closeButtonTextColor"])) {
        self.pscope!.closeButtonTextColor = UIColor.init(hexString: (config["closeButtonTextColor"] as? String)!)
      }
      if (self.isDefined(config["closeButtonTitle"])) {
        self.pscope!.closeButton.setTitle((config["closeButtonTitle"] as? String)!
          , forState: UIControlState.Normal)
        self.pscope!.closeButton.sizeToFit()
      }
      if (self.isDefined(config["permissionButtonTextColor"])) {
        self.pscope!.permissionButtonTextColor = UIColor.init(hexString: (config["permissionButtonTextColor"] as? String)!)
      }
      if (self.isDefined(config["permissionButtonBorderColor"])) {
        self.pscope!.permissionButtonBorderColor = UIColor.init(hexString: (config["permissionButtonBorderColor"] as? String)!)
      }
      if (self.isDefined(config["closeOffset"])) {
        self.pscope!.closeOffset = CGSizeFromString((config["closeOffset"] as? String)!)
      }
      if (self.isDefined(config["authorizedButtonColor"])) {
        self.pscope!.authorizedButtonColor = UIColor.init(hexString: (config["authorizedButtonColor"] as? String)!)
      }
      if (self.isDefined(config["unauthorizedButtonColor"])) {
        self.pscope!.unauthorizedButtonColor = UIColor.init(hexString: (config["unauthorizedButtonColor"] as? String)!)
      }
      if (self.isDefined(config["permissionButtonΒorderWidth"])) {
        self.pscope!.permissionButtonΒorderWidth = CGFloat(NSNumberFormatter().numberFromString((config["permissionButtonΒorderWidth"] as? String)!)!)
      }
      if (self.isDefined(config["permissionButtonCornerRadius"]!)) {
        self.pscope!.permissionButtonCornerRadius = CGFloat(NSNumberFormatter().numberFromString(config["permissionButtonCornerRadius"] as! String)!)
      }
      if (self.isDefined(config["permissionLabelColor"])) {
        self.pscope!.permissionLabelColor = UIColor.init(hexString: (config["permissionLabelColor"] as? String)!)
      }
      if (self.isDefined(config["deniedAlertTitle"])) {
        self.pscope!.deniedAlertTitle = (config["deniedAlertTitle"] as? String)!
      }
      if (self.isDefined(config["deniedAlertMessage"])) {
        self.pscope!.deniedAlertMessage = (config["deniedAlertMessage"] as? String)!
      }
      if (self.isDefined(config["deniedCancelActionTitle"])) {
        self.pscope!.deniedCancelActionTitle = (config["deniedCancelActionTitle"] as? String)!
      }
      if (self.isDefined(config["deniedDefaultActionTitle"])) {
        self.pscope!.deniedDefaultActionTitle = (config["deniedDefaultActionTitle"] as? String)!
      }
      if (self.isDefined(config["disabledAlertTitle"])) {
        self.pscope!.disabledAlertTitle = (config["deniedAlertTitle"] as? String)!
      }
      if (self.isDefined(config["disabledAlertMessage"])) {
        self.pscope!.disabledAlertMessage = (config["deniedAlertMessage"] as? String)!
      }
      if (self.isDefined(config["disabledCancelActionTitle"])) {
        self.pscope!.disabledCancelActionTitle = (config["disabledCancelActionTitle"] as? String)!
      }
      if (self.isDefined(config["disabledDefaultActionTitle"])) {
        self.pscope!.disabledDefaultActionTitle = (config["disabledDefaultActionTitle"] as? String)!
      }
    }

    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
    self.commandDelegate!.sendPluginResult(pluginResult, callbackId: command.callbackId)
  }

  func addPermission(command: CDVInvokedUrlCommand) {
    let message = command.argumentAtIndex(1) != nil ? "\(command.argumentAtIndex(1))" : ""
    pscope!.addPermission(self.permissions![command.argumentAtIndex(0) as! String]!() as! Permission, message: message)
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
    self.commandDelegate!.sendPluginResult(pluginResult, callbackId: command.callbackId)
  }

  func show(command: CDVInvokedUrlCommand) {
    pscope!.show({ finished, results in
      print("got results \(results) ")
      }, cancelled: { (results) -> Void in
      print("thing was cancelled")
    })
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
    self.commandDelegate!.sendPluginResult(pluginResult, callbackId: command.callbackId)
  }
}

extension UIColor {
  convenience init(hexString: String, alpha: Double = 1.0) {
    let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
    var int = UInt32()
    NSScanner(string: hex).scanHexInt(&int)
    let r, g, b: UInt32
    switch hex.characters.count {
    case 3: // RGB (12-bit)
      (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
    default:
      (r, g, b) = (1, 1, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(255 * alpha) / 255)
  }
}
