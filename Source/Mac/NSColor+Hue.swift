import AppKit

// MARK: - Color Builders

public extension NSColor {

  public static func hex(string: String) -> NSColor {
    var hex = string.hasPrefix("#")
      ? String(string.characters.dropFirst())
      : string

    guard hex.characters.count == 3 || hex.characters.count == 6
      else { return NSColor.whiteColor().colorWithAlphaComponent(0.0) }

    if hex.characters.count == 3 {
      for (index, char) in hex.characters.enumerate() {
        hex.insert(char, atIndex: hex.startIndex.advancedBy(index * 2))
      }
    }

    return NSColor(
      red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF),
      green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF),
      blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF), alpha: 1.0)
  }

  public func colorWithMinimumSaturation(minSaturation: CGFloat) -> NSColor {
    var (hue, saturation, brightness, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    return saturation < minSaturation
      ? NSColor(hue: hue, saturation: minSaturation, brightness: brightness, alpha: alpha)
      : self
  }

  public func alpha(value: CGFloat) -> NSColor {
    return colorWithAlphaComponent(value)
  }
}

// MARK: - Helpers

public extension NSColor {

  public func hex(withPrefix withPrefix: Bool = true) -> String {
    var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
    colorUsingColorSpace(NSColorSpace.genericRGBColorSpace())!.getRed(&r, green: &g, blue: &b, alpha: &a)

    let prefix = withPrefix ? "#" : ""

    return String(format: "\(prefix)%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
  }

  public var isDark: Bool {
    let RGB = CGColorGetComponents(CGColor)
    return (0.2126 * RGB[0] + 0.7152 * RGB[1] + 0.0722 * RGB[2]) < 0.5
  }

  public var isBlackOrWhite: Bool {
    let RGB = CGColorGetComponents(CGColor)
    return (RGB[0] > 0.91 && RGB[1] > 0.91 && RGB[2] > 0.91) || (RGB[0] < 0.09 && RGB[1] < 0.09 && RGB[2] < 0.09)
  }
    
  public var isBlack: Bool {
    let RGB = CGColorGetComponents(CGColor)
    return (RGB[0] < 0.09 && RGB[1] < 0.09 && RGB[2] < 0.09)
  }
    
  public var isWhite: Bool {
    let RGB = CGColorGetComponents(CGColor)
    return (RGB[0] > 0.91 && RGB[1] > 0.91 && RGB[2] > 0.91)
  }

  public func isDistinctFrom(color: NSColor) -> Bool {
    let bg = CGColorGetComponents(CGColor)
    let fg = CGColorGetComponents(color.CGColor)
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

  public func isContrastingWith(color: NSColor) -> Bool {
    let bg = CGColorGetComponents(CGColor)
    let fg = CGColorGetComponents(color.CGColor)

    let bgLum = 0.2126 * bg[0] + 0.7152 * bg[1] + 0.0722 * bg[2]
    let fgLum = 0.2126 * fg[0] + 0.7152 * fg[1] + 0.0722 * fg[2]
    let contrast = bgLum > fgLum
      ? (bgLum + 0.05) / (fgLum + 0.05)
      : (fgLum + 0.05) / (bgLum + 0.05)

    return 1.6 < contrast
  }
}

// MARK: - Gradient

public extension Array where Element : NSColor {

  public func gradient(transform: ((inout gradient: CAGradientLayer) -> CAGradientLayer)? = nil) -> CAGradientLayer {
    var gradient = CAGradientLayer()
    gradient.colors = self.map { $0.CGColor }

    if let transform = transform {
      transform(gradient: &gradient)
    }

    return gradient
  }
}

// MARK: - Components

public extension NSColor {
    
    var red : CGFloat {
        get {
            if (self.colorSpace == NSColorSpace.genericGrayColorSpace() ||
                self.colorSpace == NSColorSpace.deviceGrayColorSpace()) {
                return self.whiteComponent
            }
            
            var r : CGFloat = 0
            self.getRed(&r, green: nil , blue: nil, alpha: nil)
            return r
        }
    }
    
    var green : CGFloat {
        get {
            if (self.colorSpace == NSColorSpace.genericGrayColorSpace() ||
                self.colorSpace == NSColorSpace.deviceGrayColorSpace()) {
                return self.whiteComponent
            }
            
            var g : CGFloat = 0
            self.getRed(nil, green: &g , blue: nil, alpha: nil)
            return g
        }
    }
    
    var blue : CGFloat {
        get {
            if (self.colorSpace == NSColorSpace.genericGrayColorSpace() ||
                self.colorSpace == NSColorSpace.deviceGrayColorSpace()) {
                return self.whiteComponent
            }
            
            var b : CGFloat = 0
            self.getRed(nil, green: nil , blue: &b, alpha: nil)
            return b
        }
    }
    
    var alpha : CGFloat {
        get {
            if (self.colorSpace == NSColorSpace.genericGrayColorSpace() ||
                self.colorSpace == NSColorSpace.deviceGrayColorSpace()) {
                return self.alphaComponent
            }
            
            var a : CGFloat = 0
            self.getRed(nil, green: nil , blue: nil, alpha: &a)
            return a
        }
    }
}

// MARK: - Blending

public extension NSColor {
    
    /**adds hue, saturation, and brightness to the HSB components of this color (self)*/
    public func addHue(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> NSColor {
        var (oldHue, oldSat, oldBright, oldAlpha) : (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
        self.getHue(&oldHue, saturation: &oldSat, brightness: &oldBright, alpha: &oldAlpha)
        return NSColor(hue: oldHue + hue, saturation: oldSat + saturation, brightness: oldBright + brightness, alpha: oldAlpha + alpha)
    }
    
    /**adds red, green, and blue to the RGB components of this color (self)*/
    public func addRed(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> NSColor {
        return NSColor(red: self.red + red, green: self.green + green, blue: self.blue + blue, alpha: self.alpha + alpha)
    }
    
    public func addHSB(color: NSColor) -> NSColor {
        var (h,s,b,a) : (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
        color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return self.addHue(h, saturation: s, brightness: b, alpha: 0)
    }
    
    public func addRGB(color: NSColor) -> NSColor {
        return self.addRed(color.red, green: color.green, blue: color.blue, alpha: 0)
    }
    
    public func addHSBA(color: NSColor) -> NSColor {
        var (h,s,b,a) : (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
        color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return self.addHue(h, saturation: s, brightness: b, alpha: a)
    }
    
    /**adds the rgb components of two colors*/
    public func addRGBA(color: NSColor) -> NSColor {
        return self.addRed(color.red, green: color.green, blue: color.blue, alpha: color.alpha)
    }
}
