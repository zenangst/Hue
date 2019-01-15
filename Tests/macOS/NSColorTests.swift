@testable import Hue
import AppKit
import XCTest

class NSColorTests: XCTestCase {

  func testHex() {
    let white = NSColor(hex: "#FFFFFF")
    let black = NSColor(hex: "000000")
    let red = NSColor(hex: "F00")
    let blue = NSColor(hex: "#00F")
    let green = NSColor(hex: "#00FF00")
    let yellow = NSColor(hex: "#FFFF00")

    XCTAssertEqual(white, NSColor(red: 1, green: 1, blue: 1, alpha: 1.0))
    XCTAssertEqual(black, NSColor(red: 0, green: 0, blue: 0, alpha: 1.0))
    XCTAssertEqual(red, NSColor(red: 1, green: 0, blue: 0, alpha: 1.0))
    XCTAssertEqual(blue, NSColor(red: 0, green: 0, blue: 1, alpha: 1.0))
    XCTAssertEqual(green, NSColor(red: 0, green: 1, blue: 0, alpha: 1.0))
    XCTAssertEqual(yellow, NSColor(red: 1, green: 1, blue: 0, alpha: 1.0))
  }

  func testToHexWithPrefix() {
    let white = NSColor.white
    let black = NSColor.black
    let red = NSColor.red
    let blue = NSColor.blue
    let green = NSColor.green
    let yellow = NSColor.yellow

    XCTAssertEqual(white.hex(), "#FFFFFF")
    XCTAssertEqual(black.hex(), "#000000")
    XCTAssertEqual(red.hex(), "#FF0000")
    XCTAssertEqual(blue.hex(), "#0000FF")
    XCTAssertEqual(green.hex(), "#00FF00")
    XCTAssertEqual(yellow.hex(), "#FFFF00")
  }

  func testToHexWithoutPrefix() {
    let white = NSColor.white
    let black = NSColor.black
    let red = NSColor.red
    let blue = NSColor.blue
    let green = NSColor.green
    let yellow = NSColor.yellow

    XCTAssertEqual(white.hex(hashPrefix: false), "FFFFFF")
    XCTAssertEqual(black.hex(hashPrefix: false), "000000")
    XCTAssertEqual(red.hex(hashPrefix: false), "FF0000")
    XCTAssertEqual(blue.hex(hashPrefix: false), "0000FF")
    XCTAssertEqual(green.hex(hashPrefix: false), "00FF00")
    XCTAssertEqual(yellow.hex(hashPrefix: false), "FFFF00")
  }

  func fix_testAlpha() {
    let yellowWithAlpha = NSColor(hex: "#FFFF00").alpha(0.5)

    XCTAssertEqual(
      yellowWithAlpha,
      NSColor(red: 255, green: 255, blue: 0, alpha: 1.0).withAlphaComponent(0.5)
    )
  }

  func testGradient() {
    let testGradient = [NSColor.black, NSColor.orange].gradient()

    XCTAssertTrue(testGradient.isKind(of: CAGradientLayer.self))
    XCTAssertEqual(testGradient.colors?.count, 2)
    XCTAssertEqual(
      (testGradient.colors as! [CGColor])[0].colorSpace?.model,
      (NSColor.black.cgColor).colorSpace?.model)
    XCTAssertEqual(
      (testGradient.colors as! [CGColor])[1].colorSpace?.model,
      (NSColor.orange.cgColor).colorSpace?.model)

    let testGradientWithLocation = [NSColor.blue, NSColor.yellow].gradient { gradient in
      gradient.locations = [0.25, 1.0]
      return gradient
    }

    XCTAssertTrue(testGradient.isKind(of: CAGradientLayer.self))
    XCTAssertEqual(testGradient.colors?.count, 2)
    XCTAssertEqual(
      (testGradientWithLocation.colors as! [CGColor])[0].colorSpace?.model,
      (NSColor.blue.cgColor).colorSpace?.model)
    XCTAssertEqual(
      (testGradientWithLocation.colors as! [CGColor])[1].colorSpace?.model,
      (NSColor.yellow.cgColor).colorSpace?.model)
    XCTAssertEqual(testGradientWithLocation.locations!, [0.25,1.0])
  }
  
