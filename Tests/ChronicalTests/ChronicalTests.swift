import XCTest
@testable import Chronical

final class ChronicalTests: XCTestCase {
    func testExample() {
        let chrono = Chronical(
            label: "com.example.chronical"
        )
        
        enum SomeError: Error { case abc }
        
        chrono.log(level: .success("Success"))
        chrono.log(level: .info("Info"))
        chrono.log(level: .warning("Warning"))
        chrono.log(level: .error("Error", SomeError.abc))
        chrono.log(level: .fatal("Fatal", SomeError.abc))
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
}
