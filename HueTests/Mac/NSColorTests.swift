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

    XCTAssertEqual(white, NSColor(red: 255, green: 255, blue: 255, alpha: 1.0))
    XCTAssertEqual(black, NSColor(red: 0, green: 0, blue: 0, alpha: 1.0))
    XCTAssertEqual(red, NSColor(red: 255, green: 0, blue: 0, alpha: 1.0))
    XCTAssertEqual(blue, NSColor(red: 0, green: 0, blue: 255, alpha: 1.0))
    XCTAssertEqual(green, NSColor(red: 0, green: 255, blue: 0, alpha: 1.0))
    XCTAssertEqual(yellow, NSColor(red: 255, green: 255, blue: 0, alpha: 1.0))
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

    XCTAssertEqual(yellowWithAlpha, NSColor(red: 255, green: 255, blue: 0, alpha: 1.0).colorWithAlphaComponent(0.5))
  }

  func testGradient() {
    let testGradient = [NSColor.blackColor(), NSColor.orangeColor()].gradient()

    XCTAssertTrue(testGradient.isKindOfClass(CAGradientLayer))
    XCTAssertEqual(testGradient.colors?.count, 2)
    XCTAssertEqual(
      CGColorSpaceGetModel(CGColorGetColorSpace((testGradient.colors as! [CGColor])[0])),
      CGColorSpaceGetModel(CGColorGetColorSpace(NSColor.blackColor().CGColor)))
    XCTAssertEqual(
      CGColorSpaceGetModel(CGColorGetColorSpace((testGradient.colors as! [CGColor])[1])),
      CGColorSpaceGetModel(CGColorGetColorSpace(NSColor.orangeColor().CGColor)))

    let testGradientWithLocation = [NSColor.blueColor(), NSColor.yellowColor()].gradient { gradient in
      gradient.locations = [0.25, 1.0]
      return gradient
    }

    XCTAssertTrue(testGradient.isKindOfClass(CAGradientLayer))
    XCTAssertEqual(testGradient.colors?.count, 2)
    XCTAssertEqual(
      CGColorSpaceGetModel(CGColorGetColorSpace((testGradientWithLocation.colors as! [CGColor])[0])),
      CGColorSpaceGetModel(CGColorGetColorSpace(NSColor.blueColor().CGColor)))
    XCTAssertEqual(
      CGColorSpaceGetModel(CGColorGetColorSpace((testGradientWithLocation.colors as! [CGColor])[1])),
      CGColorSpaceGetModel(CGColorGetColorSpace(NSColor.yellowColor().CGColor)))
    XCTAssertEqual(testGradientWithLocation.locations!, [0.25,1.0])
  }
  
  func testComponents() {
    let blue = NSColor.blueColor()
    let green = NSColor.greenColor()
    let red = NSColor.redColor()
    let black = NSColor.blackColor()
    let white = NSColor.whiteColor()
    
    XCTAssertEqual(blue.red, 0.0)
    XCTAssertEqual(blue.green, 0.0)
    XCTAssertEqual(blue.blue, 1.0)
    XCTAssertEqual(blue.alpha, 1.0)
    
    XCTAssertEqual(red.red, 1.0)
    XCTAssertEqual(red.green, 0.0)
    XCTAssertEqual(red.blue, 0.0)
    XCTAssertEqual(red.alpha, 1.0)
    
    XCTAssertEqual(green.red, 0.0)
    XCTAssertEqual(green.green, 1.0)
    XCTAssertEqual(green.blue, 0.0)
    XCTAssertEqual(green.alpha, 1.0)
    
    XCTAssertEqual(black.red, 0.0)
    XCTAssertEqual(black.green, 0.0)
    XCTAssertEqual(black.blue, 0.0)
    XCTAssertEqual(black.alpha, 1.0)
    
    XCTAssertEqual(white.red, 1.0)
    XCTAssertEqual(white.green, 1.0)
    XCTAssertEqual(white.blue, 1.0)
    XCTAssertEqual(white.alpha, 1.0)
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
    XCTAssertEqual(testWhite.red, white.red)
    XCTAssertEqual(testWhite.green, white.green)
    XCTAssertEqual(testWhite.blue, white.blue)
    
    let testYellow = green.addRGB(red)
    XCTAssertEqual(testYellow.red, yellow.red)
    XCTAssertEqual(testYellow.green, yellow.green)
    XCTAssertEqual(testYellow.blue, yellow.blue)
    
    let testBlue = deSaturatedBlue.addHue(0.0, saturation: 1.0, brightness: 0.0, alpha: 0.0);
    XCTAssertEqual(testBlue.red, blue.red)
    XCTAssertEqual(testBlue.green, blue.green)
    XCTAssertEqual(testBlue.blue, blue.blue)
  }
}
