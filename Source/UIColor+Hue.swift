import UIKit

public extension UIColor {

  public var isDarkColor: Bool {
    let RGB = CGColorGetComponents(CGColor)
    return (0.2126 * RGB[0] + 0.7152 * RGB[1] + 0.0722 * RGB[2]) < 0.5
  }

  public var isBlackOrWhite: Bool {
    let RGB = CGColorGetComponents(CGColor)
    return (RGB[0] > 0.91 && RGB[1] > 0.91 && RGB[2] > 0.91) || (RGB[0] < 0.09 && RGB[1] < 0.09 && RGB[2] < 0.09)
  }

  public func isDistinct(color: UIColor) -> Bool {
    let bg = CGColorGetComponents(CGColor)
    let fg = CGColorGetComponents(color.CGColor)
    let threshold: CGFloat = 0.25

    if fabs(bg[0] - fg[0]) > threshold || fabs(bg[1] - fg[1]) > threshold || fabs(bg[2] - fg[2]) > threshold {
      if fabs(bg[0] - bg[1]) < 0.03 && fabs(bg[0] - bg[2]) < 0.03 {
        if fabs(fg[0] - fg[1]) < 0.03 && fabs(fg[0] - fg[2]) < 0.03 {
          return false
        }
      }
      return true
    }
    return false
  }

  public func colorWithMinimumSaturation(minSaturation: CGFloat) -> UIColor {
    var (hue, saturation, brightness, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    return saturation < minSaturation
      ? UIColor(hue: hue, saturation: minSaturation, brightness: brightness, alpha: alpha)
      : self
  }

  public func isContrastingColor(color: UIColor) -> Bool {
    let bg = CGColorGetComponents(CGColor)
    let fg = CGColorGetComponents(color.CGColor)

    let bgLum = 0.2126 * bg[0] + 0.7152 * bg[1] + 0.0722 * bg[2]
    let fgLum = 0.2126 * fg[0] + 0.7152 * fg[1] + 0.0722 * fg[2]
    let contrast = (bgLum > fgLum) ? (bgLum + 0.05)/(fgLum + 0.05):(fgLum + 0.05)/(bgLum + 0.05)

    return 1.6 < contrast
  }

  public static func hex(string: String) -> UIColor {
    var hex = string.hasPrefix("#")
      ? String(string.characters.dropFirst())
      : string

    guard hex.characters.count == 3 || hex.characters.count == 6
      else { return UIColor.whiteColor().colorWithAlphaComponent(0.0) }

    if hex.characters.count == 3 {
      for (index, char) in hex.characters.enumerate() {
        hex.insert(char, atIndex: hex.startIndex.advancedBy(index * 2))
      }
    }

    return UIColor(
      red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
      green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
      blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
  }

  public func alpha(value: CGFloat) -> UIColor {
    return colorWithAlphaComponent(value)
  }
}

public extension Array where Element : UIColor {

  public func gradient(transform: ((inout gradient: CAGradientLayer) -> CAGradientLayer)? = nil) -> CAGradientLayer {
    var gradient = CAGradientLayer()
    gradient.colors = self.map { $0.CGColor }

    if let transform = transform {
      transform(gradient: &gradient)
    }

    return gradient
  }
}
