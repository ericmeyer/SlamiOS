import Foundation

open class PostBody {

    let params: [String:String]

    public init(params: [String:String]) {
        self.params = params
    }

    open func asString() -> String {
        var pairs: [String] = []
        for (key, value) in params {
            pairs.append("\(encode(key))=\(encode(value))")
        }
        return pairs.joined(separator: "&")
    }

    fileprivate func encode(_ value: String) -> String {
        let charSet = (CharacterSet.urlHostAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
        charSet.removeCharacters(in: "&")
        return value.addingPercentEncoding(withAllowedCharacters: charSet as CharacterSet)!
    }
}
