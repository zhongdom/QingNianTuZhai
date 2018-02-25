import Foundation
import UIKit

typealias log = Logger

public struct Logger {
    // MARK: - Variables

    /// Enabled or not
    public static var isEnabled: Bool = true
    /// THE log level
    public static var logLevel: LogType = .debug
    /// The log AttributedString.
    public static var logAttrString = NSMutableAttributedString()
    /// The detailed log string.
    public static var detailedLog: String = ""
    /// Did Add Log
    public static var didAddLog: (() -> Void)?

    public enum LogType: Int {
        case debug   = 100
        case verbose = 200
        case info    = 300
        case warning = 400
        case error   = 500

        var string: String {
            switch self {
            case .error: return "❌[ERROR]"
            case .warning: return "⚠️[WARNING]"
            case .info: return "💙[INFO]"
            case .debug: return "✅[DEBUG]"
            case .verbose: return "💜[VERBOSE]"
            }
        }

        var color: UIColor {
            switch self {
            case .error: return #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            case .warning: return #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            case .info: return #colorLiteral(red: 0.2291581631, green: 0.6805399656, blue: 0.9839330316, alpha: 1)
            case .debug: return #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            case .verbose: return #colorLiteral(red: 0.7212753892, green: 0.2745705843, blue: 0.9661005139, alpha: 1)
            }
        }
    }

    // MARK: - Functions

    private static func log(_ items: [Any], file: StaticString = #file, function: StaticString = #function, line: UInt = #line, type: LogType) {
        guard self.isEnabled else { return }
        guard logLevel.rawValue <= type.rawValue else { return }

        var _message = type.string + " " + message(from: items)
        if _message.hasSuffix("\n") == false {
            _message += "\n"
        }

        let filenameWithoutExtension = String(describing: file).lastPathComponent.deletingPathExtension
        let timestamp = Date().description(dateSeparator: "-", usFormat: true, nanosecond: true)
        let logMessage = "\(timestamp) \(filenameWithoutExtension):\(line) \(function): \(_message)"
        print(logMessage, terminator: "")

        let dateString = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        let logString = dateString + " \(filenameWithoutExtension):\(line) " + _message
        logAttrString.append(handleLog(logString, type: type))
        DispatchQueue.main.async {
            didAddLog?()
        }

        self.detailedLog += logMessage
    }

    public static func warning(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.log(items, file: file, function: function, line: line, type: .warning)
    }

    public static func error(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.log(items, file: file, function: function, line: line, type: .error)
    }

    public static func debug(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.log(items, file: file, function: function, line: line, type: .debug)
    }

    public static func info(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.log(items, file: file, function: function, line: line, type: .info)
    }

    public static func verbose(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.log(items, file: file, function: function, line: line, type: .verbose)
    }

    private static func message(from items: [Any]) -> String {
        return items
            .map { String(describing: $0) }
            .joined(separator: " ")
    }

    private static func handleLog(_ message: String, type: LogType) -> NSAttributedString {
        let aStr = NSMutableAttributedString(string: message)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5

        aStr.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle,
                            NSAttributedStringKey.foregroundColor: type.color],
                           range: NSRange(location: 0, length: message.count))
        return aStr
    }

    /// Clear the log string.
    public static func clear() {
        logAttrString = NSMutableAttributedString()
        detailedLog = ""
    }

    /// Save the Log in a file.
    ///
    /// - Parameters:
    ///   - path: Save path.
    ///   - filename: Log filename.
    public static func saveLog(in path: String = FileManager.log,
                               filename: String = Date().YYYYMMDDDateString.appendingPathExtension("log")!) {
        if detailedLog.isEmpty { return }
        let fullPath = path.appendingPathComponent(filename)
        var logs = detailedLog
        if FileManager.default.fileExists(atPath: fullPath) {
            logs = (try? String(contentsOfFile: fullPath, encoding: .utf8)) ?? ""
            logs += detailedLog
            FileManager.save(content: logs, savePath: path.appendingPathComponent(filename))
            return
        }
        FileManager.create(at: fullPath)
        FileManager.save(content: logs, savePath: fullPath)
    }
}

extension Date {

    public var YYYYMMDDDateString: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }

    public func description(dateSeparator: String = "/", usFormat: Bool = false, nanosecond: Bool = false) -> String {
        var description: String

        let components = Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
        let year = components.year ?? 0
        let month = components.month ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0
        let nanoseconds = components.second ?? 1

        if usFormat {
            description = String(
                format: "%04li%@%02li%@%02li %02li:%02li:%02li",
                year,
                dateSeparator,
                month,
                dateSeparator,
                day,
                hour,
                minute,
                second
            )
        } else {
            description = String(
                format: "%02li%@%02li%@%04li %02li:%02li:%02li",
                month,
                dateSeparator,
                day,
                dateSeparator,
                year,
                hour,
                minute,
                second)
        }

        if nanosecond {
            description += String(format: ":%03li", nanoseconds / 1000000)
        }
        return description
    }
}

extension FileManager {

    public class var log: String {
        return document.appendingPathComponent("Logs")
    }

    @discardableResult public class func save(content: String, savePath: String) -> Error? {
        if FileManager.default.fileExists(atPath: savePath) {
            do {
                try FileManager.default.removeItem(atPath: savePath)
            } catch {
                return error
            }
        }
        do {
            try content.write(to: URL(fileURLWithPath: savePath), atomically: true, encoding: .utf8)
        } catch {
            return error
        }
        return nil
    }
}
