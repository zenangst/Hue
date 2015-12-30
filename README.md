![Hue](https://github.com/hyperoslo/Hue/blob/master/Images/cover.png)

Hue is the all-in-one coloring utility that you'll ever need.

[![CI Status](http://img.shields.io/travis/hyperoslo/Hue.svg?style=flat)](https://travis-ci.org/hyperoslo/Hue)
[![Version](https://img.shields.io/cocoapods/v/Hue.svg?style=flat)](http://cocoadocs.org/docsets/Hue)
[![License](https://img.shields.io/cocoapods/l/Hue.svg?style=flat)](http://cocoadocs.org/docsets/Hue)
[![Platform](https://img.shields.io/cocoapods/p/Hue.svg?style=flat)](http://cocoadocs.org/docsets/Hue)

## Usage

#### Hex
<img src="https://raw.githubusercontent.com/hyperoslo/Hue/master/Images/icon_v3.png" alt="Hue Icon" align="right" />You can easily use hex colors with the `.hex` method on `UIColor`. It supports the following hex formats `#ffffff`, `ffffff`, `#fff`, `fff`
```swift
let white = UIColor.hex("#ffffff")
let black = UIColor.hex("#000000")
let red = UIColor.hex("#ff0000")
let blue = UIColor.hex("#0000ff")
let green = UIColor.hex("#00ff00")
let yellow = UIColor.hex("#ffff00")
```

#### Computed color properties
```swift
let white = UIColor.hex("#ffffff")
let black = UIColor.hex("#000000")

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

## Examples
<img src="https://raw.githubusercontent.com/hyperoslo/Hue/master/Images/hex-screenshot.png" alt="Hex Example screenshot" align="right" />
#### Hex
This very simple example that displays a bunch of color schemes in a Carousel view. It uses hex to set the color for the schemes. It leverages from `.isDarkColor` to make the text color readable in all scenarios. The demo also features [Spots](http://github.com/hyperoslo/Spots) for rendering the Carousel view.


## Installation

**Hue** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Hue'
```

## Author

[Hyper](http://hyper.no) made this with ❤️. If you’re using this library we probably want to [hire you](https://github.com/hyperoslo/iOS-playbook/blob/master/HYPER_RECIPES.md)! Send us an email at ios@hyper.no.

## Contribute

We would love you to contribute to **Hue**, check the [CONTRIBUTING](https://github.com/hyperoslo/Hue/blob/master/CONTRIBUTING.md) file for more info.

## Credits

Credit goes out to Panic Inc who created [ColorArt](https://github.com/panicinc/ColorArt) and [@jathu](https://github.com/jathu) for his work on [UIImageColors](https://github.com/jathu/UIImageColors) which deeply inspired the functionality behind the image color analysis.

## License

**Hue** is available under the MIT license. See the LICENSE file for more info.
