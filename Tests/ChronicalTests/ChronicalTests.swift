import XCTest
@testable import Chronical

final class ChronicalTests: XCTestCase {
    func testExample() {
        let chrono = Chronical(
            label: "com.example.chronical"
        )
        
        enum SomeError: Error { case abc }
        
        chrono.log(level: .success("Success!!"))
        chrono.log(level: .error("ERRRRR", SomeError.abc))
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
}
