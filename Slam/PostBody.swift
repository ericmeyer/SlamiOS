import Foundation

public class PostBody {

    let params: [String:String]

    public init(params: [String:String]) {
        self.params = params
    }

    public func asString() -> String {
        var pairs: [String] = []
        for (key, value) in params {
            pairs.append("\(encode(key))=\(encode(value))")
        }
        return pairs.joinWithSeparator("&")
    }

    private func encode(value: String) -> String {
        let charSet = NSCharacterSet.URLHostAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        charSet.removeCharactersInString("&")
        return value.stringByAddingPercentEncodingWithAllowedCharacters(charSet)!
    }
}