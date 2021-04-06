import XCTest
@testable import Chronicle

final class ChronicleTests: XCTestCase {
    func testExample() {
        let chrono = Chronicle(
            label: "com.example.chronicle"
        )
        
        enum SomeError: Error { case abc }
        
        XCTAssert(chrono.log(level: .success("Success")).contains("[com.example.chronicle] ✅: Success"))
        XCTAssert(chrono.log(level: .info("Info")).contains("[com.example.chronicle] ℹ️: Info"))
        XCTAssert(chrono.log(level: .warning("Warning")).contains("[com.example.chronicle] ⚠️: Warning"))
        XCTAssert(chrono.log(level: .error("Error", SomeError.abc)).contains("[com.example.chronicle] ❗️: Error"))
        XCTAssert(chrono.log(level: .fatal("Fatal", SomeError.abc)).contains("[com.example.chronicle] 🚨: Fatal"))
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
}
