@testable import Spots
import Foundation
import XCTest
import Brick
import Sugar

class ComponentTests : XCTestCase {

  let json: [String : AnyObject] = [
    "title" : "title1",
    "kind" : "list",
    "span" : 1,
    "meta" : ["foo" : "bar"],
    "items" : [["title" : "item1"]]
  ]

  func testInit() {
    // Test component created with JSON
    let jsonComponent = Component(json)
    XCTAssertEqual(jsonComponent.title, json["title"] as? String)
    XCTAssertEqual(jsonComponent.kind,  json["kind"] as? String)
    XCTAssertEqual(jsonComponent.span,  json["span"] as? CGFloat)

    XCTAssert((jsonComponent.meta as NSDictionary).isEqual(json["meta"] as! NSDictionary))
    XCTAssert(jsonComponent.items.count == 1)

    XCTAssertEqual(jsonComponent.items.first?.title, "item1")

    // Test component created programmatically
    let codeComponent = Component(
      title: json["title"] as! String,
      kind: json["kind"] as! String,
      span: json["span"] as! CGFloat,
      meta: json["meta"] as! [String : String],
      items: [ViewModel(title: "item1")])

    XCTAssertEqual(codeComponent.title, json["title"] as? String)
    XCTAssertEqual(codeComponent.kind,  json["kind"] as? String)
    XCTAssertEqual(codeComponent.span,  json["span"] as? CGFloat)

    XCTAssert((codeComponent.meta as NSDictionary).isEqual(json["meta"] as! NSDictionary))
    XCTAssert(codeComponent.items.count == 1)

    // Compare JSON and programmatically created component
    XCTAssert(jsonComponent == codeComponent)
  }

  func testEquatable() {
    let jsonComponent = Component(json)
    var codeComponent = Component(
      title: json["title"] as! String,
      kind: json["kind"] as! String,
      span: json["span"] as! CGFloat,
      meta: json["meta"] as! [String : String])
    XCTAssertFalse(jsonComponent == codeComponent)

    codeComponent.items.append(ViewModel(title: "item2"))
    XCTAssertFalse(jsonComponent == codeComponent)
  }

  func testComponentDictionary() {
    let jsonComponent = Component(json)

    XCTAssertEqual(jsonComponent.dictionary["title"] as? String, json["title"] as? String)
    XCTAssertEqual(jsonComponent.dictionary["kind"] as? String, json["kind"] as? String)
    XCTAssertEqual(jsonComponent.dictionary["span"] as? CGFloat, json["span"] as? CGFloat)

    XCTAssertEqual((jsonComponent.dictionary["items"] as! [JSONDictionary])[0]["title"] as? String, json["items"]![0]["title"])
    XCTAssertEqual((jsonComponent.dictionary["items"] as! [JSONDictionary]).count, json["items"]!.count)
  }
}
