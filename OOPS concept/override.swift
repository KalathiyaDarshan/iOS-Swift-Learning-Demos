//Polymorphism
//overrideng = same name different parameters
//overloading = same name same parameters 

class Animal {
    func makeSound() {
        print("Animal makes a sound")
    }
}

class Dog: Animal {
    override func makeSound() {
        print("Dog barks")
    }
}

class Cat: Animal {
    override func makeSound() {
        print("Cat meows")
    }
}

// Function that takes an Animal object and calls makeSound()
func makeAnimalSound(animal: Animal) {
    animal.makeSound()
}

// Example usage
let animal = Animal()
let dog = Dog()
let cat = Cat()

makeAnimalSound(animal: animal) // Output: Animal makes a sound
makeAnimalSound(animal: dog)    // Output: Dog barks
makeAnimalSound(animal: cat)    // Output: Cat meows
