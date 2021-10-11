//
//  AppState.swift
//  swiftui-tca-state-management
//
//  Created by bruno on 11/10/21.
//

import Combine

//@ObservedObject - must perform ObservableObject protocol and updates any View that is subscribed to any of its value and hold any information across the Views

//Simplest definition
//final class AppState: ObservableObject {
//    @Published var count: Int = 0
//}

//Complete definition
final class AppState: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    //note that @Published property wrapper wrapp all this implementation for you
    var count = 0 {
        willSet { self.objectWillChange.send() }
    }
    
    var favoritePrimes: [Int] = [] {
        willSet { self.objectWillChange.send() }
    }
}
