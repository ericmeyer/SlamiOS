import Slam
import Quick
import Nimble

class LoginViewControllerSpec: QuickSpec {
    override func spec() {

        describe("The login controller") {
            it("exists") {
                let controller = LoginViewController()
            }

            it("gets an objective-c value") {
                let foo = Foo()
                expect(foo.bar()).to(equal("Hello World"))
            }
        }
    }
}
