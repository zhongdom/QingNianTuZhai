import Foundation
import UIKit

extension URLComponents {
    subscript(key: String) -> String? {
        return queryItems?.filter { $0.name == key }.first?.value
    }
    
    /// 不包含 '/'
    var pathString: String {
        return path.deleteOccurrences(target: "/")
    }
}

extension NSObject {
    static var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
    }

    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
    }
}
