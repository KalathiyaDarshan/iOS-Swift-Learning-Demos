print("hello world")
//implicit Declartion
//let cannot change value

var a = 12
var b="hello world"
print(a)
print(b.count)
print(b.uppercased())
b.append(" swift")
print(b.isEmpty)


//strig interpolation
print("my age\(a) and my name\(b)")

//Explicit Declartion
var name: String = "Darshan"
print(name)
var age: Int = 20
print(age)

//logical not ! reverce value
//logical and && both are valid
//logicsl OR ||


let abc = "Hii \(age+a)Mr"
let def = 94
let myname = abc + String(def)
print(myname)

var optionalName: Int? = 15
var greeting = "Hello"
if let name = optionalName {
greeting = "Hello, \(name)"
print(greeting)
}


