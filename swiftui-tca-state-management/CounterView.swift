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
    @State var alertNthPrime: PrimeAlert?
    
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
            Button(action: {
                nthPrime(state.count) { prime in
                    guard let prime: Int = prime else { return }
                    self.alertNthPrime = PrimeAlert(prime: prime)
                }
            }) {
                Text("What is the \(ordinal(state.count)) prime?")
            }
        }
        .font(.title)
        .navigationTitle("Counter demo")
        .sheet(isPresented: $showPrimeSheet) {
            IsPrimeModalView(count: $state.count, favoritePrimes: $state.favoritePrimes)
        }
        .alert(item: $alertNthPrime) { n in
            Alert(title: Text("The \(ordinal(state.count)) prime is \(n.prime)"),
                  dismissButton: Alert.Button.default(Text("Ok")))
        }
    }
    
    private func ordinal(_ n: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(for: n) ?? ""
    }
    
    func wolframAlpha(query: String, callback: @escaping (WolframAlphaResult?) -> Void) -> Void {
        var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
        components.queryItems = [
            URLQueryItem(name: "input", value: query),
            URLQueryItem(name: "format", value: "plaintext"),
            URLQueryItem(name: "output", value: "JSON"),
            URLQueryItem(name: "appid", value: ContentView.wolframAlphaApiKey),
        ]
        
        URLSession.shared.dataTask(with: components.url(relativeTo: nil)!) { data, response, error in
            callback(
                data
                    .flatMap { try? JSONDecoder().decode(WolframAlphaResult.self, from: $0) }
            )
        }
        .resume()
    }
    
    func nthPrime(_ n: Int, callback: @escaping (Int?) -> Void) -> Void {
        wolframAlpha(query: "prime \(n)") { result in
            callback(
                result
                    .flatMap {
                        $0.queryresult
                            .pods
                            .first(where: { $0.primary == .some(true) })?
                            .subpods
                            .first?
                            .plaintext
                    }
                    .flatMap(Int.init)
            )
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(state: AppState())
            .preferredColorScheme(.dark)
    }
}
