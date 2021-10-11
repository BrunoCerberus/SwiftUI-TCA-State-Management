//
//  ContentView.swift
//  swiftui-tca-state-management
//
//  Created by bruno on 10/10/21.
//

// WARNING: on TCA first episode, they use @ObjectBinding property wrapper and BindableObject protocol
// Since SwiftUI 2.0, these syntax changed to @ObservedObject wrapper and ObservableObject protocol

import SwiftUI

struct ContentView: View {
    
    //notice that an ObservedObject is beeing initialized here, so, any changes on its object, will
    //reload the whole structure and stack of views
    
    @ObservedObject var state: AppState = AppState()
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CounterView(state: state)) {
                    Text("Counter demo")
                }
                
                NavigationLink(destination: EmptyView()) {
                    Text("Favorite primes")
                }
            }
            .refreshable {
                debugPrint("Refreshed")
            }
            .listStyle(PlainListStyle())
            .navigationTitle("State Management")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(state: AppState())
    }
}
