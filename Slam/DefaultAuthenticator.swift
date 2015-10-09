import Foundation

public class DefaultAuthenticator: NSObject, AuthenticationInteractor {

    public var view: AuthenticationView?
    public var api : SlamAPI?

    public override init() {
        api = SlamAPI(httpClient: AsynchronousHTTPClient())
    }

    public func attemptLogin(email email: String, password: String) {
        api?.attemptLogin(
            email: email,
            password: password,
            onSuccess: { session in
                self.view?.loginWasSuccessful()
            }
        )
    }

}