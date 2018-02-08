import Vapor
import QuartzCore
import Foundation
/*
Jean Cabral
001167363
*/

func executionTimeInterval(block: () -> ()) -> CFTimeInterval {
    let start = CACurrentMediaTime()
    block();
    let end = CACurrentMediaTime()
    return end - start
}




extension Droplet {
    func setupRoutes() throws {
      
        post("inList"){ request in
            var errorMessage = JSON()
            guard let array = request.json?["inList"]?.array else {
                try errorMessage.set("message", request.description)
                return errorMessage
                //fatalError("Required parameter was not found. The paramter was\(request.data)")
            }
            
            var tempArray = [Int]()
            for numbers in array.indices {
                tempArray.append(array[numbers].int!)
            }
            let timeInterval = executionTimeInterval {
            tempArray.sort()
            }
            var milliseconds = (timeInterval.doubleValue / 1000)
            milliseconds.round(FloatingPointRoundingRule.up)
            
            var json = JSON()
            try json.set("outList", tempArray)
            try json.set("algorithim", "insertionSort")
            try json.set("timeMS:", milliseconds)
            
            
            return json
        }
    }
}
