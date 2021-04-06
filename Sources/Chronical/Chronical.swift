import Foundation

public struct Chronical {
    public typealias ChronicalHandler = (Chronical, Chronical.LogLevel) -> Void
    
    public static let defaultDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        
        return formatter
    }()
    
    public var formattedDate: String {
        dateFormatter.string(from: Date())
    }
    
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
                return value + (error.map { "\n{\n\t\($0): \($0.localizedDescription)\n}\n" } ?? "")
            }
        }
    }
    
    public let label: String
    public let dateFormatter: DateFormatter
    public let labelFormatter: (String) -> String
    public let outputFormatter: (LogLevel) -> String
    public let outputHandler: ((String) -> Void)
    public let actionHandler: ChronicalHandler?
    
    public init(
        label: String,
        dateFormatter: DateFormatter = Chronical.defaultDateFormatter,
        labelFormatter: @escaping (String) -> String = { "[\($0)]" },
        outputFormatter: @escaping (LogLevel) -> String = { $0.output },
        outputHandler: @escaping (String) -> Void = { print($0) },
        actionHandler: ChronicalHandler? = nil
    ) {
        self.label = label
        self.dateFormatter = dateFormatter
        self.labelFormatter = labelFormatter
        self.outputFormatter = outputFormatter
        self.outputHandler = outputHandler
        self.actionHandler = actionHandler
    }
    
    @discardableResult
    public func log(level: LogLevel) -> String {
        defer {
            actionHandler?(self, level)
        }
        
        let output = formattedDate + " " + labelFormatter(label) + " " + level.emoji + ": " + outputFormatter(level)
        
        outputHandler(output)
        
        return output
    }
}
