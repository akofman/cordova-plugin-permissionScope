[![Twitter: @alexiskofman](https://img.shields.io/badge/contact-@alexiskofman-blue.svg?style=flat)](https://twitter.com/alexiskofman)
[![License](https://img.shields.io/badge/license-apache2-green.svg?style=flat)](https://github.com/akofman/cordova-plugin-permissionscope/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/akofman/cordova-plugin-permissionscope.svg?branch=master&style=flat)](https://travis-ci.org/akofman/cordova-plugin-permissionscope)

# cordova-plugin-permissionscope

This plugin is a wrapper of the very helpful Swift framework [PermissionScope](https://github.com/akofman/permissionScope).
It defines a global PermissionScope object, which permits to requesting permissions from users.

## Installation

```
cordova plugin add cordova-plugin-permissionscope --save
```
The iOS part is written in Swift and the [Swift support plugin](https://github.com/akofman/cordova-plugin-add-swift-support) is configured as a dependency.

:warning: Because this plugin doesn't support Swift 3 at the moment, the following preference has to be added in your project :

`<preference name="UseLegacySwiftLanguageVersion" value="true" />`

## Supported Platforms

- iOS

## Methods

## `PermissionScope.init(config, success, error)`
Inits and customizes the dialog and all the alerts displayed from direct requests.
If called without any parameter then the default config is restored.

The following properties are available:

Property | Comment
----- | -------
headerLabel | Header UILabel with the message "Hey, listen!" by default.
bodyLabel | Header UILabel with the message "We need a couple things\r\nbefore you get started." by default.
closeButtonTitle | Title for the close button. "Close" by default.
closeButtonTextColor | Hex color code for the close button's text color (ie: #cccccc).
closeOffset | Offset used to position the Close button (ie: {-200,0}).
permissionButtonTextColor | Hex color code for the permission buttons' text color (ie: #cccccc).
permissionButtonBorderColor | Hex color code for the permission buttons' border color (ie: #cccccc).
permissionButtonΒorderWidth | Border width for the permission buttons.
permissionButtonCornerRadius | Corner radius for the permission buttons.
permissionLabelColor | Hex color code for the permission labels' text color (ie: #cccccc).
authorizedButtonColor | Hex color code used for permission buttons with authorized status (ie: #cccccc).
unauthorizedButtonColor | Hex color code used for permission buttons with unauthorized status. By default, inverse of `authorizedButtonColor` (ie: #cccccc).
deniedAlertTitle | Title for the denied alert.
deniedAlertMessage | Message for the denied alert.
deniedCancelActionTitle | Title for the denied alert's cancel button. "OK" by default.
deniedDefaultActionTitle | Title for the denied alert's default button. "Show me" by default.
disabledAlertTitle | Title for the disabled alert.
disabledAlertMessage | Message for the disabled alert.
disabledCancelActionTitle | Title for the disabled alert's cancel button. "OK" by default.
disabledDefaultActionTitle | Title for the disabled alert's default button. "Show me" by default.

## `PermissionScope.show(success, error)`
Displays the permissions dialog if permissions have to be approved else does nothing.

## `PermissionScope.add<TYPE>Permission(message, success, error)`
The following methods permit to set up permissions asked from the dialog :
- `PermissionScope.addNotificationsPermission(message, success, error)`
- `PermissionScope.addLocationInUsePermission(message, success, error)`
- `PermissionScope.addLocationAlwaysPermission(message, success, error)`
- `PermissionScope.addContactsPermission(message, success, error)`
- `PermissionScope.addEventsPermission(message, success, error)`
- `PermissionScope.addMicrophonePermission(message, success, error)`
- `PermissionScope.addCameraPermission(message, success, error)`
- `PermissionScope.addPhotosPermission(message, success, error)`
- `PermissionScope.addRemindersPermission(message, success, error)`
- `PermissionScope.addBluetoothPermission(message, success, error)`
- `PermissionScope.addMotionPermission(message, success, error)`

Message is a label displayed below the permission button. Its goal is to explain why a permission has to be approved.

## `PermissionScope.request<TYPE>Permission(success, error)`
The following methods permit to check whether a particular permission has been granted else it displays an alert :
- `PermissionScope.requestNotificationsPermission(success, error)`
- `PermissionScope.requestLocationInUsePermission(success, error)`
- `PermissionScope.requestLocationAlwaysPermission(success, error)`
- `PermissionScope.requestContactsPermission(success, error)`
- `PermissionScope.requestEventsPermission(success, error)`
- `PermissionScope.requestMicrophonePermission(success, error)`
- `PermissionScope.requestCameraPermission(success, error)`
- `PermissionScope.requestPhotosPermission(success, error)`
- `PermissionScope.requestRemindersPermission(success, error)`
- `PermissionScope.requestBluetoothPermission(success, error)`
- `PermissionScope.requestMotionPermission(success, error)`

## Examples

```
PermissionScope.init({
  headerLabel: 'Hello',
  bodyLabel: 'Before you get started',
  closeButtonTextColor: '#cccccc',
  closeButtonTitle: 'Return',
  permissionButtonTextColor: '#30ab7d',
  permissionButtonBorderColor: '#30ab7d',
  closeOffset: '{-200, 0}',
  authorizedButtonColor: '#cccccc',
  unauthorizedButtonColor: '#c2262d',
  permissionButtonCornerRadius: '20',
  permissionLabelColor: '#ff5500',
  permissionButtonΒorderWidth: '5',
  deniedCancelActionTitle: 'Cancel',
  deniedDefaultActionTitle: 'Settings',
  deniedAlertTitle: 'Permission',
  deniedAlertMessage: 'Please enable all the permissions',
  disabledCancelActionTitle: 'Cancel',
  disabledDefaultActionTitle: 'Settings',
});

PermissionScope.addBluetoothPermission('Please enable access to your Bluetooth');
PermissionScope.addCameraPermission('Please enable access to your Camera');
PermissionScope.addPhotosPermission('Please enable access to your Photos');

PermissionScope.show();
```

The result could be something like this :

![](https://cloud.githubusercontent.com/assets/579922/15592265/95a4e0f0-23a2-11e6-8b58-44e9d858963a.jpeg)

Here is the default version :

![](https://cloud.githubusercontent.com/assets/579922/15592266/97be6640-23a2-11e6-9213-68a3321f20b8.jpeg)

```
PermissionScope.init({
  denieddDefaultActionTitle: 'Settings'
});

PermissionScope.requestEventsPermission();
```
Here is what you should obtain if the permission has not been granted :

![](https://cloud.githubusercontent.com/assets/579922/15592735/7da12b86-23a6-11e6-8a1b-a9d995d5e4a8.jpg)

## App

An app is available in the `tests/app` folder and is generated from the [Cordova Plugin TestFramework](https://github.com/apache/cordova-plugin-test-framework).
It permits to launch auto tests and manual tests.

To install it, please run the following command :

```
npm run prepare && npm run app
```
