//
//  Chronicle+DefaultHandlers.swift
//  
//
//  Created by Leif on 4/9/21.
//

import Foundation

extension Chronicle {
    public struct DefaultHandlers {
        public struct PrintHandler: ChronicleHandler {
            public init() { }
            
            public func handle(output: String) { print(output) }
            
            public func didHandle(chronicle: Chronicle, level: Chronicle.LogLevel) { }
        }
        
        public struct FileHandler: ChronicleHandler {
            private static var fileURL: URL {
                FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask)[0]
                    .appendingPathComponent(fileName)
            }
            
            public static var fileName: String = "chronicle.log"
            
            public init() { }
            
            public func handle(output: String) {
                var fileOutput = ""
                
                defer {
                    fileOutput.append(output)
                    
                    do {
                        try output.write(to: FileHandler.fileURL, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        dump(error)
                    }
                }
                
                guard let contents = try? Data(contentsOf: FileHandler.fileURL) else {
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
