//
//  ContentView.swift
//  Expense Tracker
//
//  Created by Mohamed Abdelmagid on 7/9/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showingAddTransaction = false
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
                .tag(0)
            
            BudgetView()
                .tabItem {
                    Label("Budget", systemImage: "chart.pie.fill")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
        .tint(Color(hex: "023047") ?? .blue)
        .sheet(isPresented: $showingAddTransaction) {
            AddTransactionView()
        }
        .overlay(
            // Floating Action Button - Only show on Dashboard
            Group {
                if selectedTab == 0 {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                showingAddTransaction = true
                            }) {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 56, height: 56)
                                    .background(Color(hex: "219EBC") ?? .blue)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                            }
                            .padding(.trailing, 20)
                            .padding(.bottom, 90) // Account for tab bar
                        }
                    }
                }
            }
        )
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Transaction.self, Category.self, Budget.self, MonthlyBudget.self, CategoryBudget.self, RecurringSubscription.self, PlannedIncome.self, PlannedExpense.self], inMemory: true)
}
