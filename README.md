![Hue](https://github.com/hyperoslo/Hue/blob/master/Images/cover.png)

Hue is the all-in-one coloring utility that you'll ever need.

[![Version](https://img.shields.io/cocoapods/v/Hue.svg?style=flat)](http://cocoadocs.org/docsets/Hue)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Hue.svg?style=flat)](http://cocoadocs.org/docsets/Hue)
[![Platform](https://img.shields.io/cocoapods/p/Hue.svg?style=flat)](http://cocoadocs.org/docsets/Hue)
![Swift](https://img.shields.io/badge/%20in-swift%204.0-orange.svg)

## Usage

#### Hex
<img src="https://raw.githubusercontent.com/hyperoslo/Hue/master/Images/icon_v3.png" alt="Hue Icon" align="right" />You can easily use hex colors with the `init(hex:)` convenience initializer on `UIColor`. It supports the following hex formats `#ffffff`, `ffffff`, `#fff`, `fff`
```swift
let white = UIColor(hex: "#ffffff")
let black = UIColor(hex: "#000000")
let red = UIColor(hex: "#ff0000")
let blue = UIColor(hex: "#0000ff")
let green = UIColor(hex: "#00ff00")
let yellow = UIColor(hex: "#ffff00")
```

#### Computed color properties
```swift
let white = UIColor(hex: "#ffffff")
let black = UIColor(hex: "#000000")

if white.isDarkColor {} // return false
if white.isBlackOrWhite {} // return true
```

#### Alpha
`.alpha` is a sugar for `colorWithAlphaComponent`, internally it does the exact same thing, think of it as a
lipstick for your implementation.
```swift
let colorWithAlpha = myColor.alpha(0.75)
```

#### Gradients
You can easily create gradient layers using the `gradient()` method on arrays with `UIColor`.
As an extra bonus, you can also add a transform closure if you want to modify the `CAGradientLayer`.

```swift
let gradient = [UIColor.blackColor(), UIColor.orangeColor()].gradient()

let secondGradient = [UIColor.blackColor(), UIColor.orangeColor()].gradient { gradient in
  gradient.locations = [0.25, 1.0]
  return gradient
}
```

#### Image colors
```swift
let image = UIImage(named: "My Image")
let (background, primary, secondary, detail) = image.colors()
```

#### Components
You can get red, green, blue, and alpha components from any UIColor by using the (red|green|blue|alpha)Component property.

```swift
let myColor = UIColor(hex: "#ffafc2")
let myColorBlueComponent = myColor.blueComponent
let myColorGreenComponent = myColor.greenComponent
let myColorRedComponent = myColor.redComponent
let myColorAlphaComponent = myColor.alphaComponent
```

#### Blending
```swift
let red = UIColor.redColor()
let green = UIColor.greenColor()
let yellow = red.addRGB(green)

let desaturatedBlue = UIColor(hex: "#aaaacc")
let saturatedBlue = desaturatedBlue.addHue(0.0, saturation: 1.0, brightness: 0.0, alpha: 0.0)
```

## Examples
<img src="https://raw.githubusercontent.com/hyperoslo/Hue/master/Images/hex-screenshot.png" alt="Hex Example screenshot" align="right" />

#### Hex
This super simple example that displays a bunch of color schemes in a Carousel view.

It uses hex to set the color for the schemes. It leverages from `.isDarkColor` to make the text color readable in all scenarios.

The demo also features [Spots](http://github.com/hyperoslo/Spots) for rendering the Carousel view.

**Example code:**

```swift
let color = UIColor(hex: "#3b5998")
backgroundColor = color
label.textColor = color.isDark
  ? UIColor.whiteColor()
  : UIColor.darkGrayColor()
```

#### Gradients
<img src="https://raw.githubusercontent.com/hyperoslo/Hue/master/Images/gradients-screenshot.gif" alt="Gradients Example screenshot" align="right" width="236" />

This examples shows how much fun you can have with combining `CAGradientLayer` with `CABasicAnimation`.

It uses `.hex` for getting the colors and `.gradient()` for transforming
a collection of `UIColor`'s into a `CAGradientLayer`.

The demo features [Spots](http://github.com/hyperoslo/Spots) for rendering the list view and [Fakery](https://github.com/vadymmarkov/Fakery) for generating random content strings.

**Extract from the demo:**
```swift
lazy var gradient: CAGradientLayer = [
  UIColor(hex: "#FD4340"),
  UIColor(hex: "#CE2BAE")
  ].gradient { gradient in
    gradient.speed = 0
    gradient.timeOffset = 0

    return gradient
  }
```

## Installation

**Hue** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Hue'
```

**Hue** is also available through [Carthage](https://github.com/Carthage/Carthage).
To install just write into your Cartfile:

```ruby
github "hyperoslo/Hue"
```

## Author

[Hyper](http://hyper.no) made this with ❤️

## Contribute

We would love you to contribute to **Hue**, check the [CONTRIBUTING](https://github.com/hyperoslo/Hue/blob/master/CONTRIBUTING.md) file for more info.

## Credits

Credit goes out to Panic Inc who created [ColorArt](https://github.com/panicinc/ColorArt) and [@jathu](https://github.com/jathu) for his work on [UIImageColors](https://github.com/jathu/UIImageColors) which deeply inspired the functionality behind the image color analysis.

## License

**Hue** is available under the MIT license. See the LICENSE file for more info.
