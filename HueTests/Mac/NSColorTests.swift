@testable import Hue
import AppKit
import XCTest

class NSColorTests: XCTestCase {

  func testHex() {
    let white = NSColor.hex("#FFFFFF")
    let black = NSColor.hex("000000")
    let red = NSColor.hex("F00")
    let blue = NSColor.hex("#00F")
    let green = NSColor.hex("#00FF00")
    let yellow = NSColor.hex("#FFFF00")

    XCTAssertEqual(white, NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    XCTAssertEqual(black, NSColor(red: 0, green: 0, blue: 0, alpha: 1.0))
    XCTAssertEqual(red, NSColor(red: 1.0, green: 0, blue: 0, alpha: 1.0))
    XCTAssertEqual(blue, NSColor(red: 0, green: 0, blue: 1.0, alpha: 1.0))
    XCTAssertEqual(green, NSColor(red: 0, green: 1.0, blue: 0, alpha: 1.0))
    XCTAssertEqual(yellow, NSColor(red: 1.0, green: 1.0, blue: 0, alpha: 1.0))
  }

  func testToHexWithPrefix() {
    let white = NSColor.whiteColor()
    let black = NSColor.blackColor()
    let red = NSColor.redColor()
    let blue = NSColor.blueColor()
    let green = NSColor.greenColor()
    let yellow = NSColor.yellowColor()

    XCTAssertEqual(white.hex(), "#FFFFFF")
    XCTAssertEqual(black.hex(), "#000000")
    XCTAssertEqual(red.hex(), "#FF0000")
    XCTAssertEqual(blue.hex(), "#0000FF")
    XCTAssertEqual(green.hex(), "#00FF00")
    XCTAssertEqual(yellow.hex(), "#FFFF00")
  }

  func testToHexWithoutPrefix() {
    let white = NSColor.whiteColor()
    let black = NSColor.blackColor()
    let red = NSColor.redColor()
    let blue = NSColor.blueColor()
    let green = NSColor.greenColor()
    let yellow = NSColor.yellowColor()

    XCTAssertEqual(white.hex(withPrefix: false), "FFFFFF")
    XCTAssertEqual(black.hex(withPrefix: false), "000000")
    XCTAssertEqual(red.hex(withPrefix: false), "FF0000")
    XCTAssertEqual(blue.hex(withPrefix: false), "0000FF")
    XCTAssertEqual(green.hex(withPrefix: false), "00FF00")
    XCTAssertEqual(yellow.hex(withPrefix: false), "FFFF00")
  }

  func testAlpha() {
    let yellowWithAlpha = NSColor.hex("#FFFF00").alpha(0.5)

    XCTAssertEqual(yellowWithAlpha, NSColor(red: 1.0, green: 1.0, blue: 0, alpha: 1.0).colorWithAlphaComponent(0.5))
  }

  func testGradient() {
    let testGradient = [NSColor.blackColor(), NSColor.orangeColor()].gradient()

    XCTAssertTrue(testGradient.isKindOfClass(CAGradientLayer))
    XCTAssertEqual(testGradient.colors?.count, 2)
    XCTAssertEqual(
      CGColorSpaceGetModel(CGColorGetColorSpace((testGradient.colors as! [CGColor])[0])!),
      CGColorSpaceGetModel(CGColorGetColorSpace(NSColor.blackColor().CGColor)!))
    XCTAssertEqual(
      CGColorSpaceGetModel(CGColorGetColorSpace((testGradient.colors as! [CGColor])[1])!),
      CGColorSpaceGetModel(CGColorGetColorSpace(NSColor.orangeColor().CGColor)!))

    let testGradientWithLocation = [NSColor.blueColor(), NSColor.yellowColor()].gradient { gradient in
      gradient.locations = [0.25, 1.0]
      return gradient
    }

    XCTAssertTrue(testGradient.isKindOfClass(CAGradientLayer))
    XCTAssertEqual(testGradient.colors?.count, 2)
    XCTAssertEqual(
      CGColorSpaceGetModel(CGColorGetColorSpace((testGradientWithLocation.colors as! [CGColor])[0])!),
      CGColorSpaceGetModel(CGColorGetColorSpace(NSColor.blueColor().CGColor)!))
    XCTAssertEqual(
      CGColorSpaceGetModel(CGColorGetColorSpace((testGradientWithLocation.colors as! [CGColor])[1])!),
      CGColorSpaceGetModel(CGColorGetColorSpace(NSColor.yellowColor().CGColor)!))
    XCTAssertEqual(testGradientWithLocation.locations!, [0.25,1.0])
  }
  
  func testComponents() {
    let blue = NSColor.blueColor()
    let green = NSColor.greenColor()
    let red = NSColor.redColor()
    let black = NSColor.blackColor()
    let white = NSColor.whiteColor()
    
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
    let black = NSColor.blackColor()
    let white = NSColor.whiteColor()
    let yellow = NSColor.yellowColor()
    let green = NSColor.greenColor()
    let red = NSColor.redColor()
    let blue = NSColor.blueColor()
    let deSaturatedBlue = NSColor(hue: 240.0/360.0,
                                  saturation: 0.1,
                                  brightness: 1.0,
                                  alpha: 1.0)
    
    let testWhite = black.addRGB(white)
    XCTAssertEqual(testWhite.getRed(), white.getRed())
    XCTAssertEqual(testWhite.getGreen(), white.getGreen())
    XCTAssertEqual(testWhite.getBlue(), white.getBlue())
    
    let testYellow = green.addRGB(red)
    XCTAssertEqual(testYellow.getRed(), yellow.getRed())
    XCTAssertEqual(testYellow.getGreen(), yellow.getGreen())
    XCTAssertEqual(testYellow.getBlue(), yellow.getBlue())
    
    let testBlue = deSaturatedBlue.addHue(0.0, saturation: 1.0, brightness: 0.0, alpha: 0.0);
    XCTAssertEqual(testBlue.getRed(), blue.getRed())
    XCTAssertEqual(testBlue.getGreen(), blue.getGreen())
    XCTAssertEqual(testBlue.getBlue(), blue.getBlue())
  }
}
