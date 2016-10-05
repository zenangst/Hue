import Hue
import UIKit
import XCTest

class UIColorTests: XCTestCase {

  func testHex() {
    let white = UIColor(hex: "#FFFFFF")
    let black = UIColor(hex: "000000")
    let red = UIColor(hex: "F00")
    let blue = UIColor(hex: "#00F")
    let green = UIColor(hex: "#00FF00")
    let yellow = UIColor(hex: "#FFFF00")

    XCTAssertEqual(white, UIColor(red: 1, green: 1, blue: 1, alpha: 1.0))
    XCTAssertEqual(black, UIColor(red: 0, green: 0, blue: 0, alpha: 1.0))
    XCTAssertEqual(red, UIColor(red: 1, green: 0, blue: 0, alpha: 1.0))
    XCTAssertEqual(blue, UIColor(red: 0, green: 0, blue: 1, alpha: 1.0))
    XCTAssertEqual(green, UIColor(red: 0, green: 1, blue: 0, alpha: 1.0))
    XCTAssertEqual(yellow, UIColor(red: 1, green: 1, blue: 0, alpha: 1.0))
  }

  func testToHexWithPrefix() {
    let white = UIColor.white
    let black = UIColor.black
    let red = UIColor.red
    let blue = UIColor.blue
    let green = UIColor.green
    let yellow = UIColor.yellow

    XCTAssertEqual(white.hex(), "#FFFFFF")
    XCTAssertEqual(black.hex(), "#000000")
    XCTAssertEqual(red.hex(), "#FF0000")
    XCTAssertEqual(blue.hex(), "#0000FF")
    XCTAssertEqual(green.hex(), "#00FF00")
    XCTAssertEqual(yellow.hex(), "#FFFF00")
  }

  func testToHexWithoutPrefix() {
    let white = UIColor.white
    let black = UIColor.black
    let red = UIColor.red
    let blue = UIColor.blue
    let green = UIColor.green
    let yellow = UIColor.yellow

    XCTAssertEqual(white.hex(false), "FFFFFF")
    XCTAssertEqual(black.hex(false), "000000")
    XCTAssertEqual(red.hex(false), "FF0000")
    XCTAssertEqual(blue.hex(false), "0000FF")
    XCTAssertEqual(green.hex(false), "00FF00")
    XCTAssertEqual(yellow.hex(false), "FFFF00")
  }

  func testAlpha() {
    let yellowWithAlpha = UIColor(hex: "#FFFF00").alpha(0.5)

    XCTAssertEqual(yellowWithAlpha, UIColor(red: 1, green: 1, blue: 0, alpha: 1.0).withAlphaComponent(0.5))
  }

  func testGradient() {
    let testGradient = [UIColor.black, UIColor.orange].gradient()

    XCTAssertTrue(testGradient as Any is CAGradientLayer)
    XCTAssertEqual(testGradient.colors?.count, 2)
    XCTAssertEqual(
      (testGradient.colors as! [CGColor])[0].colorSpace!.model,
      UIColor.black.cgColor.colorSpace!.model)
    XCTAssertEqual(
      (testGradient.colors as! [CGColor])[1].colorSpace!.model,
      UIColor.orange.cgColor.colorSpace!.model)

    let testGradientWithLocation = [UIColor.blue, UIColor.yellow].gradient { gradient in
      gradient.locations = [0.25, 1.0]
      return gradient
    }

    XCTAssertTrue(testGradient as Any is CAGradientLayer)
    XCTAssertEqual(testGradient.colors?.count, 2)
    XCTAssertEqual(
      (testGradientWithLocation.colors as! [CGColor])[0].colorSpace!.model,
      UIColor.blue.cgColor.colorSpace!.model)
    XCTAssertEqual(
      (testGradientWithLocation.colors as! [CGColor])[1].colorSpace!.model,
      UIColor.yellow.cgColor.colorSpace!.model)
    XCTAssertEqual(testGradientWithLocation.locations!, [0.25,1.0])
  }
  
  func testComponents() {
    let blue = UIColor.blue
    let green = UIColor.green
    let red = UIColor.red
    let black = UIColor.black
    let white = UIColor.white
    
    XCTAssertEqual(blue.redComponent, 0.0)
    XCTAssertEqual(blue.greenComponent, 0.0)
    XCTAssertEqual(blue.blueComponent, 1.0)
    XCTAssertEqual(blue.alphaComponent, 1.0)
    
    XCTAssertEqual(red.redComponent, 1.0)
    XCTAssertEqual(red.greenComponent, 0.0)
    XCTAssertEqual(red.blueComponent, 0.0)
    XCTAssertEqual(red.alphaComponent, 1.0)
    
    XCTAssertEqual(green.redComponent, 0.0)
    XCTAssertEqual(green.greenComponent, 1.0)
    XCTAssertEqual(green.blueComponent, 0.0)
    XCTAssertEqual(green.alphaComponent, 1.0)
    
    XCTAssertEqual(black.redComponent, 0.0)
    XCTAssertEqual(black.greenComponent, 0.0)
    XCTAssertEqual(black.blueComponent, 0.0)
    XCTAssertEqual(black.alphaComponent, 1.0)
    
    XCTAssertEqual(white.redComponent, 1.0)
    XCTAssertEqual(white.greenComponent, 1.0)
    XCTAssertEqual(white.blueComponent, 1.0)
    XCTAssertEqual(white.alphaComponent, 1.0)
  }
  
  func testBlending() {
    let black = UIColor.black
    let white = UIColor.white
    let yellow = UIColor.yellow
    let green = UIColor.green
    let red = UIColor.red
    let blue = UIColor.blue
    let deSaturatedBlue = UIColor(hue: 240.0/360.0,
                                  saturation: 0.1,
                                  brightness: 1.0,
                                  alpha: 1.0)
    
    let testWhite = black.addRGB(color: white)
    XCTAssertEqual(testWhite.redComponent, white.redComponent)
    XCTAssertEqual(testWhite.greenComponent, white.greenComponent)
    XCTAssertEqual(testWhite.blueComponent, white.blueComponent)
    
    let testYellow = green.addRGB(color: red)
    XCTAssertEqual(testYellow.redComponent, yellow.redComponent)
    XCTAssertEqual(testYellow.greenComponent, yellow.greenComponent)
    XCTAssertEqual(testYellow.blueComponent, yellow.blueComponent)
    
    let testBlue = deSaturatedBlue.addHue(0.0, saturation: 0.9, brightness: 0.0, alpha: 0.0);
    XCTAssertEqual(testBlue.redComponent, blue.redComponent)
    XCTAssertEqual(testBlue.greenComponent, blue.greenComponent)
    XCTAssertEqual(testBlue.blueComponent, blue.blueComponent)
  }
}
