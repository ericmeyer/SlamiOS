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

            describe("Attemping login") {
                it("makes an HTTP request") {
                    let expectedUrl = NSURL(string: slamApi.loginURL)
                    httpClient.setResponse(self.toJSON([:]))

                    slamApi.attemptLogin(
                        email: "",
                        password: "",
                        onSuccess: {session in}
                    )

                    expect(httpClient.wasRequestMade).to(beTrue())
                    expect(httpClient.lastRequest!.URL).to(equal(expectedUrl))
                    expect(httpClient.lastRequest!.HTTPMethod).to(equal("POST"))
                }

                it("includes the email and password") {
                    httpClient.setResponse(self.toJSON([:]))

                    slamApi.attemptLogin(
                        email: "someemail",
                        password: "password",
                        onSuccess: {session in}
                    )

                    expect(httpClient.lastRequestBody).notTo(beNil())
                    expect(httpClient.lastRequestBody).to(match("email=someemail"))
                    expect(httpClient.lastRequestBody).to(match("password=password"))
                }

                it("calls the callback on success") {
                    var callbackCalled = false
                    let onSuccess: (session: Session) -> Void = { session in
                        callbackCalled = true
                    }
                    httpClient.setResponse(self.toJSON([:]))

                    slamApi.attemptLogin(
                        email: "",
                        password: "",
                        onSuccess: onSuccess
                    )
                    expect(callbackCalled).to(beTrue())
                }

                it("parses an authenticated response") {
                    httpClient.setResponse(self.toJSON([
                        "success": true,
                        "token": "123ABC"
                    ]))

                    var actualSession: Session!
                    slamApi.attemptLogin(
                        email: "",
                        password: "",
                        onSuccess: {session in
                            actualSession = session
                        }
                    )

                    expect(actualSession.isAuthenticated).to(beTrue())
                    expect(actualSession.token).to(equal("123ABC"))
                }

                it("parses an unauthenticated response") {
                    httpClient.setResponse(self.toJSON([
                        "success": false
                    ]))

                    var actualSession: Session!
                    slamApi.attemptLogin(
                        email: "",
                        password: "",
                        onSuccess: {session in
                            actualSession = session
                        }
                    )

                    expect(actualSession.isAuthenticated).to(beFalse())
                    expect(actualSession.token).to(beNil())
                }

                it("is not authenticated for an empty response") {
                    httpClient.setResponse(self.toJSON([:]))

                    var actualSession: Session!
                    slamApi.attemptLogin(
                        email: "",
                        password: "",
                        onSuccess: {session in
                            actualSession = session
                        }
                    )

                    expect(actualSession.isAuthenticated).to(beFalse())
                    expect(actualSession.token).to(beNil())
                }
            }

            describe("Adding a new match to the queue") {
                it("makes an HTTP request") {
                    httpClient.setResponse(self.toJSON([]))

                    slamApi.addMatch("Taka", playerTwo: "Emmanuel", onSuccess: {})

                    expect(httpClient.wasRequestMade).to(beTrue())
                    let expectedURL = NSURL(string: slamApi.addMatchURL)
                    expect(httpClient.lastRequest!.URL).to(equal(expectedURL))
                    expect(httpClient.lastRequest!.HTTPMethod).to(equal("POST"))
                }

                it("includes the player params in the body") {
                    httpClient.setResponse(self.toJSON([]))

                    slamApi.addMatch("Taka", playerTwo: "Emmanuel", onSuccess: {})

                    expect(httpClient.lastRequestBody).notTo(beNil())
                    expect(httpClient.lastRequestBody).to(match("playerOne=Taka"))
                    expect(httpClient.lastRequestBody).to(match("playerTwo=Emmanuel"))
                }

                it("Calls the callback on success") {
                    var callbackCalled = false
                    let onSuccess = { () -> Void in
                        callbackCalled = true
                    }
                    httpClient.setResponse(self.toJSON([]))

                    slamApi.addMatch("Taka", playerTwo: "Emmanuel", onSuccess: onSuccess)

                    expect(callbackCalled).to(beTrue())
                }
            }

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
                        "id": "id",
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
                        "id": "1",
                        "playerOne": "A",
                        "playerTwo": "B"
                    ], [
                        "id": "2",
                        "playerOne": "C",
                        "playerTwo": "D"
                    ]]))

                    slamApi.getQueue(setReturnedMatches)

                    expect(returnedMatches.count).to(equal(2))
                }
            }

            describe("removing a match from the queue") {
                it("makes an http request") {
                    httpClient.setResponse(self.toJSON([]))

                    slamApi.removeMatchFromQueue("23", onSuccess: {() -> Void in })

                    expect(httpClient.wasRequestMade).to(beTrue())
                    expect(httpClient.lastRequest!.HTTPMethod).to(equal("DELETE"))
                }

                it("configures the url properly") {
                    httpClient.setResponse(self.toJSON([]))

                    slamApi.removeMatchFromQueue("23", onSuccess: {() -> Void in })

                    let urlString = "\(slamApi.removeMatchFromQueueURL)?id=23"
                    let expectedURL = NSURL(string: urlString)
                    expect(httpClient.lastRequest!.URL).to(equal(expectedURL))
                }
            }
        }
    }
}
