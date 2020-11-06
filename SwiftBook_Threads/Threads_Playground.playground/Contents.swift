import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class SafeArray<Element> {
    private var array = [Element]()
    private let queue = DispatchQueue(label: "DispatchBarier", attributes: .concurrent)
    
    public func append(element: Element) {
        queue.async(flags: .barrier) {
            self.array.append(element)
        }
    }
    
    public var elements: [Element] {
        var result = [Element]()
        queue.sync {
            result = self.array
        }
        return result
    }
}

var Safearray = SafeArray<Int>()

DispatchQueue.concurrentPerform(iterations: 105) { (index) in
    Safearray.append(element: index)
}

// print("array: \(Safearray.elements)")

//-----------------------------------------------------------
// GROUPS:

let queue1 = DispatchQueue(label: "label", attributes: .concurrent)

let group = DispatchGroup()

queue1.async(group: group) {
    for i in 0...10 {
        if i == 10 {
            print(i)
        }
    }
}

queue1.async(group: group) {
    for i in 0...20 {
        if i == 20 {
            print(i)
        }
    }
}

group.notify(queue: .main) {
    print("Work is done in the group: firstgroup")
}

let secondGroup = DispatchGroup()

secondGroup.enter()
queue1.async(group: group) {
    for i in 0...30 {
        if i == 30 {
            print(i)
            sleep(2)
            secondGroup.leave()
        }
    }
}

let result = secondGroup.wait(timeout: .now() + 1)
print(result)

secondGroup.notify(queue: .main) {
    print("Work is done in the group: secondGroup")
}

secondGroup.wait()

print("Second group has end it's work")


































