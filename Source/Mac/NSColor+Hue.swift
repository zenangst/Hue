import AppKit

// MARK: - Color Builders

public extension NSColor {
  /// Constructing color from hex string
  ///
  /// - Parameter hex: A hex string, can either contain # or not
  convenience init(hex: String) {
    var hex = hex.hasPrefix("#")
      ? String(hex.characters.dropFirst())
      : hex

    guard hex.characters.count == 3 || hex.characters.count == 6
      else {
        self.init(white: 1.0, alpha: 0.0)
        return
    }
    if hex.characters.count == 3 {
      for (index, char) in hex.characters.enumerated() {
        hex.insert(char, at: hex.characters.index(hex.startIndex, offsetBy: index * 2))
      }
    }

    self.init(
      red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
      green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
      blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
  }

  /// Adjust color based on saturation
  ///
  /// - Parameter minSaturation: The minimun saturation value
  /// - Returns: The adjusted color
  public func color(minSaturation: CGFloat) -> NSColor {
    var (hue, saturation, brightness, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    return saturation < minSaturation
      ? NSColor(hue: hue, saturation: minSaturation, brightness: brightness, alpha: alpha)
      : self
  }


  /// Convenient method to change alpha value
  ///
  /// - Parameter value: The alpha value
  /// - Returns: The alpha adjusted color
  public func alpha(_ value: CGFloat) -> NSColor {
    return withAlphaComponent(value)
  }
}

// MARK: - Helpers

public extension NSColor {

  public func hex(hashPrefix: Bool = true) -> String {
    var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
    usingColorSpace(NSColorSpace.genericRGB)!.getRed(&r, green: &g, blue: &b, alpha: &a)

    let prefix = hashPrefix ? "#" : ""

    return String(format: "\(prefix)%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
  }
    
  internal func rgbComponents() -> [CGFloat] {
    var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
    usingColorSpace(NSColorSpace.genericRGB)!.getRed(&r, green: &g, blue: &b, alpha: &a)
    
    return [r, g, b]
  }
  
  public var isDark: Bool {
    let RGB = rgbComponents()
    return (0.2126 * RGB[0] + 0.7152 * RGB[1] + 0.0722 * RGB[2]) < 0.5
  }

  public var isBlackOrWhite: Bool {
    let RGB = rgbComponents()
    return (RGB[0] > 0.91 && RGB[1] > 0.91 && RGB[2] > 0.91) || (RGB[0] < 0.09 && RGB[1] < 0.09 && RGB[2] < 0.09)
  }

  public var isBlack: Bool {
    let RGB = rgbComponents()
    return (RGB[0] < 0.09 && RGB[1] < 0.09 && RGB[2] < 0.09)
  }

  public var isWhite: Bool {
    let RGB = rgbComponents()
    return (RGB[0] > 0.91 && RGB[1] > 0.91 && RGB[2] > 0.91)
  }

  public func isDistinct(from color: NSColor) -> Bool {
    let bg = rgbComponents()
    let fg = color.rgbComponents()
    let threshold: CGFloat = 0.25
    var result = false

    if fabs(bg[0] - fg[0]) > threshold || fabs(bg[1] - fg[1]) > threshold || fabs(bg[2] - fg[2]) > threshold {
      if fabs(bg[0] - bg[1]) < 0.03 && fabs(bg[0] - bg[2]) < 0.03 {
        if fabs(fg[0] - fg[1]) < 0.03 && fabs(fg[0] - fg[2]) < 0.03 {
          result = false
        }
      }
      result = true
    }

    return result
  }

  public func isContrasting(with color: NSColor) -> Bool {
    
    func colorLum(rgb: [CGFloat]) -> CGFloat {
      let r = 0.2126 * rgb[0]
      let g = 0.7152 * rgb[1]
      let b = 0.0722 * rgb[2]
      return r + g + b
    }
    
    let bgComponents = rgbComponents()
    let fgComponents = color.rgbComponents()

    let br = bgComponents[0]
    let bg = bgComponents[1]
    let bb = bgComponents[2]
    let fr = fgComponents[0]
    let fg = fgComponents[1]
    let fb = fgComponents[2]

    let bgLum = 0.2126 * br + 0.7152 * bg + 0.0722 * bb
    let fgLum = 0.2126 * fr + 0.7152 * fg + 0.0722 * fb
    let contrast = bgLum > fgLum
      ? (bgLum + 0.05) / (fgLum + 0.05)
      : (fgLum + 0.05) / (bgLum + 0.05)

    return 1.6 < contrast
  }
}

// MARK: - Gradient

public extension Array where Element : NSColor {

  public func gradient(_ transform: ((_ gradient: inout CAGradientLayer) -> CAGradientLayer)? = nil) -> CAGradientLayer {
    var gradient = CAGradientLayer()
    gradient.colors = self.map { $0.cgColor }

    if let transform = transform {
      gradient = transform(&gradient)
    }

    return gradient
  }
}

// MARK: - Components

public extension NSColor {

  func getRed() -> CGFloat {
    if (self.colorSpace == NSColorSpace.genericGray ||
      self.colorSpace == NSColorSpace.deviceGray) {
      return self.whiteComponent
    }

    var r : CGFloat = 0
    self.getRed(&r, green: nil , blue: nil, alpha: nil)
    return r
  }

  func getGreen() -> CGFloat {
    if (self.colorSpace == NSColorSpace.genericGray ||
      self.colorSpace == NSColorSpace.deviceGray) {
      return self.whiteComponent
    }

    var g : CGFloat = 0
    self.getRed(nil, green: &g , blue: nil, alpha: nil)
    return g
  }

  func getBlue() -> CGFloat {
    if (self.colorSpace == NSColorSpace.genericGray ||
      self.colorSpace == NSColorSpace.deviceGray) {
      return self.whiteComponent
    }

    var b : CGFloat = 0
    self.getRed(nil, green: nil , blue: &b, alpha: nil)
    return b
  }

  func getAlpha() -> CGFloat {
    if (self.colorSpace == NSColorSpace.genericGray ||
      self.colorSpace == NSColorSpace.deviceGray) {
      return self.alphaComponent
    }

    var a : CGFloat = 0
    self.getRed(nil, green: nil , blue: nil, alpha: &a)
    return a
  }
}

// MARK: - Blending

public extension NSColor {

  /**adds hue, saturation, and brightness to the HSB components of this color (self)*/
  public func add(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> NSColor {
    var (oldHue, oldSat, oldBright, oldAlpha) : (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
    self.getHue(&oldHue, saturation: &oldSat, brightness: &oldBright, alpha: &oldAlpha)
    
    // make sure new values doesn't overflow
    var newHue = oldHue + hue
    while newHue < 0.0 { newHue += 1.0 }
    while newHue > 1.0 { newHue -= 1.0 }

    let newBright: CGFloat = max(min(oldBright + brightness, 1.0), 0)
    let newSat: CGFloat = max(min(oldSat + saturation, 1.0), 0)
    let newAlpha: CGFloat = max(min(oldAlpha + alpha, 1.0), 0)
    
    return NSColor(hue: newHue, saturation: newBright, brightness: newSat, alpha: newAlpha)
  }

  /**adds red, green, and blue to the RGB components of this color (self)*/
  public func add(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> NSColor {
    // make sure new values doesn't overflow
    let newRed: CGFloat = max(min(self.getRed() + red, 1.0), 0)
    let newGreen: CGFloat = max(min(self.getGreen() + green, 1.0), 0)
    let newBlue: CGFloat = max(min(self.getBlue() + blue, 1.0), 0)
    let newAlpha: CGFloat = max(min(self.getAlpha() + alpha, 1.0), 0)
    return NSColor(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
  }

  public func add(hsb color: NSColor) -> NSColor {
    var (h,s,b,a) : (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
    color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    return self.add(hue: h, saturation: s, brightness: b, alpha: 0)
  }

  public func add(rgb color: NSColor) -> NSColor {
    return self.add(red: color.getRed(), green: color.getGreen(), blue: color.getBlue(), alpha: 0)
  }

  public func add(hsba color: NSColor) -> NSColor {
    var (h,s,b,a) : (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
    color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    return self.add(hue: h, saturation: s, brightness: b, alpha: a)
  }

  /**adds the rgb components of two colors*/
  public func add(rgba color: NSColor) -> NSColor {
    return self.add(red: color.getRed(), green: color.getGreen(), blue: color.getBlue(), alpha: color.getAlpha())
  }
}
