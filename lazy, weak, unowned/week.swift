protocol SomeDelegate: AnyObject {
    func didReceiveData(data: String)
}

class DataReceiver {
    weak var delegate: SomeDelegate?
    
    func fetchData() {
        
       // delegate?.didReceiveData(data: data)
    }
}

class DataProcessor: SomeDelegate {
    func didReceiveData(data: String) {
        let data = "Some data"
        print("Received data: \(data)")
    }
}

let receiver = DataReceiver()
let processor = DataProcessor()
receiver.delegate = processor
receiver.fetchData() // Output: "Received data: Some data"
processor.data