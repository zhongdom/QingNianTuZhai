import UIKit

extension String {

    /// 转换成 Int， 如果转换失败，返回默认值
    func toInt(defaultValue: Int) -> Int {
        return Int(self) ?? defaultValue
    }

    /// 转换成 Int
    var int: Int? {
        return Int(self)
    }

    /// 转换成 Float
    var float: Float? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: self)?.floatValue
    }

    /// 转换成 Double
    var double: Double? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: self)?.doubleValue
    }

    /// 从字符串中获得的Bool值
    ///
    ///		"1".bool -> true
    ///		"False".bool -> false
    ///		"Hello".bool = nil
    ///
    public var bool: Bool? {
        let selfLowercased = trimmed.lowercased()
        if selfLowercased == "true" || selfLowercased == "1" {
            return true
        } else if selfLowercased == "false" || selfLowercased == "0" {
            return false
        }
        return nil
    }

    /// 转为 NSString
    var NSString: NSString {
        return self as NSString
    }

    func hash() -> Int {
        let sum =  self
            .map { String($0).unicodeScalars.first?.value }
            .flatMap { $0 }
            .reduce(0, +)
        return Int(sum)
    }

    /// 返回一个删除掉所有出现target字符串的地方的字符串
    func deleteOccurrences(target: String) -> String {
        return self.replacingOccurrences(of: target, with: "")
    }

    /// 截取字符串
    ///
    /// - Parameter r: [0..>n]
    subscript (r: Range<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        return String(self[startIndex..<endIndex])
    }

    // String[1]
    public subscript(index: Int) -> Character? {
        guard let stringIndex = self.index(startIndex, offsetBy: index, limitedBy: endIndex) else { return nil }
        return self[stringIndex]
    }

    /// 剪切空格和换行字符
    public mutating func trim() {
        self = trimmed
    }

    /// 剪切空格和换行字符，返回一个新字符串。
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// 删除两个或多个重复的空格
    public var removeExtraSpaces: String {
        let squashed = replacingOccurrences(of: "[ ]+", with: " ", options: .regularExpression, range: nil)
        return squashed.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

}

extension String {

    public func appendingPathComponent(_ path: String) -> String {
        return self.NSString.appendingPathComponent(path)
    }

    public func appendingPathExtension(_ text: String) -> String? {
        return self.NSString.appendingPathExtension(text)
    }

    public var deletingPathExtension: String {
        return self.NSString.deletingPathExtension
    }

    public var lastPathComponent: String {
        return self.NSString.lastPathComponent
    }

    public var deletingLastPathComponent: String {
        return self.deletingLastPathComponent
    }

    public var pathExtension: String {
        return self.NSString.pathExtension
    }
}

extension String {

    /// 字符串大小
    public func toSize(size: CGSize, fontSize: CGFloat, maximumNumberOfLines: Int = 0) -> CGSize {
        let font = UIFont.systemFont(ofSize: fontSize)
        var size = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes:[NSAttributedStringKey.font: font], context: nil).size
        if maximumNumberOfLines > 0 {
            size.height = min(size.height, CGFloat(maximumNumberOfLines) * font.lineHeight)
        }
        return size
    }

    /// 字符串宽度
    public func toWidth(fontSize: CGFloat, maximumNumberOfLines: Int = 0) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        return toSize(size: size, fontSize: fontSize, maximumNumberOfLines: maximumNumberOfLines).width
    }

    /// 字符串高度
    public func toHeight(width: CGFloat, fontSize: CGFloat, maximumNumberOfLines: Int = 0) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return toSize(size: size, fontSize: fontSize, maximumNumberOfLines: maximumNumberOfLines).height
    }

    /// 计算字符串的高度，并限制宽度
    public func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedStringKey.font: font],
            context: nil)
        return boundingBox.height
    }

    /// 下划线
    public func underline() -> NSAttributedString {
        let underlineString = NSAttributedString(string: self, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        return underlineString
    }

    // 斜体
    public func italic() -> NSAttributedString {
        let italicString = NSMutableAttributedString(
            string: self,
            attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)]
        )
        return italicString
    }

    /// 设置指定文字颜色
    public func makeSubstringColor(_ text: String, color: UIColor) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: self)

        let range = (self as NSString).range(of: text)
        if range.location != NSNotFound {
            attributedText.setAttributes([NSAttributedStringKey.foregroundColor: color], range: range)
        }

        return attributedText
    }
}

extension String {
    /// 是否是邮箱
    func isEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        //        let emailRegex = "^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})$"
        let testPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return testPredicate.evaluate(with: self)
    }

    /// 判断是否为字母
    func isLetter() -> Bool {
        if count == 0 { return false }
        let index = self.index(self.startIndex, offsetBy: 1)
        let regextest = NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z]+$")
        return regextest.evaluate(with: self[..<index])
    }

}
