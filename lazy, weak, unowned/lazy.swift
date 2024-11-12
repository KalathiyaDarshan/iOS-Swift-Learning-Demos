class SomeClass {
    // This property is initialized only when it's accessed for the first time
    lazy var someProperty: String = "darshan"
}
// Create an instance of SomeClass
let instance = SomeClass()


// Accessing the lazy property for the first time
print(instance.someProperty) // This triggers the initialization of someProperty

instance.someProperty = "dhgfgh"
// Accessing the lazy property again
print(instance.someProperty) // Since it's already initialized, no further initialization is needed


