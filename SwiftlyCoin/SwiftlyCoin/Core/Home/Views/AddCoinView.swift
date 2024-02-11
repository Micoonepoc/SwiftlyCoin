//
//  AddCoinView.swift
//  SwiftlyCoin
//
//  Created by Михаил on 24.01.2024.
//

import SwiftUI
import Lottie

struct AddCoinView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var amountText = ""
    @State private var showCheckmark: Bool = false
        
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(textFieldText: $vm.searchText)
                    coinList
                                
                    Spacer()
                    
                    if selectedCoin != nil {
                       coinInput
                    } else {
                        LottieView(animationFileName: "CoinsAnimation", loopMode: .loop)
                            .frame(width: 380, height: 400)
                    }
                    
                    Spacer()
                    
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Image(systemName: "checkmark")
                            .font(.headline)
                            .opacity(showCheckmark ? 1.0 : 0.0)
                        Button(action: {
                            saveButtonPressed()
                        }, label: {
                            Text("SAVE")
                        })
                        .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(amountText)) ? 1.0 : 0.0)
                    }
                }
            })
            .onChange(of: vm.searchText) {
                if vm.searchText == "" {
                    cleanCoin()
                }
            }
            .navigationTitle("Add some coins")
        }
    }
}

struct AddCoinViewPreview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddCoinView()
        }
        .environmentObject(dev.homeVM)
    }
}

extension AddCoinView {
    
    private var coinList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    AddCoinImageView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(selectedCoin?.id == coin.id ? Color.colorTheme.green : Color.clear, lineWidth: 1.0)
                        )
                }
            }
        }
        .frame(height: 150)
        .padding(.leading)
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portlofioCoins.first(where: { $0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
            amountText = "\(amount)"
        } else {
            amountText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let amount = Double(amountText) {
            return amount * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var coinInput: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text("\(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")")
            }
            Divider()
            HStack {
                Text("Amount:")
                Spacer()
                TextField("Ex. 1.5", text: $amountText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .padding()
    }
    
    private func saveButtonPressed() {
        
        guard 
            let coin = selectedCoin,
            let amount = Double(amountText)
        else { return }
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation {
            showCheckmark = true
            cleanCoin()
        }
        
        UIApplication.shared.endTextEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut) {
                showCheckmark = false
            }
        }
        
    }
    
    private func cleanCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}


