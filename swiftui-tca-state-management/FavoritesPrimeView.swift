//
//  FavoritesPrimeView.swift
//  swiftui-tca-state-management
//
//  Created by bruno on 11/10/21.
//

import SwiftUI

struct FavoritesPrimeView: View {
    
    @ObservedObject var state: AppState
    
    var body: some View {
        VStack {
            List {
                ForEach(state.favoritePrimes, id: \.self) { value in
                    Text("\(value)")
                }
                .onDelete(perform: delete)
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Favorite Primes")
        .preferredColorScheme(.dark)
    }
    
    private func delete(offsets: IndexSet) {
        for index in offsets {
            state.favoritePrimes.remove(at: index)
        }
    }
}

struct FavoritesPrimeView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesPrimeView(state: AppState())
    }
}
