import UIKit

var str = "Hello, playground"
let consI = 20
let floatConstant: Float = 4

let label = "this is "
let num = 94
let labelNum = label + String(num)


let apple = 3
let orange = 5
let appleSummary = "I have \(apple) apples."
let orangeSummary = "I have \(orange) oranges."

let floatNum1: Float = 3.0
let floatNum2: Float = 4
let floatSum = floatNum1 + floatNum2
let float2Str = "I have \(floatSum) class"

let multipleLineStr = """
I said "I have \(apple) apples"
And I said "I have \(orange + apple) pieces of fruits"
"""

var arrayList = ["apple", "orange", "peach"]
var arrayDict = [
    "apple": 1,
    "orange": 2,
    "peach": 3]
arrayDict["watermelon"] = 4

let emptyArray = [String]()
let emptyDict = [String: Int]()

let individualScore = [1, 2, 3, 4, 5, 6, 7, 8]
var teamScore = 0
for score in individualScore{
    if score > 5{
        teamScore += 3
    }else{
        teamScore += 1
    }
}

//let boolTest = true
//if boolTest{
//    print("YES")
//}else{
//    print("NO")
//}

var optionalString: String? = "Hello"
//print(optionalString == nil)

var optionalName: String? = nil
var greeting = "Hello"
if let name = optionalName{
    greeting = "Hello, \(name)"
}else{
    greeting = "Hello to somebody"
}

let nickName: String? = nil
let fullName: String = "GZ"
let informalGreeting = "Hello, \(nickName ?? fullName)"

//let vegetable: String = "green pepper"
//switch vegetable{
//case "celery":
//    print("Add some raisins and make ants on a log.")
//case "cucumber", "watercress":
//    print("That would make a good tea sandwich.")
//case let x where x.hasSuffix("pepper"):
//    print("it is a spicy \(x)?")
//default:
//    print("everyting tastes good in soup.")
//}

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 30, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
var largestKind = " "
for (kind, numbers) in interestingNumbers{
    for number in numbers{
        if number > largest{
            largest = number
            largestKind = kind
        }
    }
}
//print(largestKind, largest)

var n = 2
while n < 100{
    n *= 2
}
//print(n)

var m = 2
repeat{
    m *= 2
}while m < 100
//print(m)

var total = 0
for i in 0..<4{
    total += i
}
//print(total)

func greet(person: String, day: String) -> String{
    return "Hello \(person), todau is \(day)"
}
greet(person:"GZ", day: "Mon.")

func greet2(_ person: String, on day: String) -> String{
    return "Hello \(person), today is \(day)"
}
greet2("GZ", on: "Tue.")

func calculateStatistic(scores: [Int]) -> (min: Int, max: Int, sum: Int){
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores{
        if score > max {
            max = score
        }else if score < min{
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}

let statistics = calculateStatistic(scores: [1,2,3,4,5,6,7,8])
//print(statistics.max)

func returnFifteen() -> Int{
    var y = 10
    func add() -> Int{
        y += 5
        return y
    }
    let someShit: Int = add()
    return someShit
}
returnFifteen()

func makeIncrementer() -> ((Int) -> Int){
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool{
    for item in list{
        if condition(item){
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool{
    return number < 10
}
var numbers = [1, 10, 2, 20, 3, 30]
hasAnyMatches(list: numbers, condition: lessThanTen)

numbers.map({
    (number: Int) -> Int in
    var result = number
    if result % 2 != 0{
        result = 0
    }
    return result
})

let mappedNumbers = numbers.map({number in 3 * number})
//print(mappedNumbers)

let sortedNumbers = numbers.sorted(by: >)
//print(sortedNumbers)

class Shape{
    var numberOfSides = 0
    let addOneConstant: String = "constant"
    
    func addOneFunction(content: String) -> String{
        return "the content of this function is \(content)"
    }
    func simpleDescription() -> String{
        return "A shape with \(numberOfSides) sides"
    }
}
var shape = Shape()
shape.addOneFunction(content: shape.addOneConstant)
shape.simpleDescription()
shape.numberOfSides = 7
var shapeDesception = shape.simpleDescription()

class nameShape{
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String){
        self.name = name
    }
    func simpleDescription() -> String{
        return "A shape of \(numberOfSides) sides"
    }
}

var ns = nameShape(name: "Mobile")
ns.simpleDescription()

class Square: nameShape{
    var sideLength: Double
    
    init(sideLength: Double, name: String){
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)"
    }
}
let test = Square(sideLength: 4.2, name: "GZ")
test.area()
test.simpleDescription()

class Circle: nameShape{
    var radious: Double
    
    init(radious: Double, name: String) {
        self.radious = radious
        super.init(name: name)
    }
    
    func area() -> Double{
        return 3.14 * radious * radious
    }
    
    override func simpleDescription() -> String {
        return "A circle with radious of length \(radious)"
    }
}
var myCircle = Circle(radious: 4, name: "a circle")
myCircle.area()
myCircle.simpleDescription()
//print(myCircle.numberOfSides)

class EquilateralTriangle: nameShape{
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3 * sideLength
        }
        set {
            sideLength = newValue / 3
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilatera triangle with side length of \(sideLength)."
    }
}

var triangle = EquilateralTriangle(sideLength: 3, name: "TA")
triangle.perimeter
triangle.sideLength
triangle.perimeter = 12
triangle.sideLength

class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet{
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet{
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        triangle = EquilateralTriangle(sideLength: size, name: name)
        square = Square(sideLength: size, name: name)
    }
}

var triangleAndSquare = TriangleAndSquare(size: 5, name: "TAS")
triangleAndSquare.square.sideLength
triangleAndSquare.triangle.sideLength

triangleAndSquare.square = Square(sideLength: 10, name: "TAS2")
triangleAndSquare.triangle.sideLength

let optionalSquare: Square? = Square(sideLength: 10, name: "OS")
let sideLength = optionalSquare?.sideLength


enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String{
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.ace
let aceRawValue = ace.rawValue

enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoice = Beverage.allCases.count


struct Resolution {
    var width = 0
    var length = 0
}

class VideoDemo {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoDemo = VideoDemo()

someVideoDemo.resolution.length = 120
someVideoDemo.resolution.length

let vga = Resolution(width: 640, length: 480)
let hd = Resolution(width: 1920, length: 1080)
var cinema = hd
cinema.width = 2048

let tenEntity = VideoDemo()
tenEntity.resolution = hd
tenEntity.frameRate = 25.0
tenEntity.interlaced = true
tenEntity.name = "1080i"

let alsoTenEntity = tenEntity
alsoTenEntity.frameRate = 30
tenEntity.frameRate

var aArray = [1,2,3,4,5]
let random = Int(arc4random_uniform(UInt32(aArray.count)))


