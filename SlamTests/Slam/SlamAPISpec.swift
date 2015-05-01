import Quick
import Nimble
import Slam

class SlamAPISpec: QuickSpec {

    func toJSON(value: AnyObject) -> String {
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: nil, error: nil) {
                if let json = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return json as String
                }
            }
        }
        return ""
    }

    override func setUp() {
        continueAfterFailure = false
    }

    override func spec() {

        var httpClient = MockHTTPClient()
        var slamApi = SlamAPI(
            httpClient: httpClient
        )

        beforeEach({
            httpClient = MockHTTPClient()
            slamApi = SlamAPI(
                httpClient: httpClient
            )
        })

        describe("SlamAPI") {

            describe("Fetching the current queue") {
                it("makes an HTTP request") {
                    httpClient.setResponse(self.toJSON([]))

                    slamApi.getQueue({(matches: [Match]) in })

                    expect(httpClient.wasRequestMade).to(beTrue())
                    let expectedURL = NSURL(string: slamApi.getCurrentQueueURL)
                    expect(httpClient.lastRequest!.URL).to(equal(expectedURL))
                }

                it("passes the parsed match to the callback") {
                    var returnedMatches: [Match] = []
                    let setReturnedMatches = {(matches: [Match]) in
                        returnedMatches = matches
                    }

                    httpClient.setResponse(self.toJSON([[
                        "playerOne": "Taka",
                        "playerTwo": "Eric"
                    ]]))

                    slamApi.getQueue(setReturnedMatches)

                    expect(returnedMatches.count).to(equal(1))
                    expect(returnedMatches[0].playerOne).to(equal("Taka"))
                    expect(returnedMatches[0].playerTwo).to(equal("Eric"))
                }

                it("passes multiple matches to the callback") {
                    var returnedMatches: [Match] = []
                    let setReturnedMatches = {(matches: [Match]) in
                        returnedMatches = matches
                    }

                    httpClient.setResponse(self.toJSON([[
                        "playerOne": "A",
                        "playerTwo": "B"
                    ], [
                        "playerOne": "C",
                        "playerTwo": "D"
                    ]]))

                    slamApi.getQueue(setReturnedMatches)

                    expect(returnedMatches.count).to(equal(2))
                }
            }

        }
    }
}
