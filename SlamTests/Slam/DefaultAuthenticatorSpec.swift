import Foundation
import Slam
import Quick
import Nimble

class MockAuthenticationView: AuthenticationView {
    var wasToldLoginSuccessful = false

    @objc func loginWasSuccessful() {
        wasToldLoginSuccessful = true
    }
}
class DefaultAuthenticatorSpec: QuickSpec {
    override func spec() {
        it("has an instance of slamAPI") {
            let authenticator = DefaultAuthenticator()

            expect(authenticator.api).notTo(beNil())
        }

        describe("Attempting to login") {
            var authenticator: DefaultAuthenticator!
            var api: MockSlamAPI!
            var view: MockAuthenticationView!

            beforeEach() {
                authenticator = DefaultAuthenticator()
                api = MockSlamAPI(httpClient: MockHTTPClient())
                view = MockAuthenticationView()
                authenticator.view = view
                authenticator.api = api
            }

            it("delegates to the api to login") {
                authenticator.attemptLogin(email: "123", password: "123")

                expect(api.wasLoginAttempted).to(beTrue())
            }

            it("lets the view know that the login was successful") {
                api.loginSuccessful = true
                authenticator.attemptLogin(email: "123", password: "123")

                expect(view.wasToldLoginSuccessful).to(beTrue())
            }

            it("does not notify the view when the API call was not a success") {
                api.loginSuccessful = false
                authenticator.attemptLogin(email: "123", password: "123")

                expect(view.wasToldLoginSuccessful).to(beFalse())
            }

            it("with email and password") {
                authenticator.attemptLogin(email: "123", password: "password")

                expect(api.loggedInEmail).to(equal("123"))
                expect(api.loggedInPassword).to(equal("password"))
            }
        }
    }
}
