import UIKit
import XCTest

class UIImageTests: XCTestCase {

  func testImageColors() {
    let accuracy: CGFloat = 0.001
    let bundle = NSBundle(forClass: self.classForCoder)
    let path = bundle.pathForResource("Random Access Memories", ofType: "png")!
    let image = UIImage(contentsOfFile: path)!

    XCTAssertNotNil(image)

    var (red, green, blue): (CGFloat, CGFloat, CGFloat) = (0,0,0)
    let (background, primary, secondary, detail) = image.colors()

    background?.getRed(&red, green: &green, blue: &blue, alpha: nil)

    XCTAssertEqualWithAccuracy(red, 0.035, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(green, 0.05, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(blue, 0.054, accuracy: accuracy)

    primary?.getRed(&red, green: &green, blue: &blue, alpha: nil)

    XCTAssertEqualWithAccuracy(red, 0.563, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(green, 0.572, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(blue, 0.662, accuracy: accuracy)

    secondary?.getRed(&red, green: &green, blue: &blue, alpha: nil)

    XCTAssertEqualWithAccuracy(red, 0.746, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(green, 0.831, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(blue, 0.878, accuracy: accuracy)

    detail?.getRed(&red, green: &green, blue: &blue, alpha: nil)

    XCTAssertEqualWithAccuracy(red, 1.000, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(green, 1.000, accuracy: accuracy)
    XCTAssertEqualWithAccuracy(blue, 0.85, accuracy: accuracy)
  }

}
