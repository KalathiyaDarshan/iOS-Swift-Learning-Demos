//
//  API_Introduction.swift
//  API-Introduction
//
//  Created by mac on 18/07/24.
//

import Foundation

// MARK: - The Top 8 API Architectural Styles You Should Know in 2023

/*
REST (Representational State Transfer): A champion of simplicity and ubiquity, REST is an architectural style that primarily leverages HTTP methods. It enables easy interaction with resources, making it a go-to pattern for a multitude of applications and modern APIs.

SOAP (Simple Object Access Protocol): SOAP, a heavyweight contender in the API arena, thrives on complexity and power. It employs XML for defining structured communication. Although requiring a SOAP client and server, it compensates with its strength and robustness, much like a well-built off-road vehicle tackling rugged terrains.

GraphQL: A rising star in the API cosmos, GraphQL offers flexibility and precision. It lets clients ask for exactly what they need, reducing redundancy, and improving performance. Think of it as a personal shopper - you get just what you asked for, nothing more, nothing less.

gRPC (Google Remote Procedure Call): gRPC is the speedster of the API universe. Running on HTTP/2 and using binary data, it's all about performance and speed, especially for microservices architectures. It's like a high-speed train, ensuring quick and reliable communication.

WebSockets: If real-time and bi-directional communication is what you need, WebSockets are the answer. Ideal for chat applications, live streaming, and real-time data exchange, it's like having an open telephone line between clients and servers.

Webhooks: Webhooks are the town criers of the digital world. They notify clients when certain server-side events occur, making them perfect for event-driven architectures. Imagine them as your personal alert system, keeping you informed of what matters.

MQTT (Message Queuing Telemetry Transport): MQTT is a lightweight messenger, designed specifically for environments with limited resources, low bandwidth, and unreliable networks. Picture it as a postal worker determined to deliver your mail, come rain or shine.

AMQP (Advanced Message Queuing Protocol): A robust and standardized protocol, AMQP excels in middleware environments with its reliable messaging capabilities. It's like a well-oiled assembly line, efficiently moving messages where they need to go.
*/

// MARK: - What is API? OR Have you used URLSession class? What does it do? -

/*
 
 API stands for Application Programming Interface. It is a set of protocols, routines, and tools for building software applications. An API specifies how software components should interact and enables communication between different software systems.
 
 URLSession is a class in iOS Swift that provides an easy-to-use interface for working with network resources. It allows developers to make HTTP requests to web servers and receive responses.
 
 URLSession provides a way to create data tasks, download tasks, and upload tasks. Data tasks are used for retrieving data from a web server, download tasks are used for downloading large files, and upload tasks are used for uploading files to a web server. URLSession also provides support for handling authentication challenges, caching, and background downloads/uploads.
 
 With URLSession, developers can easily implement networking functionality in their iOS apps without having to write low-level networking code. It simplifies the process of making network requests and handling responses, making it a crucial tool for developing modern iOS applications that require communication with external services.
 
 */

// MARK: - What do you use for fetching records from API and why? -

/*
 
 Suggestion: It’s best here not to answer things like “ I am using XYZ because my senior told me to do so” OR “We use ABC because it was already there in the project”. Please answer with more technical reasons than such reasons.
 
 */

// MARK: - What is REST API? What’s the difference between POST and PUT? -

/*
 
 REST (Representational State Transfer) API is a software architectural style for building scalable web services that can be accessed through HTTP(S) requests.
 
 In REST API, resources are identified by unique URIs (Uniform Resource Identifiers), and the operations that can be performed on them are represented by standard HTTP methods such as GET, POST, PUT, DELETE, etc.
 
 One of the key features of REST API is that it is stateless, meaning that each request is independent of any previous request. This allows for a high degree of scalability and makes it possible to cache responses for better performance.
 
 REST API supports a variety of data formats such as XML, JSON, and YAML, making it platform- and language-agnostic. It is widely used in modern web and mobile application development, as well as in integration between different systems and services.
 
 POST and PUT are both HTTP methods used for sending data to a server in order to create or update a resource. The key difference between them lies in how they handle resource creation or updates.
 
 POST is typically used to create a new resource on the server, and the server assigns a unique identifier to the resource. When using POST, the URI of the newly created resource is returned in the response body. If a resource with the same identifier already exists, POST may either create a new resource with a different identifier or return an error.
 
 PUT, on the other hand, is typically used to update an existing resource on the server. When using PUT, the client sends the entire updated representation of the resource to the server, including any fields that may not have changed. If the resource does not exist, PUT may either create it or return an error.
 
 In summary, POST is used for creating a new resource, while PUT is used for updating an existing resource. It's important to note that the semantics of POST and PUT can vary depending on the specific API implementation, so it's always best to consult the API documentation for guidance on how to use these methods correctly.
 
 */

// MARK: - What is JSON parsing? -


/*
 
 JSON parsing is the process of converting data that is formatted in JSON (JavaScript Object Notation) into a usable format in an iOS Swift application.
 
 In Swift, JSON data can be converted into Swift objects, such as dictionaries, arrays, or custom data models, using the JSONSerialization class provided by the Foundation framework. The process involves retrieving JSON data, parsing it using the JSONSerialization class, and then using the resulting Swift objects in the application.
 
 Here's an example of how to parse a JSON object in Swift:

 // Example JSON data
 let jsonData = """
 {
    "name": "John",
    "age": 30,
    "city": "New York"
 }
 """.data(using: .utf8)!
 
 // Parse the JSON data
 do {
     let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
 
     // Access the data as a dictionary
     if let dict = json as? [String: Any] {
         let name = dict["name"] as? String ?? ""
         let age = dict["age"] as? Int ?? 0
         let city = dict["city"] as? String ?? ""
         print("Name: \(name), Age: \(age), City: \(city)")
     }
 } catch {
     print("Error parsing JSON: \(error.localizedDescription)")
 }
 
 In this example, the jsonData variable contains a JSON object, which is then parsed using the JSONSerialization class. The resulting json object is then cast to a dictionary, which can be used to access the individual key-value pairs. In this case, the name, age, and city values are extracted from the dictionary and printed to the console.

 */

// MARK: - What is encoder and decoder protocols? -

/*
 
 In iOS Swift, encoder and decoder protocols refer to the set of protocols provided by Apple's Swift Standard Library for encoding and decoding data structures such as objects, arrays, and dictionaries to and from various data formats like JSON, Plist, and Codable.
 
 The Encoder protocol is used to convert a Swift data structure into an external representation such as JSON or Plist. It provides methods to encode different types of data, and it can be customized to handle custom data types or encoding strategies.
 
 The Decoder protocol, on the other hand, is used to convert an external representation such as JSON or Plist into a Swift data structure. It provides methods to decode different types of data, and it can also be customized to handle custom data types or decoding strategies.
 
 The Codable protocol is a higher-level protocol that combines both the Encoder and Decoder protocols into a single protocol. It allows for easy encoding and decoding of Swift data structures to and from various data formats with minimal coding.
 
 In summary, the encoder and decoder protocols in iOS Swift provide a flexible and extensible way to encode and decode data structures to and from different data formats. This can be very useful when working with APIs or when storing data in a file or database.
 
 */
 
// MARK: - 6 Steps for Calling API -
/*
    1. UrlRequest
    2. UrlRequestMethod
    3. HTTPBody
    4. AddValue
    5. URLSession(Library)
    6. Api Response
 */
