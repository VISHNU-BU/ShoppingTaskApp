//
//  CartView.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import SwiftUI
import CoreData

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var showingCheckoutAlert = false
    @State private var showConfetti = false
    

    var body: some View {
        VStack {
            ScrollView {
                ForEach(cartManager.cartItems) { product in
                    CartItemView(product: product)
                        .environmentObject(cartManager)
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Subtotal")
                    Spacer()
                    Text("\(cartManager.subtotal, specifier: "%.2f")")
                }
                
                HStack {
                    Text("Discount")
                    Spacer()
                    Text("\(cartManager.discount, specifier: "%.2f")")
                }
                
                HStack {
                    Text("Total")
                        .font(.headline)
                    Spacer()
                    Text("\(cartManager.total, specifier: "%.2f")")
                        .font(.headline)
                }
                
                Button(action: {
                    cartManager.checkout()
                    withAnimation {
                        showConfetti = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showingCheckoutAlert = true
                        showConfetti = false
                    }
                }) {
                    Text("Checkout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding([.horizontal, .bottom])
        }
        .navigationTitle("Cart")
        .alert(isPresented: $showingCheckoutAlert) {
            Alert(
                title: Text("Order Successful"),
                message: Text("Your order has been placed successfully!"),
                dismissButton: .default(Text("OK"))
            )
        }
        .overlay(
            VStack {
                if showConfetti {
                    FireworksView()
                        .edgesIgnoringSafeArea(.all)
                }
            }
        )
    }
}
