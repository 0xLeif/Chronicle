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
    
    func testFormatter() {
        let label = "com.example.formatter"
        let formatter = Chronicle.DefaultFormatters.DefaultFormatter()
        
        let log = Chronicle.LogLevel.success("Hello, World!")
        
        let formattedDate = formatter.dateFormatter.string(from: Date())
        
        let formattedLabel = formatter.format(label: label)
        
        let formattedLogMessage = formatter.format(logLevel: log)
        
        XCTAssertEqual(formattedLabel, "[com.example.formatter]")
        XCTAssertEqual(formattedLogMessage, "✅: Hello, World!")
        
        let logOutput = formatter.output(
            formattedDate: formattedDate,
            formattedLabel: formattedLabel,
            formattedLogMessage: formattedLogMessage
        )
        
        XCTAssertEqual(logOutput, Chronicle(label: label).log(level: log))
    }
    
    static var allTests = [
        ("testExample", testExample),
        ("testFormatter", testFormatter)
    ]
}
