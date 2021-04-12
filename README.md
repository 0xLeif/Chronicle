# Chronicle

*Simple Swift Logger in under 90 loc*

### Default Format

**`{Date} {Label} {Emoji}: {Message}`**

4/5/21, 7:05:42 PM CDT [com.example.chronicle] ℹ️: Info
```
Date = 4/5/21, 7:05:42 PM CDT
Label = [com.example.chronicle]
Emoji = ℹ️
Message = Info
```

## Examples

### Default Chronicle
```swift
let chrono = Chronicle(
    label: "com.example.chronicle"
)

enum SomeError: Error { case abc }

chrono.log(level: .success("Success"))
chrono.log(level: .info("Info"))
chrono.log(level: .warning("Warning"))
chrono.log(level: .error("Error", SomeError.abc))
chrono.log(level: .fatal("Fatal", SomeError.abc))
```

**Logging**
```
4/9/21, 9:42:08 PM CDT [com.example.chronicle] ✅: Success
4/9/21, 9:42:08 PM CDT [com.example.chronicle] ℹ️: Info
4/9/21, 9:42:08 PM CDT [com.example.chronicle] ⚠️: Warning
4/9/21, 9:42:08 PM CDT [com.example.chronicle] ❗️: Error
{
	abc: The operation couldn’t be completed. (ChronicleTests.ChronicleTests.(unknown context at $10708b2f8).(unknown context at $10708b344).SomeError error 0.)
}
4/9/21, 9:42:08 PM CDT [com.example.chronicle] 🚨: Fatal
{
	abc: The operation couldn’t be completed. (ChronicleTests.ChronicleTests.(unknown context at $10708b2f8).(unknown context at $10708b344).SomeError error 0.)
}
```


## Output Formatter
```swift
public protocol ChronicleFormatter {
    var dateFormatter: DateFormatter { get }
    func format(label: String) -> String
    func format(logLevel: Chronicle.LogLevel) -> String
    func output(
        formattedDate: String,
        formattedLabel: String,
        formattedLogMessage: String
    ) -> String
}
```

### Default Formatter

```swift
extension Chronicle {
    public struct DefaultFormatters {
        public struct DefaultFormatter: ChronicleFormatter {
            public init() { }
            
            public var dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                
                formatter.dateStyle = .short
                formatter.timeStyle = .long
                
                return formatter
            }()
            
            public func format(label: String) -> String { "[\(label)]" }
            
            public func format(logLevel: Chronicle.LogLevel) -> String {
                "\(logLevel.emoji): \(logLevel.output)"
            }
            
            public func output(
                formattedDate: String,
                formattedLabel: String,
                formattedLogMessage: String
            ) -> String {
                formattedDate + " " + formattedLabel + " " + formattedLogMessage
            }
        }
    }
}
```

### Output Handler

```swift
public protocol ChronicleHandler {
    func handle(output: String) -> Void
    func didHandle(chronicle: Chronicle, level: Chronicle.LogLevel)
}
```

### Default Handlers

```swift
extension Chronicle {
    public struct DefaultHandlers {
        public struct PrintHandler: ChronicleHandler {
            public init() { }
            
            public func handle(output: String) { print(output) }
            
            public func didHandle(chronicle: Chronicle, level: Chronicle.LogLevel) { }
        }
        
        public struct FileHandler: ChronicleHandler {
            private let lock = NSLock()
            
            public var fileURL: URL {
                FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask)[0]
                    .appendingPathComponent(fileName)
            }
            
            public var fileName: String
            
            public init(fileName: String = "chronicle.log") {
                self.fileName = fileName
            }
            
            public func handle(output: String) {
                var fileOutput = ""
                
                lock.lock()
                
                defer {
                    fileOutput.append(output)
                    
                    do {
                        try fileOutput.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        dump(error)
                    }
                    
                    lock.unlock()
                }
                
                guard let contents = try? Data(contentsOf: fileURL) else {
                    return
                }
                
                let fileContents = String(data: contents, encoding: .utf8)
                
                if let fileContents = fileContents {
                    fileOutput.append(fileContents + "\n")
                }
                
            }
            
            public func didHandle(chronicle: Chronicle, level: Chronicle.LogLevel) { }
        }
    }
}
```
