import Foundation

@objc(PermissionScopePlugin) class PermissionScopePlugin: CDVPlugin {
  private let LOG_TAG = "PermissionScopePlugin"
  private var permissionMethods: [String: () -> NSObject]?
  private var requestMethods: [String: () -> Void]?
  private var defaultConfig: [String: Any]?
  private var pscope: PermissionScope?

  override func pluginInitialize() {
    super.pluginInitialize()
    self.pscope = PermissionScope()

    self.permissionMethods = [
      "Notifications": { NotificationsPermission() },
      "LocationInUse": { LocationWhileInUsePermission() },
      "LocationAlways": { LocationAlwaysPermission() },
      "Contacts": { ContactsPermission() },
      "Events": { EventsPermission() },
      "Microphone": { MicrophonePermission() },
      "Camera": { CameraPermission() },
      "Photos": { PhotosPermission() },
      "Reminders": { RemindersPermission() },
      "Bluetooth": { BluetoothPermission() },
      "Motion": { MotionPermission() }
    ]

    self.requestMethods = [
      "Notifications": { self.pscope!.requestNotifications() },
      "LocationInUse": { self.pscope!.requestLocationInUse() },
      "LocationAlways": { self.pscope!.requestLocationAlways() },
      "Contacts": { self.pscope!.requestContacts() },
      "Events": { self.pscope!.requestEvents() },
      "Microphone": { self.pscope!.requestMicrophone() },
      "Camera": { self.pscope!.requestCamera() },
      "Photos": { self.pscope!.requestPhotos() },
      "Reminders": { self.pscope!.requestReminders() },
      "Bluetooth": { self.pscope!.requestBluetooth() },
      "Motion": { self.pscope!.requestMotion() }
    ]

    self.defaultConfig = [
      "headerLabel": self.pscope?.headerLabel.text,
      "bodyLabel": self.pscope?.bodyLabel.text,
      "closeButtonTextColor": self.pscope?.closeButtonTextColor,
      "closeButtonTitle": self.pscope?.closeButton.currentTitle,
      "permissionButtonTextColor": self.pscope?.permissionButtonTextColor,
      "permissionButtonBorderColor": self.pscope?.permissionButtonBorderColor,
      "closeOffset": self.pscope?.closeOffset,
      "authorizedButtonColor": self.pscope?.authorizedButtonColor,
      "unauthorizedButtonColor": self.pscope?.unauthorizedButtonColor,
      "permissionButtonΒorderWidth": self.pscope?.permissionButtonΒorderWidth,
      "permissionButtonCornerRadius":self.pscope?.permissionButtonCornerRadius,
      "permissionLabelColor": self.pscope?.permissionLabelColor,
      "deniedAlertTitle": self.pscope?.deniedAlertTitle,
      "deniedAlertMessage": self.pscope?.deniedAlertMessage,
      "deniedCancelActionTitle": self.pscope?.deniedCancelActionTitle,
      "deniedDefaultActionTitle": self.pscope?.deniedDefaultActionTitle,
      "disabledAlertTitle": self.pscope?.disabledAlertTitle,
      "disabledAlertMessage": self.pscope?.disabledAlertMessage,
      "disabledCancelActionTitle": self.pscope?.disabledCancelActionTitle,
      "disabledDefaultActionTitle": self.pscope?.disabledDefaultActionTitle
    ]

  }

  private func isDefined(configItem: AnyObject!) -> Bool {
    return configItem != nil && !(configItem as! String).isEmpty
  }

  func initialize(command: CDVInvokedUrlCommand) {
    let config = command.argumentAtIndex(0)

    self.pscope!.configuredPermissions = []

    self.pscope!.headerLabel.text = self.defaultConfig!["headerLabel"] as? String
    self.pscope!.bodyLabel.text = self.defaultConfig!["bodyLabel"] as? String
    self.pscope!.closeButtonTextColor = (self.defaultConfig!["closeButtonTextColor"] as? UIColor)!
    self.pscope!.closeButton.setTitle(self.defaultConfig!["closeButtonTitle"] as? String, forState: UIControlState.Normal)
    self.pscope!.permissionButtonTextColor = (self.defaultConfig!["permissionButtonTextColor"] as? UIColor)!
    self.pscope!.permissionButtonBorderColor = (self.defaultConfig!["permissionButtonBorderColor"] as? UIColor)!
    self.pscope!.closeOffset = (self.defaultConfig!["closeOffset"] as? CGSize)!
    self.pscope!.authorizedButtonColor = (self.defaultConfig!["authorizedButtonColor"] as? UIColor)!
    self.pscope!.unauthorizedButtonColor = self.defaultConfig!["unauthorizedButtonColor"] as? UIColor
    self.pscope!.permissionButtonΒorderWidth = (self.defaultConfig!["permissionButtonΒorderWidth"] as? CGFloat)!
    self.pscope!.permissionButtonCornerRadius = (self.defaultConfig!["permissionButtonCornerRadius"] as? CGFloat)!
    self.pscope!.permissionLabelColor = (self.defaultConfig!["permissionLabelColor"] as? UIColor)!
    self.pscope!.deniedAlertTitle = self.defaultConfig!["deniedAlertTitle"] as? String
    self.pscope!.deniedAlertMessage = self.defaultConfig!["deniedAlertMessage"] as? String
    self.pscope!.deniedCancelActionTitle = self.defaultConfig!["deniedCancelActionTitle"] as? String
    self.pscope!.deniedDefaultActionTitle = self.defaultConfig!["deniedDefaultActionTitle"] as? String
    self.pscope!.disabledAlertTitle = self.defaultConfig!["disabledAlertTitle"] as? String
    self.pscope!.disabledAlertMessage = self.defaultConfig!["disabledAlertMessage"] as? String
    self.pscope!.disabledCancelActionTitle = self.defaultConfig!["disabledCancelActionTitle"] as? String
    self.pscope!.disabledDefaultActionTitle = self.defaultConfig!["disabledDefaultActionTitle"] as? String

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
      }
      self.pscope!.closeButton.sizeToFit()

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
    pscope!.addPermission(self.permissionMethods![command.argumentAtIndex(0) as! String]!() as! Permission, message: message)
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
    self.commandDelegate!.sendPluginResult(pluginResult, callbackId: command.callbackId)
  }

  func show(command: CDVInvokedUrlCommand) {
    pscope!.show()
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
    self.commandDelegate!.sendPluginResult(pluginResult, callbackId: command.callbackId)
  }

  func requestPermission(command: CDVInvokedUrlCommand) {
    let type = command.argumentAtIndex(0) as! String

    self.pscope!.viewControllerForAlerts = self.viewController
    self.requestMethods![type]!()

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
