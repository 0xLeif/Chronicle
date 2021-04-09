import Foundation

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

public protocol ChronicleHandler {
    func handle(output: String) -> Void
    func didHandle(chronicle: Chronicle, level: Chronicle.LogLevel)
}

public struct Chronicle {
    public enum LogLevel {
        public static var successEmoji: String = "✅"
        public static var infoEmoji: String = "ℹ️"
        public static var warningEmoji: String = "⚠️"
        public static var errorEmoji: String = "❗️"
        public static var fatalEmoji: String = "🚨"
        
        case success(String)
        case info(String)
        case warning(String)
        case error(String, Error?)
        case fatal(String, Error?)
        
        public var emoji: String {
            switch self {
            case .success:
                return LogLevel.successEmoji
            case .info:
                return LogLevel.infoEmoji
            case .warning:
                return LogLevel.warningEmoji
            case .error:
                return LogLevel.errorEmoji
            case .fatal:
                return LogLevel.fatalEmoji
            }
        }
        
        public var output: String {
            switch self {
            case .success(let value), .info(let value), .warning(let value):
                return value
            case .error(let value, let error), .fatal(let value, let error):
                return value + (error.map { "\n{\n\t\($0): \($0.localizedDescription)\n}" } ?? "")
            }
        }
    }
    
    private let formatter: ChronicleFormatter
    private let handler: ChronicleHandler
    
    public let label: String
    
    public init(
        label: String,
        formatter: ChronicleFormatter = Chronicle.DefaultFormatters.DefaultFormatter(),
        handler: ChronicleHandler = Chronicle.DefaultHandlers.PrintHandler()
    ) {
        self.label = label
        self.formatter = formatter
        self.handler = handler
    }
    
    @discardableResult
    public func log(level: LogLevel) -> String {
        defer {
            handler.handle(output: output)
            handler.didHandle(chronicle: self, level: level)
        }
        
        let output = formatter.output(
            formattedDate: formatter.dateFormatter.string(from: Date()),
            formattedLabel: formatter.format(label: label),
            formattedLogMessage: formatter.format(logLevel: level)
        )
        
        return output
    }
}
