

import Foundation
import UIKit

// MARK: - String extension
/// This extesion adds some useful functions to String.
public extension String {
    // MARK: - Variables
    /// Gets the individual characters and puts them in an array as Strings.
    var array: [String] {
        return description.map { String($0) }
    }
    
    /// Returns the Float value
    var floatValue: Float {
        return NSString(string: self).floatValue
    }
    
    /// Returns the Int value
    var intValue: Int {
        return Int(NSString(string: self).intValue)
    }
    
    /// Convert self to a Data.
    var dataValue: Data? {
        return self.data(using: .utf8)
    }
    
    /// Encoded string to Base64.
    var base64encoded: String {
        guard let data: Data = self.data(using: .utf8) else {
            return ""
        }
        return data.base64EncodedString()
    }
    
    var isNumber : Bool {
        return Double(self) != nil
    }
    
    //Remove HTML Tags
    var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
    
    
    /// Decoded Base64 to string.
    var base64decoded: String {
        guard let data: Data = Data(base64Encoded: String(self), options: .ignoreUnknownCharacters), let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return ""
        }
        return String(describing: dataString)
    }
    
    /// Encode self to an encoded url string.
    var urlEncoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
    }
    
    // MARK: - Functions
    
    /// Returns the lenght of the string.
    var length: Int {
        return self.count
    }
    
    /**
     Used to calculate text height for max width and font
     */
    func heightForWidth(width: CGFloat, font: UIFont) -> CGFloat {
        var size: CGSize = CGSize.zero
        if self.length > 0 {
            let frame: CGRect = self.boundingRect(with: CGSize(width: width, height :999999), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
            size = CGSize(width: frame.size.width, height :frame.size.height + 1)
        }
        return size.height
    }
    
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    
    /// Get the character at a given index.
    ///
    /// - Parameter index: The index.
    /// - Returns: Returns the character at a given index, starts from 0.
    func character(at index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    
    /// Returns a new string containing the characters of the String from the one at a given index to the end.
    ///
    /// - Parameter index: The index.
    /// - Returns: Returns the substring from index.
    func substring(from index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    /// Creates a substring from the given character.
    ///
    /// - Parameter character: The character.
    /// - Returns: Returns the substring from character.
    func substring(from character: Character) -> String {
        let index: Int = self.index(of: character)
        guard index > -1 else {
            return ""
        }
        return substring(from: index + 1)
    }
    
    /// Returns a new string containing the characters of the String up to, but not including, the one at a given index.
    ///
    /// - Parameter index: The index.
    /// - Returns: Returns the substring to index.
    func substring(to index: Int) -> String {
        guard index <= self.length else {
            return ""
        }
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    
    /// Creates a substring to the given character.
    ///
    /// - Parameter character: The character.
    /// - Returns: Returns the substring to character.
    func substring(to character: Character) -> String {
        let index: Int = self.index(of: character)
        guard index > -1 else {
            return ""
        }
        return substring(to: index)
    }
    
    /// Creates a substring with a given range.
    ///
    /// - Parameter range: The range.
    /// - Returns: Returns the string between the range.
    func substring(with range: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        
        return String(self[start..<end])
    }
    
    /// Creates a substring with a given range.
    ///
    /// - Parameter range: The range.
    /// - Returns: Returns the string between the range.
    func substring(with range: CountableClosedRange<Int>) -> String {
        return self.substring(with: Range(uncheckedBounds: (lower: range.lowerBound, upper: range.upperBound + 1)))
    }
    
    /// Returns the index of the given character.
    ///
    /// - Parameter character: The character to search.
    /// - Returns: Returns the index of the given character, -1 if not found.
    func index(of character: Character) -> Int {
        if let index: Index = self.firstIndex(of: character) {
            return self.distance(from: self.startIndex, to: index)
        }
        return -1
    }
    
    /// Check if self has the given substring in case-sensitiv or case-insensitive.
    ///
    /// - Parameters:
    ///   - string: The substring to be searched.
    ///   - caseSensitive: If the search has to be case-sensitive or not.
    /// - Returns: Returns true if founded, otherwise false.
    func range(of string: String, caseSensitive: Bool = true) -> Bool {
        return caseSensitive ? (self.range(of: string) != nil) : (self.lowercased().range(of: string.lowercased()) != nil)
    }
    
    /// Check if self has the given substring in case-sensitiv or case-insensitive.
    ///
    /// - Parameters:
    ///   - string: The substring to be searched.
    ///   - caseSensitive: If the search has to be case-sensitive or not.
    /// - Returns: Returns true if founded, otherwise false.
    func has(_ string: String, caseSensitive: Bool = true) -> Bool {
        return self.range(of: string, caseSensitive: caseSensitive)
    }
    
    /// Returns the number of occurrences of a String into self.
    ///
    /// - Parameter string: String of occurrences.
    /// - Returns: Returns the number of occurrences of a String into self.
    func occurrences(of string: String, caseSensitive: Bool = true) -> Int {
        var string = string
        if !caseSensitive {
            string = string.lowercased()
        }
        return self.lowercased().components(separatedBy: string).count - 1
    }
    
    /// Conver self to a capitalized string.
    /// Example: "This is a Test" will return "This is a test" and "this is a test" will return "This is a test".
    ///
    /// - Returns: Returns the capitalized sentence string.
    func sentenceCapitalizedString() -> String {
        guard self.length > 0 else {
            return ""
        }
        let uppercase: String = self.substring(to: 1).uppercased()
        let lowercase: String = self.substring(from: 1).lowercased()
        
        return uppercase + lowercase
    }
    
    /// Returns the last path component.
    var lastPathComponent: String {
        return NSString(string: self).lastPathComponent
    }
    
    /// Returns the path extension.
    var pathExtension: String {
        return NSString(string: self).pathExtension
    }
    
    /// Delete the last path component.
    var deletingLastPathComponent: String {
        return NSString(string: self).deletingLastPathComponent
    }
    
    /// Delete the path extension.
    var deletingPathExtension: String {
        return NSString(string: self).deletingPathExtension
    }
    
    /// Returns an array of path components.
    var pathComponents: [String] {
        return NSString(string: self).pathComponents
    }
    
    /// Appends a path component to the string.
    ///
    /// - Parameter path: Path component to append.
    /// - Returns: Returns all the string.
    func appendingPathComponent(_ path: String) -> String {
        let string = NSString(string: self)
        
        return string.appendingPathComponent(path)
    }
    
    /// Appends a path extension to the string.
    ///
    /// - Parameter ext: Extension to append.
    /// - Returns: Returns all the string.
    func appendingPathExtension(_ ext: String) -> String? {
        let nsSt = NSString(string: self)
        
        return nsSt.appendingPathExtension(ext)
    }
    
    /// Converts self to an UUID APNS valid (No "<>" or "-" or spaces).
    ///
    /// - Returns: Converts self to an UUID APNS valid (No "<>" or "-" or spaces).
    func readableUUID() -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
    }
    
    /// Returns string with the first character uppercased.
    ///
    /// - returns: Returns string with the first character uppercased.
    func uppercasedFirst() -> String {
        return String(self.prefix(1)).uppercased() + String(self.dropFirst())
    }
    
    /// Returns string with the first character lowercased.
    ///
    /// - returns: Returns string with the first character lowercased.
    func lowercasedFirst() -> String {
        return String(self.prefix(1)).lowercased() + String(self.dropFirst())
    }
    
    /// Returns the reversed String.
    ///
    /// - parameter preserveFormat: If set to true preserve the String format.
    ///                             The default value is false.
    ///                             **Example:**
    ///                                 "Let's try this function?" ->
    ///                                 "?noitcnuf siht yrt S'tel"
    ///
    /// - returns: Returns the reversed String.
    func reversed(preserveFormat: Bool) -> String {
        guard !self.isEmpty else {
            return ""
        }
        
        var reversed = String(self.removeExtraSpaces().reversed())
        
        if !preserveFormat {
            return reversed
        }
        
        let words = reversed.components(separatedBy: " ").filter { $0 != "" }
        
        reversed.removeAll()
        for word in words {
            if let char = word.unicodeScalars.last {
                if CharacterSet.uppercaseLetters.contains(char) {
                    reversed += word.lowercased().uppercasedFirst()
                } else {
                    reversed += word.lowercased()
                }
            } else {
                reversed += word.lowercased()
            }
            
            if word != words[words.count - 1] {
                reversed += " "
            }
        }
        
        return reversed
    }
    
    /// Returns true if the String has at least one uppercase chatacter, otherwise false.
    ///
    /// - returns: Returns true if the String has at least one uppercase chatacter, otherwise false.
    func hasUppercasedCharacters() -> Bool {
        var found = false
        for character in self.unicodeScalars {
            if CharacterSet.uppercaseLetters.contains(character) {
                found = true
                break
            }
        }
        return found
    }
    
    /// Returns true if the String has at least one lowercase chatacter, otherwise false.
    ///
    /// - returns: Returns true if the String has at least one lowercase chatacter, otherwise false.
    func hasLowercasedCharacters() -> Bool {
        var found = false
        for character in self.unicodeScalars {
            if CharacterSet.lowercaseLetters.contains(character) {
                found = true
                break
            }
        }
        return found
    }
    
    /// EZSE: Converts String to Double
    func toDouble() -> Double
    {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return 0.0
        }
    }

    
    /// Remove double or more duplicated spaces.
    ///
    /// - returns: Remove double or more duplicated spaces.
    func removeExtraSpaces() -> String {
        let squashed = self.replacingOccurrences(of: "[ ]+", with: " ", options: .regularExpression, range: nil)
        return squashed.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    func removeAllSpaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    /// Returns a new string in which all occurrences of a target strings in a specified range of the String are replaced by another given string.
    ///
    /// - Parameters:
    ///   - target: Target strings array.
    ///   - replacement: Replacement string.
    /// - Returns: Returns a new string in which all occurrences of a target strings in a specified range of the String are replaced by another given string.
    func replacingOccurrences(of target: [String], with replacement: String) -> String {
        var string = self
        for occurrence in target {
            string = string.replacingOccurrences(of: occurrence, with: replacement)
        }
        
        return string
    }
    
    /// Count the number of lowercase characters.
    ///
    /// - Returns: Number of lowercase characters.
    func countLowercasedCharacters() -> Int {
        var countChar = 0
        for index in 0 ..< self.length {
            guard let character = UnicodeScalar((NSString(string: self)).character(at: index)) else {
                return 0
            }
            let isLowercase = CharacterSet.lowercaseLetters.contains(character)
            if isLowercase {
                countChar += 1
            }
        }
        
        return countChar
    }
    
    /// Count the number of uppercase characters.
    ///
    /// - Returns: Number of uppercase characters.
    func countUppercasedCharacters() -> Int {
        var countChar = 0
        for index in 0 ..< self.length {
            guard let character = UnicodeScalar((NSString(string: self)).character(at: index)) else {
                return 0
            }
            let isUppercase = CharacterSet.uppercaseLetters.contains(character)
            if isUppercase {
                countChar += 1
            }
        }
        
        return countChar
    }
    
    /// Count the number of numbers.
    ///
    /// - Returns: Number of numbers.
    func countNumbers() -> Int {
        var countNumber = 0
        for index in 0 ..< self.length {
            guard let character = UnicodeScalar((NSString(string: self)).character(at: index)) else {
                return 0
            }
            let isNumber = CharacterSet(charactersIn: "0123456789").contains(character)
            if isNumber {
                countNumber += 1
            }
        }
        
        return countNumber
    }
    
    /// Count the number of symbols.
    ///
    /// - Returns: Number of symbols.
    func countSymbols() -> Int {
        var countSymbol = 0
        for index in 0 ..< self.length {
            guard let character = UnicodeScalar((NSString(string: self)).character(at: index)) else {
                return 0
            }
            let isSymbol = CharacterSet(charactersIn: "`~!?@#$€£¥§%^&*()_+-={}[]:\";.,<>'•\\|/").contains(character)
            if isSymbol {
                countSymbol += 1
            }
        }
        
        return countSymbol
    }
    
    /// Convert HEX string (separated by space) to "usual" characters string.
    /// Example: "68 65 6c 6c 6f" -> "hello".
    ///
    /// - Returns: Readable string.
    func stringFromHEX() -> String {
        var hex = self
        hex = hex.replacingOccurrences(of: " ", with: "")
        var string: String = ""
        while !hex.isEmpty {
            let character: String = String(hex[..<hex.index(hex.startIndex, offsetBy: 2)])
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 2)...])
            var characterInt: UInt32 = 0
            _ = Scanner(string: character).scanHexInt32(&characterInt)
            string += String(format: "%c", characterInt)
        }
        return string
    }
    
    /// Convert string to HEX string.
    /// Example: "hello" -> "68656c6c6f"
    ///
    /// - parameter spacing: Will add a space between every HEX number.
    /// - Returns: HEX string.
    /* func hex(spacing: Bool = false) -> String {
     var hexString = ""
     let space = spacing ? " " : ""
     
     for i in 0 ..< self.length {
     hexString = hexString.appendingFormat("%02x%@", self[i..<i + 1], space)
     }
     
     return hexString
     }*/
    
    /// Return if self is anagram of another String.
    ///
    /// - Parameter string: Other String.
    /// - Returns: Return true if self is anagram of another String, otherwise false.
    func isAnagram(of string: String) -> Bool {
        let lowerSelf = self.lowercased().replacingOccurrences(of: " ", with: "")
        let lowerOther = string.lowercased().replacingOccurrences(of: " ", with: "")
        return lowerSelf.sorted() == lowerOther.sorted()
    }
    
    /// Returns if self is palindrome.
    ///
    /// - Returns: Returns true if self is palindrome, otherwise false.
    func isPalindrome() -> Bool {
        let selfString = self.lowercased().replacingOccurrences(of: " ", with: "")
        let otherString = String(selfString.reversed())
        return selfString == otherString
    }
    
    /// Returns the character at the given index.
    ///
    /// - Parameter index: Returns the character at the given index.
    //     subscript(index: Int) -> Character {
    //        return self[self.index(self.startIndex, offsetBy: index)]
    //    }
    
    /// Returns the index of the given character, -1 if not found.
    ///
    /// - Parameter character: Returns the index of the given character, -1 if not found.
    subscript(character: Character) -> Int {
        return self.index(of: character)
    }
    
    /// Returns the character at the given index as String.
    ///
    /// - Parameter index: Returns the character at the given index as String.
    //     subscript(index: Int) -> String {
    //        return String(self[index])
    //    }
    
    /// Returns the string from a given range.
    /// Example: print("BFKit"[1...3]) the result is "FKi".
    ///
    /// - Parameter range: Returns the string from a given range.
    //     subscript(range: Range<Int>) -> String {
    //        return substring(with: range)
    //    }
    
    /// Returns if self is a valid UUID or not.
    ///
    /// - Returns: Returns if self is a valid UUID or not.
    func isUUID() -> Bool {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", options: .caseInsensitive)
            let matches: Int = regex.numberOfMatches(in: self, options: .reportCompletion, range: NSRange(location: 0, length: self.length))
            return matches == 1
        } catch {
            return false
        }
    }
    
    /// Returns if self is a valid UUID for APNS (Apple Push Notification System) or not.
    ///
    /// - Returns: Returns if self is a valid UUID for APNS (Apple Push Notification System) or not.
    func isUUIDForAPNS() -> Bool {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "^[0-9a-f]{32}$", options: .caseInsensitive)
            let matches: Int = regex.numberOfMatches(in: self, options: .reportCompletion, range: NSRange(location: 0, length: self.length))
            return matches == 1
        } catch {
            return false
        }
    }
    
    /// Returns a new string containing matching regular expressions replaced with the template string.
    ///
    /// - Parameters:
    ///   - regexString: The regex string.
    ///   - replacement: The replacement string.
    /// - Returns: Returns a new string containing matching regular expressions replaced with the template string.
    /// - Throws: Throws NSRegularExpression(pattern:, options:) errors.
    func replacingMatches(regex regexString: String, with replacement: String) throws -> String {
        let regex: NSRegularExpression = try NSRegularExpression(pattern: regexString, options: .caseInsensitive)
        return regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.length), withTemplate: "")
    }
    
    // MARK: - Functions not available on Linux
    
    #if !os(Linux)
    /// Localize current String using self as key.
    ///
    /// - Returns: Returns localized String using self as key.
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Check if self is an username.
    ///
    /// - Returns: Returns true if it is name, otherwise false.
    func isNameValid() -> Bool {
        let RegEx = "\\w{2,20}"
        let regExPredicate = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return regExPredicate.evaluate(with:self.lowercased())
    }

    func isPhoneNumber() -> Bool {
        let PHONE_REGEX = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }

    
    /// Check if self is an email.
    ///
    /// - Returns: Returns true if it is an email, otherwise false.
    func isEmail() -> Bool {
        let emailRegEx: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let regExPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return regExPredicate.evaluate(with: self.lowercased())
    }
    
    /// Returns an array of String with all the links in self.
    ///
    /// - Returns: Returns an array of String with all the links in self.
    /// - Throws: Throws NSDataDetector errors.
    func links() throws -> [String] {
        let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        let links = detector.matches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length)).map { $0 }
        
        return links.filter { link in
            return link.url != nil
            }.map { link -> String in
                return link.url!.absoluteString
        }
    }
    
    /// Returns an array of Date with all the dates in self.
    ///
    /// - Returns: Returns an array of Date with all the date in self.
    /// - Throws: Throws NSDataDetector errors.
    func dates() throws -> [Date] {
        let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
        
        let dates = detector.matches(in: self, options: NSRegularExpression.MatchingOptions.withTransparentBounds, range: NSRange(location: 0, length: length)).map { $0 }
        
        return dates.filter { date in
            return date.date != nil
            }.map { date -> Date in
                return date.date!
        }
    }
    
    /// Returns an array of String with all the hashtags in self.
    ///
    /// - Returns: Returns an array of String with all the hashtags in self.
    /// - Throws: Throws NSRegularExpression errors.
    func hashtags() throws -> [String] {
        let detector = try NSRegularExpression(pattern: "#(\\w+)", options: NSRegularExpression.Options.caseInsensitive)
        let hashtags = detector.matches(in: self, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSRange(location: 0, length: length)).map { $0 }
        
        return hashtags.map({
            (self as NSString).substring(with: $0.range(at: 1))
        })
    }
    
    /// Returns an array of String with all the mentions in self.
    ///
    /// - Returns: Returns an array of String with all the mentions in self.
    /// - Throws: Throws NSRegularExpression errors.
    func mentions() throws -> [String] {
        let detector = try NSRegularExpression(pattern: "@(\\w+)", options: NSRegularExpression.Options.caseInsensitive)
        let mentions = detector.matches(in: self, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSRange(location: 0, length: length)).map { $0 }
        
        return mentions.map({
            (self as NSString).substring(with: $0.range(at: 1))
        })
    }
    #endif
}

/// Infix operator `???` with NilCoalescingPrecedence.
infix operator ???: NilCoalescingPrecedence

/// Returns defaultValue if optional is nil, otherwise returns optional.
///
/// - Parameters:
///   - optional: The optional variable.
///   - defaultValue: The default value.
/// - Returns: Returns defaultValue if optional is nil, otherwise returns optional.
func ??? <T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    return optional.map { String(describing: $0) } ?? defaultValue()
}
