//
//  AppState.swift
//  swiftui-tca-state-management
//
//  Created by bruno on 11/10/21.
//

import Combine

//@ObservedObject - must perform ObservableObject protocol and updates any View that is subscribed to any of its value and hold any information across the Views
final class AppState: ObservableObject {
    @Published var count: Int = 0
}
