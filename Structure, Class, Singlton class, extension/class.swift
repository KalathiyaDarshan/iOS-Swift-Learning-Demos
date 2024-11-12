//1

class Person{
    var name: String
    var age : Int

  // Initializer (constructor)
    init(name: String,age: Int)
    {
        self.name = name
        self.age = age
    }
    
    func sayHello()
    {
        print("my name is \(name),and my age is \(age)")
    }
}

// Creating an instance of the class

let person = Person(name : "Darshan", age : 19)
// Accessing properties and calling a method
print("Name : \(person.name)")
print("Age : \(person.age)")
person.sayHello()


//2

class simmple{
   
   init()
   {
      print("simple class")
   } 
}
var sm = simmple()
print(sm)
// 3
class myclass{
   var  nm : String = "darshan"
}
var my = myclass()
print(my.nm)