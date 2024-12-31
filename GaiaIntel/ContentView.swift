//
//  ContentView.swift
//  gaiaintel
//
//  Created by Akreti Sharma on 2024-12-30.
//

import SwiftUI

struct ContentView: View {
    let facts = [
        "AI can optimize energy consumption in smart homes.",
        "Data centers used for AI training account for 1% of global electricity usage.",
        "AI helps predict extreme weather patterns to aid disaster response.",
        "Some AI systems consume as much energy as 5 cars running for a year.",
        "AI is used to monitor deforestation and illegal logging in real-time."
    ]
    @State private var selectedTab = 1
    
    @State private var currentFactIndex: Int = 0 // Tracks the index of the current fact
    
    struct ToDoItem: Identifiable {
        var id = UUID()
        var name: String
        var isChecked: Bool
    }
    
    @State private var toDoItems = [
        ToDoItem(name: "Plant a tree", isChecked: false),
        ToDoItem(name: "Switch to renewable energy", isChecked: false),
        ToDoItem(name: "Reduce meat consumption", isChecked: false)
    ]
    
    @State private var positiveQuizScore: Double = 0.0 // Tracks Positive Quiz progress
    @State private var negativeQuizScore: Double = 0.0 // Tracks Negative Quiz progress
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack() {
                
                VStack {
                    HStack {
                        Text("Fact Generator")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button("Click here!") {
                            currentFactIndex = Int.random(in: 0..<facts.count)
                        }
                        .font(.headline)
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.trailing, 20)
                        
                    }
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    
                    
                    Text(facts[currentFactIndex])
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Text("Recent")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                        .padding(.top, 20)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                
                
                .navigationTitle("Homepage")}
            .tabItem {
                Text("Home view")
                Image(systemName: "house.fill")}
            .tag(1)
            
            NavigationStack() {
                
                VStack(spacing: 20) {
                    
                    NavigationLink(destination: PositiveEffectsView(quizScore: $positiveQuizScore)) {
                        VStack(alignment: .leading) {
                            Text("Positive Effects of AI")
                                .font(.title2)
                                .fontWeight(.bold)
                            ProgressView(value: positiveQuizScore, total: 1.0)
                                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: NegativeEffectsView(quizScore: $negativeQuizScore)) {
                        VStack(alignment: .leading) {
                            Text("Negative Effects of AI")
                                .font(.title2)
                                .fontWeight(.bold)
                            ProgressView(value: negativeQuizScore, total: 1.0)
                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Learn")
            }
            .tabItem {
                Label("Learn", systemImage: "lightbulb.fill")}
            .tag(2)
            
            NavigationStack() {
                VStack {
                    Text("Things You Can Do")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    List {
                        ForEach($toDoItems, id: \.name) { $item in
                            HStack {
                                Button(action: {
                                    item.isChecked.toggle() // Toggle the checkbox status
                                }) {
                                    Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(item.isChecked ? .green : .gray)
                                }
                                Text(item.name)
                                    .strikethrough(item.isChecked, color: .gray)
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Take Action")
                
                
            }
            .tabItem {
                Label("Take Action", systemImage: "leaf.fill")}
            .tag(3)
            .badge(toDoItems.filter { !$0.isChecked }.count)
        }
        .tint(.green)
        .onAppear(perform: {
            
            UITabBar.appearance().unselectedItemTintColor = .systemBrown
            
            UITabBar.appearance().backgroundColor = .systemGray4.withAlphaComponent(0.4)
            
        })
        
        
        
    }
    
    let positiveEffects = [
        "AI optimizes energy usage in buildings and homes.",
        "AI helps predict natural disasters and enables better planning.",
        "AI monitors and reduces deforestation with satellite imagery."
    ]
    
    let negativeEffects = [
        "Training large AI models consumes significant energy.",
        "AI technologies often rely on rare earth materials, which are hard to mine sustainably.",
        "Increased reliance on AI can sometimes lead to energy inefficiencies."
    ]
    
}


#Preview {
    ContentView()
}

