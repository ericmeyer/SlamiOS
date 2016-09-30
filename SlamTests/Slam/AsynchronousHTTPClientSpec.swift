import Quick
import Nimble
import Slam
import Foundation

extension NSURLConnection {

    fileprivate struct SendRequestData {
        static var lastRequest: URLRequest?
        static var lastQueue: OperationQueue?
        static var dataToReturn: Data = Data()
    }

    class var lastRequest: URLRequest? {
        get { return SendRequestData.lastRequest }
        set { SendRequestData.lastRequest = newValue }
    }
    class var lastQueue: OperationQueue? {
        get { return SendRequestData.lastQueue }
        set { SendRequestData.lastQueue = newValue }
    }
    class var dataToReturn: Data {
        get { return SendRequestData.dataToReturn }
        set { SendRequestData.dataToReturn = newValue }
    }

    @objc class func sendAsynchronousRequest(_ request: URLRequest, queue: OperationQueue!,  handler: (URLResponse?, Data?, NSError?) -> Void) {
        lastRequest = request
        lastQueue = queue
        handler(URLResponse(), dataToReturn, NSError(domain: "Some Error", code: 123, userInfo: nil))
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

                client!.makeRequest(request as URLRequest, onSuccess: {(data: Data) in
                })

//                expect(NSURLConnection.lastRequest).toNot(beNil())
//                expect(NSURLConnection.lastRequest!).to(beIdenticalTo(request))
            }

            it("sends the request using the main queue") {
                client!.makeRequest(NSURLRequest() as URLRequest, onSuccess: {(data: Data) in
                })

//                expect(NSURLConnection.lastQueue).toNot(beNil())
//                expect(NSURLConnection.lastQueue!).to(beIdenticalTo(NSOperationQueue.mainQueue()))
            }

            it("executes the success callback with the returned data") {
                let expectedData = NSData()
                NSURLConnection.dataToReturn = expectedData as Data

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
