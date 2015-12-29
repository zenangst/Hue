# Hue

Hue is the all-in-one coloring utility that you'll ever need.

[![CI Status](http://img.shields.io/travis/hyperoslo/Hue.svg?style=flat)](https://travis-ci.org/hyperoslo/Hue)
[![Version](https://img.shields.io/cocoapods/v/Hue.svg?style=flat)](http://cocoadocs.org/docsets/Hue)
[![License](https://img.shields.io/cocoapods/l/Hue.svg?style=flat)](http://cocoadocs.org/docsets/Hue)
[![Platform](https://img.shields.io/cocoapods/p/Hue.svg?style=flat)](http://cocoadocs.org/docsets/Hue)

## Usage

#### Hex

```swift
let white = UIColor.hex("#ffffff")
let black = UIColor.hex("#000000")
let red = UIColor.hex("#ff0000")
let blue = UIColor.hex("#0000ff")
let green = UIColor.hex("#00ff00")
let yellow = UIColor.hex("#ffff00")
```

#### Alpha

```swift
let colorWithAlpha = myColor.alpha(0.75)
```

#### Gradients

```swift
let gradient = [UIColor.blackColor(), UIColor.orangeColor()].gradient()
// returns CAGradientLayer
```

#### Image colors
```swift
let image = UIImage(named: "My Image")
let (background, primary, secondary, detail) = image.colors()
```

## Installation

**Hue** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Hue'
```

## Author

Hyper Interaktiv AS, ios@hyper.no

## Credits

Credit goes out to Panic Inc who created [ColorArt](https://github.com/panicinc/ColorArt) which deeply inspired the functionality behind image color analysis.

## License

**Hue** is available under the MIT license. See the LICENSE file for more info.
