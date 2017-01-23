import Foundation

@objc(PermissionScopePlugin) class PermissionScopePlugin: CDVPlugin {
    fileprivate let LOG_TAG = "PermissionScopePlugin"
    fileprivate var permissionMethods: [String: () -> NSObject]?
    fileprivate var requestMethods: [String: () -> Void]?
    fileprivate var defaultConfig: [String: Any]?
    fileprivate var pscope: PermissionScope?

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
            "headerLabel": self.pscope?.headerLabel.text as Any,
            "bodyLabel": self.pscope?.bodyLabel.text as Any,
            "closeButtonTextColor": self.pscope?.closeButtonTextColor as Any,
            "closeButtonTitle": self.pscope?.closeButton.currentTitle as Any,
            "permissionButtonTextColor": self.pscope?.permissionButtonTextColor as Any,
            "permissionButtonBorderColor": self.pscope?.permissionButtonBorderColor as Any,
            "closeOffset": self.pscope?.closeOffset as Any,
            "authorizedButtonColor": self.pscope?.authorizedButtonColor as Any,
            "unauthorizedButtonColor": self.pscope?.unauthorizedButtonColor as Any,
            "permissionButtonΒorderWidth": self.pscope?.permissionButtonBorderWidth as Any,
            "permissionButtonCornerRadius":self.pscope?.permissionButtonCornerRadius as Any,
            "permissionLabelColor": self.pscope?.permissionLabelColor as Any,
            "deniedAlertTitle": self.pscope?.deniedAlertTitle as Any,
            "deniedAlertMessage": self.pscope?.deniedAlertMessage as Any,
            "deniedCancelActionTitle": self.pscope?.deniedCancelActionTitle as Any,
            "deniedDefaultActionTitle": self.pscope?.deniedDefaultActionTitle as Any,
            "disabledAlertTitle": self.pscope?.disabledAlertTitle as Any,
            "disabledAlertMessage": self.pscope?.disabledAlertMessage as Any,
            "disabledCancelActionTitle": self.pscope?.disabledCancelActionTitle as Any,
            "disabledDefaultActionTitle": self.pscope?.disabledDefaultActionTitle as Any
        ]

    }

    private func isDefined(configItem: String?) -> Bool {
        return configItem != nil && !configItem!.isEmpty
    }

    func initialize(_ command: CDVInvokedUrlCommand) {

        self.pscope!.configuredPermissions = []

        self.pscope!.headerLabel.text = self.defaultConfig!["headerLabel"] as? String
        self.pscope!.bodyLabel.text = self.defaultConfig!["bodyLabel"] as? String
        self.pscope!.closeButtonTextColor = (self.defaultConfig!["closeButtonTextColor"] as? UIColor)!
        self.pscope!.closeButton.setTitle(self.defaultConfig!["closeButtonTitle"] as? String, for: UIControlState())
        self.pscope!.permissionButtonTextColor = (self.defaultConfig!["permissionButtonTextColor"] as? UIColor)!
        self.pscope!.permissionButtonBorderColor = (self.defaultConfig!["permissionButtonBorderColor"] as? UIColor)!
        self.pscope!.closeOffset = (self.defaultConfig!["closeOffset"] as? CGSize)!
        self.pscope!.authorizedButtonColor = (self.defaultConfig!["authorizedButtonColor"] as? UIColor)!
        self.pscope!.unauthorizedButtonColor = self.defaultConfig!["unauthorizedButtonColor"] as? UIColor
        self.pscope!.permissionButtonBorderWidth = (self.defaultConfig!["permissionButtonΒorderWidth"] as? CGFloat)!
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

        if let config = command.argument(at: 0) as? [String: String] {
            if (self.isDefined(configItem: config["headerLabel"])) {
                self.pscope!.headerLabel.text = config["headerLabel"]
            }
            if (self.isDefined(configItem: config["bodyLabel"])) {
                self.pscope!.bodyLabel.text = config["bodyLabel"]
            }
            if (self.isDefined(configItem: config["closeButtonTextColor"])) {
                self.pscope!.closeButtonTextColor = UIColor.init(hexString: config["closeButtonTextColor"]!)
            }

            if (self.isDefined(configItem: config["closeButtonTitle"])) {
                self.pscope!.closeButton.setTitle(config["closeButtonTitle"]!, for: UIControlState.normal)
            }
            self.pscope!.closeButton.sizeToFit()

            if (self.isDefined(configItem: config["permissionButtonTextColor"])) {
                self.pscope!.permissionButtonTextColor = UIColor.init(hexString: config["permissionButtonTextColor"]!)
            }
            if (self.isDefined(configItem: config["permissionButtonBorderColor"])) {
                self.pscope!.permissionButtonBorderColor = UIColor.init(hexString: config["permissionButtonBorderColor"]!)
            }
            if (self.isDefined(configItem: config["closeOffset"])) {
                self.pscope!.closeOffset = CGSizeFromString(config["closeOffset"]!)
            }
            if (self.isDefined(configItem: config["authorizedButtonColor"])) {
                self.pscope!.authorizedButtonColor = UIColor.init(hexString: config["authorizedButtonColor"]!)
            }
            if (self.isDefined(configItem: config["unauthorizedButtonColor"])) {
                self.pscope!.unauthorizedButtonColor = UIColor.init(hexString: config["unauthorizedButtonColor"]!)
            }
            if (self.isDefined(configItem: config["permissionButtonΒorderWidth"])) {
                self.pscope!.permissionButtonBorderWidth = CGFloat(NumberFormatter().number(from: config["permissionButtonΒorderWidth"]!)!)
            }
            if (self.isDefined(configItem: config["permissionButtonCornerRadius"])) {
                self.pscope!.permissionButtonCornerRadius = CGFloat(NumberFormatter().number(from: config["permissionButtonCornerRadius"]!)!)
            }
            if (self.isDefined(configItem: config["permissionLabelColor"])) {
                self.pscope!.permissionLabelColor = UIColor.init(hexString: config["permissionLabelColor"]!)
            }
            if (self.isDefined(configItem: config["deniedAlertTitle"])) {
                self.pscope!.deniedAlertTitle = config["deniedAlertTitle"]
            }
            if (self.isDefined(configItem: config["deniedAlertMessage"])) {
                self.pscope!.deniedAlertMessage = config["deniedAlertMessage"]
            }
            if (self.isDefined(configItem: config["deniedCancelActionTitle"])) {
                self.pscope!.deniedCancelActionTitle = config["deniedCancelActionTitle"]
            }
            if (self.isDefined(configItem: config["deniedDefaultActionTitle"])) {
                self.pscope!.deniedDefaultActionTitle = config["deniedDefaultActionTitle"]
            }
            if (self.isDefined(configItem: config["disabledAlertTitle"])) {
                self.pscope!.disabledAlertTitle = config["deniedAlertTitle"]
            }
            if (self.isDefined(configItem: config["disabledAlertMessage"])) {
                self.pscope!.disabledAlertMessage = config["deniedAlertMessage"]
            }
            if (self.isDefined(configItem: config["disabledCancelActionTitle"])) {
                self.pscope!.disabledCancelActionTitle = config["disabledCancelActionTitle"]
            }
            if (self.isDefined(configItem: config["disabledDefaultActionTitle"])) {
                self.pscope!.disabledDefaultActionTitle = config["disabledDefaultActionTitle"]
            }
        }

        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }

    func addPermission(_ command: CDVInvokedUrlCommand) {
        let message = command.argument(at: 1) != nil ? "\(command.argument(at: 1)!)" : ""
        pscope!.addPermission(self.permissionMethods![command.argument(at: 0) as! String]!() as! Permission, message: "couccou")
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }

    func show(_ command: CDVInvokedUrlCommand) {
        pscope!.show()
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }

    func requestPermission(_ command: CDVInvokedUrlCommand) {
        let type = command.argument(at: 0) as! String

        self.pscope!.viewControllerForAlerts = self.viewController
        self.requestMethods![type]!()

        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: Double = 1.0) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
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
