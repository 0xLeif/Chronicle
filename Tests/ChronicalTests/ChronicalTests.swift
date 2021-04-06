import XCTest
@testable import Chronical

final class ChronicalTests: XCTestCase {
    func testExample() {
        let chrono = Chronical(
            label: "com.example.chronical"
        )
        
        enum SomeError: Error { case abc }
        
        XCTAssert(chrono.log(level: .success("Success")).contains("[com.example.chronical] ✅: Success"))
        XCTAssert(chrono.log(level: .info("Info")).contains("[com.example.chronical] ℹ️: Info"))
        XCTAssert(chrono.log(level: .warning("Warning")).contains("[com.example.chronical] ⚠️: Warning"))
        XCTAssert(chrono.log(level: .error("Error", SomeError.abc)).contains("[com.example.chronical] ❗️: Error"))
        XCTAssert(chrono.log(level: .fatal("Fatal", SomeError.abc)).contains("[com.example.chronical] 🚨: Fatal"))
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
}
