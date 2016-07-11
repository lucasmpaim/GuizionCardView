# guizion-card-view

[![CI Status](http://img.shields.io/travis/Lucas/guizion-card-view.svg?style=flat)](https://travis-ci.org/Lucas/guizion-card-view)
[![Version](https://img.shields.io/cocoapods/v/guizion-card-view.svg?style=flat)](http://cocoapods.org/pods/guizion-card-view)
[![License](https://img.shields.io/cocoapods/l/guizion-card-view.svg?style=flat)](http://cocoapods.org/pods/guizion-card-view)
[![Platform](https://img.shields.io/cocoapods/p/guizion-card-view.svg?style=flat)](http://cocoapods.org/pods/guizion-card-view)


![usage-gif](https://github.com/lucasmpaim/GuizionCardView/blob/master/Images/usage-gif.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

    - Swift 2.2
    - XCode 7.3
    - iOS 8.0

## Installation

guizion-card-view is available through [CocoaPods](http://cocoapods.org). To install
it, add the following line to your Podfile:

```ruby
pod "guizion-card-view", :git => 'https://github.com/lucasmpaim/GuizionCardView.git'
```
 - Copy this [font](https://github.com/lucasmpaim/GuizionCardView/blob/master/Example/guizion-card-view/data-latin.ttf?raw=true) to your project
 - Add the following to your Info.plist file.

```xml
<key>UIAppFonts</key>
<array>
    <string>data-latin.ttf</string>
</array>
```

## Usage

 - Add a UIView to your ViewController
 - Set the class to CardView
 - Add the inputs, this library does not add the inputs so that you have all the control of your app layout
 - Call the ```updateNumber(_: String)```, ```updateCCVNumber(_: String)```, ```updateName(_: String)```, ```updateExpirationDate(_: String)``` and ```flip(onComplete: () -> Void)``` functions

## Docs
 - Under development

## Author

Lucas Mrowskovsky Paim, lucasmpaim1@gmail.com

## License

guizion-card-view is available under the MIT license. See the LICENSE file for more info.
