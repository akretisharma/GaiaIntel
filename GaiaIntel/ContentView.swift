//
//  ContentView.swift
//  GaiaIntel
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
    
    @State private var currentFactIndex: Int = 0 // Tracks the index of the current fact
    
    
var body: some View {
    TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
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
                    
                Spacer()
            }
            
            
            .navigationTitle("Home")}
                .tabItem {
                    Text("Home view")
                    Image(systemName: "house.fill")}
                    .tag(0)
                    
        NavigationStack() {
            Text("Profile view").navigationTitle("Profile")}
                .tabItem {
                    Label("Profile", systemImage: "person.fill")}
                    .tag(1)
                    
        NavigationStack() {
            Text("About view").navigationTitle("About")}
                .tabItem {
                    Text("About view")
                    Image(systemName: "info.circle")}
                    .tag(2)
            }
    .tint(.green)
    //.tint(Color(hue: 0.388, saturation: 0.98, brightness: 0.55))
    .onAppear(perform: {
        
        UITabBar.appearance().unselectedItemTintColor = .systemBrown
        
        UITabBar.appearance().backgroundColor = .systemGray4.withAlphaComponent(0.4)
        
        //UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        
    })
    

    
        }
    
    }

#Preview {
    ContentView()
}