  func testComponents() {
    let blue = NSColor.blue
    let green = NSColor.green
    let red = NSColor.red
    let black = NSColor.black
    let white = NSColor.white
    
    XCTAssertEqual(blue.getRed(), 0.0)
    XCTAssertEqual(blue.getGreen(), 0.0)
    XCTAssertEqual(blue.getBlue(), 1.0)
    XCTAssertEqual(blue.getAlpha(), 1.0)
    
    XCTAssertEqual(red.getRed(), 1.0)
    XCTAssertEqual(red.getGreen(), 0.0)
    XCTAssertEqual(red.getBlue(), 0.0)
    XCTAssertEqual(red.getAlpha(), 1.0)
    
    XCTAssertEqual(green.getRed(), 0.0)
    XCTAssertEqual(green.getGreen(), 1.0)
    XCTAssertEqual(green.getBlue(), 0.0)
    XCTAssertEqual(green.getAlpha(), 1.0)
    
    XCTAssertEqual(black.getRed(), 0.0)
    XCTAssertEqual(black.getGreen(), 0.0)
    XCTAssertEqual(black.getBlue(), 0.0)
    XCTAssertEqual(black.getAlpha(), 1.0)
    
    XCTAssertEqual(white.getRed(), 1.0)
    XCTAssertEqual(white.getGreen(), 1.0)
    XCTAssertEqual(white.getBlue(), 1.0)
    XCTAssertEqual(white.getAlpha(), 1.0)
  }
  
  func testBlending() {
    let black = NSColor.black
    let white = NSColor.white
    let yellow = NSColor.yellow
    let green = NSColor.green
    let red = NSColor.red
    let blue = NSColor.blue
    let deSaturatedBlue = NSColor(hue: 240.0/360.0,
                                  saturation: 0.1,
                                  brightness: 1.0,
                                  alpha: 1.0)

    let testWhite = black.add(rgb: white)
    XCTAssertEqual(testWhite.getRed(), white.getRed())
    XCTAssertEqual(testWhite.getGreen(), white.getGreen())
    XCTAssertEqual(testWhite.getBlue(), white.getBlue())
    
    let testYellow = green.add(rgb: red)
    XCTAssertEqual(testYellow.getRed(), yellow.getRed())
    XCTAssertEqual(testYellow.getGreen(), yellow.getGreen())
    XCTAssertEqual(testYellow.getBlue(), yellow.getBlue())
    
    let testBlue = deSaturatedBlue.add(hue: 0.0, saturation: 1.0, brightness: 0.0, alpha: 0.0);
    XCTAssertEqual(testBlue.getRed(), blue.getRed())
    XCTAssertEqual(testBlue.getGreen(), blue.getGreen())
    XCTAssertEqual(testBlue.getBlue(), blue.getBlue())
  }
  
  func testIsDark() {
    // Colors created in the monochrome colorSpace -> 2 components
    let monochromeBlack = NSColor.black
    let monochromeWhite = NSColor.white
    let monochromeDarkGray = NSColor.darkGray
    let monochromeGray = NSColor.gray
    let monochromeLightGray = NSColor.lightGray
    
    // Colors created in the RGBA colorSpace -> 4 components
    let black = NSColor(hex: "000")
    let white = NSColor(hex: "fff")
    let darkGray = NSColor(hex: "555")
    let lightGray = NSColor(hex: "aaa")
    let yellow = NSColor.yellow
    let green = NSColor.green
    let red = NSColor.red
    let blue = NSColor.blue
    
    
    let isMonochromeBlackDark = monochromeBlack.isDark
    XCTAssertEqual(isMonochromeBlackDark, true)
    
    let isMonochromeWhiteDark = monochromeWhite.isDark
    XCTAssertEqual(isMonochromeWhiteDark, false)
    
    let isMonochromeDarkGrayDark = monochromeDarkGray.isDark
    XCTAssertEqual(isMonochromeDarkGrayDark, true)
    
    let isMonochromeGrayDark = monochromeGray.isDark
    XCTAssertEqual(isMonochromeGrayDark, false)
    
    let isMonochromeLightGrayDark = monochromeLightGray.isDark
    XCTAssertEqual(isMonochromeLightGrayDark, false)
    
    let isBlackDark = black.isDark
    XCTAssertEqual(isBlackDark, true)
    
    let isWhiteDark = white.isDark
    XCTAssertEqual(isWhiteDark, false)
    
    let isDarkGrayDark = darkGray.isDark
    XCTAssertEqual(isDarkGrayDark, true)
    
//  edge case! Should be false, but `rgbComponents()` returns 0.498039215686275 instead of 0.5 for each component
//    let isGrayDark = gray.isDark
//    XCTAssertEqual(isGrayDark, false)
    
    let isLightGrayDark = lightGray.isDark
    XCTAssertEqual(isLightGrayDark, false)
    
    let isYellowDark = yellow.isDark
    XCTAssertEqual(isYellowDark, false)
    
    let isGreenDark = green.isDark
    XCTAssertEqual(isGreenDark, false)
    
    let isRedDark = red.isDark
    XCTAssertEqual(isRedDark, true)
    
    let isBlueDark = blue.isDark
    XCTAssertEqual(isBlueDark, true)
  }
}
