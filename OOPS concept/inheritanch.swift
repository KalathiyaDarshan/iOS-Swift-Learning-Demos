class Animal {
     
    func makeSound() {
        print("Animal makes a sound")
    }
}
class Tiger : Animal {
    func  growl()
    {
        print("tiger growl")
    }
}
class Dog: Animal  {
    func bark() {
        print("Dog barks")
    }
}
let dog = Dog()
let tiger = Tiger()
dog.bark()       // Output: "Dog barks"
dog.makeSound()  // Animal makes a sound
tiger.growl()
tiger.makeSound()

// Hybrid Inheritance
class A1 {
    
    func a1() {
        print(" A.")
    }
}

class B1: A1 {
    func b1() {
        print(" B.")
    }
}

class C1 :B1 {
    func c1() {
        print(" C.")
    }
}

class D1: B1  {
    func d1()
    {
        print(" D. ")
    }
}
let abc1 =  C1()
abc1.a1()
abc1.b1()
abc1.c1()

let abc = D1()
abc.a1()
abc.b1()
abc.d1()

