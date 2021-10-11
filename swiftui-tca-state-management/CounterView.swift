//
//  CounterView.swift
//  swiftui-tca-state-management
//
//  Created by bruno on 10/10/21.
//

import SwiftUI

struct CounterView: View {
    
    // WARNING: presentation modifier was changed to sheet
    
    // this propertie wrapper only updates its view when value changed but not persists value
//    @State var count: Int = 0
    @ObservedObject var state: AppState
    @State var showPrimeSheet: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if state.count != 0 {
                        state.count -= 1
                    }
                }) {
                    Text("-")
                }
                Text("\(state.count)")
                Button(action: { state.count += 1 }) {
                    Text("+")
                }
            }
            Button(action: { showPrimeSheet.toggle() }) {
                Text("Is this prime?")
            }
            Button(action: {}) {
                Text("What is the \(ordinal(state.count)) prime?")
            }
        }
        .font(.title)
        .navigationTitle("Counter demo")
        .sheet(isPresented: $showPrimeSheet) {
            IsPrimeModalView(count: $state.count, favoritePrimes: $state.favoritePrimes)
        }
    }
    
    private func ordinal(_ n: Int) -> String {
      let formatter = NumberFormatter()
      formatter.numberStyle = .ordinal
      return formatter.string(for: n) ?? ""
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(state: AppState())
            .preferredColorScheme(.dark)
    }
}
