import Foundation

public struct Chronicle {
    public static let defaultDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        
        return formatter
    }()
    
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
    
    public let label: String
    public let dateFormatter: DateFormatter
    public let labelFormatter: (String) -> String
    public let outputFormatter: (LogLevel) -> String
    public let outputHandler: ((String) -> Void)
    public let actionHandler: ((Chronicle, LogLevel) -> Void)?
    
    public init(
        label: String,
        dateFormatter: DateFormatter = Chronicle.defaultDateFormatter,
        labelFormatter: @escaping (String) -> String = { "[\($0)]" },
        outputFormatter: @escaping (LogLevel) -> String = { $0.output },
        outputHandler: @escaping (String) -> Void = { print($0) },
        actionHandler: ((Chronicle, LogLevel) -> Void)? = nil
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
        
        let output = dateFormatter.string(from: Date()) + " " + labelFormatter(label) + " " + level.emoji + ": " + outputFormatter(level)
        
        outputHandler(output)
        
        return output
    }
}
