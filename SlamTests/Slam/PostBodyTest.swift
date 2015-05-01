import Quick
import Nimble
import Slam

class PostBodyTest: QuickSpec {

    func asPostString(params: [String:String]) -> String {
        let postBody = PostBody(params: params)
        return postBody.asString()
    }
    override func spec() {
        describe("Converting a dictionary to a POST string") {

            it("is empty for an empty dictionary"){
                expect(self.asPostString([:])).to(equal(""))
            }

            it("builds a string for a single parameter"){
                let params = [
                    "foo": "bar"
                ]

                expect(self.asPostString(params)).to(equal("foo=bar"))
            }

            it("builds a string for two parameters"){
                let params = [
                    "foo": "bar",
                    "baz": "buzz"
                ]

                var body = self.asPostString(params)
                expect(body).to(match("foo=bar"))
                expect(body).to(match("&"))
                expect(body).to(match("baz=buzz"))
            }

            it("encodes a param key") {
                let params = [
                    "f &o": "bar"
                ]

                expect(self.asPostString(params)).to(equal("f%20%26o=bar"))
            }

            it("encodes a param value") {
                let params = [
                    "foo": "A&+ Z"
                ]

                expect(self.asPostString(params)).to(equal("foo=A%26+%20Z"))
            }
        }
    }
}
