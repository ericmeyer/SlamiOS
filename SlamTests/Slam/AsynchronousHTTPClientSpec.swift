import Quick
import Nimble
import Slam
import Foundation

extension NSURLConnection {

    private struct SendRequestData {
        static var lastRequest: NSURLRequest?
        static var lastQueue: NSOperationQueue?
        static var dataToReturn: NSData = NSData()
    }

    class var lastRequest: NSURLRequest? {
        get { return SendRequestData.lastRequest }
        set { SendRequestData.lastRequest = newValue }
    }
    class var lastQueue: NSOperationQueue? {
        get { return SendRequestData.lastQueue }
        set { SendRequestData.lastQueue = newValue }
    }
    class var dataToReturn: NSData {
        get { return SendRequestData.dataToReturn }
        set { SendRequestData.dataToReturn = newValue }
    }

    @objc class func sendAsynchronousRequest(request: NSURLRequest, queue: NSOperationQueue!,  handler: (NSURLResponse!, NSData!, NSError!) -> Void) {
        lastRequest = request
        lastQueue = queue
        handler(NSURLResponse(), dataToReturn, NSError(domain: "Some Error", code: 123, userInfo: nil))
    }

}
class AsynchronousHTTPClientSpec: QuickSpec {
    override func spec() {

        describe("Making a request") {
            var client: AsynchronousHTTPClient?

            beforeEach() {
                client = AsynchronousHTTPClient()
            }

            it("sends the request using NSURLConnection") {
                let request = NSURLRequest()

                client!.makeRequest(request, onSuccess: {(data: NSData) in
                })

//                expect(NSURLConnection.lastRequest).toNot(beNil())
//                expect(NSURLConnection.lastRequest!).to(beIdenticalTo(request))
            }

            it("sends the request using the main queue") {
                client!.makeRequest(NSURLRequest(), onSuccess: {(data: NSData) in
                })

//                expect(NSURLConnection.lastQueue).toNot(beNil())
//                expect(NSURLConnection.lastQueue!).to(beIdenticalTo(NSOperationQueue.mainQueue()))
            }

            it("executes the success callback with the returned data") {
                let expectedData = NSData()
                NSURLConnection.dataToReturn = expectedData

//                var actualData: NSData?
//                client!.makeRequest(NSURLRequest(), onSuccess: {(data: NSData) in
//                    actualData = data
//                })

//                expect(actualData).toNot(beNil())
//                expect(actualData!).to(beIdenticalTo(expectedData))
            }
        }

    }

    override func setUp() {
        continueAfterFailure = false
    }
}
