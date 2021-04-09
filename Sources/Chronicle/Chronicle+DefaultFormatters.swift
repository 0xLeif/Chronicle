//
//  Chronicle+DefaultFormatters.swift
//  
//
//  Created by Leif on 4/9/21.
//

import Foundation

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
