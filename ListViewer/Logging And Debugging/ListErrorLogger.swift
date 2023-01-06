//
//  ListErrorLogger.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/5/23.
//

import Foundation

// Simple Logging mechanism to log errors and print them to console. Could hook this up to send this to a remote error
// log like crashlytics
class ListErrorLogger {
    
    static let shared = ListErrorLogger()
    
    func log(_ error: String, fatal: Bool = false) {
        print(error)
        if fatal {
            fatalError(error)
        }
    }
}

// automatically print out slightly detailed more logs of already decent decoding errors. By binding this to a custom
// logging setting, we can choose to log or group these errors in a way that's easier to track. 
extension JSONDecoder {
    func tryDecode<T>(_ type: T.Type, from data: Data)  throws -> T where T: Decodable {
        do {
            return try self.decode(type, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            ListErrorLogger.shared.log("Data Corrupted Decoding Error: \(context)")
        } catch let DecodingError.keyNotFound(key, context) {
            ListErrorLogger.shared.log("Key (\(key)) Not Found Decoding Error: \(context)")
        } catch let DecodingError.valueNotFound(value, context) {
            ListErrorLogger.shared.log("Value (\(value)) Not Found Decoding Error: \(context)")
        } catch let DecodingError.typeMismatch(expectedType, context) {
            ListErrorLogger.shared.log("Type (\(expectedType)) Mismatch Decoding Error: \(context)")
        } catch {
            ListErrorLogger.shared.log("Unknown Decoding Error")
        }
        return try self.decode(type, from: data)
    }
}
