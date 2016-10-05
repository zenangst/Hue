@testable import Hue
import UIKit
import XCTest

class UIImageTests: XCTestCase {

  var image: UIImage!

  override func setUp() {
    super.setUp()
    let bundle = Bundle(for: self.classForCoder)
    let path = bundle.path(forResource: "Random Access Memories", ofType: "png")!

    image = UIImage(contentsOfFile: path)!
  }

  func testImageColors() {
    let bundle = Bundle(for: self.classForCoder)
    let path = bundle.path(forResource: "Random Access Memories", ofType: "png")!
    let image = UIImage(contentsOfFile: path)!

    XCTAssertNotNil(image)

    let accuracy: CGFloat = 0.001
    let colors = image.colors()
    var (red, green, blue): (CGFloat, CGFloat, CGFloat) = (0,0,0)

    colors.background.getRed(&red, green: &green, blue: &blue, alpha: nil)

    XCTAssertEqualWithAccuracy(red, 0.035, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(green, 0.05, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(blue, 0.054, accuracy: accuracy)

    colors.primary.getRed(&red, green: &green, blue: &blue, alpha: nil)

    XCTAssertEqualWithAccuracy(red, 0.563, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(green, 0.572, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(blue, 0.662, accuracy: accuracy)

    colors.secondary.getRed(&red, green: &green, blue: &blue, alpha: nil)

    XCTAssertEqualWithAccuracy(red, 0.746, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(green, 0.831, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(blue, 0.878, accuracy: accuracy)

    colors.detail.getRed(&red, green: &green, blue: &blue, alpha: nil)

    XCTAssertEqualWithAccuracy(red, 1.000, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(green, 1.000, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(blue, 0.85, accuracy: accuracy)
  }

  func testPixelColorSubscript() {
    XCTAssertNotNil(image)
    XCTAssertNil(image.color(at: CGPoint(x: 1300, y: -1)))
    XCTAssertEqual(image.color(at: CGPoint(x: 0, y: 0))?.hex(), "#090D0E")
    XCTAssertEqual(image.color(at: CGPoint(x: 535, y: 513))?.hex(), "#C8DDF0")
  }
}
