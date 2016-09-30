import Foundation

open class DefaultAuthenticator: NSObject, AuthenticationInteractor {

    open var view: AuthenticationView?
    open var api : SlamAPI?

    public override init() {
        api = SlamAPI(httpClient: AsynchronousHTTPClient())
    }

    open func attemptLogin(email: String, password: String) {
        api?.attemptLogin(
            email: email,
            password: password,
            onSuccess: { session in
                self.view?.loginWasSuccessful()
            }
        )
    }

}
