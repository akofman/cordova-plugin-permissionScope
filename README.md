[![Twitter: @alexiskofman](https://img.shields.io/badge/contact-@alexiskofman-blue.svg?style=flat)](https://twitter.com/alexiskofman)
[![License](https://img.shields.io/badge/license-apache2-green.svg?style=flat)](https://github.com/akofman/cordova-plugin-permissionScope/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/akofman/cordova-plugin-dbmeter.svg?branch=master&style=flat)](https://travis-ci.org/akofman/cordova-plugin-permissionScope)

# cordova-plugin-permissionScope

This plugin defines a global PermissionScope object, which ...
Although the object is in the global scope, it is not available until after the deviceready event.

## Installation

```
cordova plugin add cordova-plugin-permissionScope --save
```
The iOS part is written in Swift and the [Swift support plugin](https://github.com/akofman/cordova-plugin-add-swift-support) is configured as a dependency.

## Supported Platforms

- iOS

## App

An app is available in the app folder and is generated from the [Cordova Plugin TestFramework](https://github.com/apache/cordova-plugin-test-framework).
It permits to launch auto tests and manual tests.

To install it, please follow these steps :

```
cd app && cordova platform add ios
cordova run ios --device
```
