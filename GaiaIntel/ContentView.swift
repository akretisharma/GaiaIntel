//
//  ContentView.swift
//  gaiaintel
//
//  Created by Akreti Sharma on 2024-12-30.
//

import SwiftUI
import Charts
      
struct ContentView: View {
    
    //General variables for entire app
    @State private var selectedTab = 1
    
    //Variables for Home page
    let facts = [
        "AI can optimize energy consumption in smart homes.",
        "Data centers used for AI training account for 2% of global electricity usage.",
        "AI helps predict extreme weather patterns to aid disaster response.",
        "Some AI systems consume as much energy as 5 cars running for a year.",
        "AI is used to monitor deforestation and illegal logging in real-time.",
        "Training a single large AI model can emit as much carbon as five round-trip flights between New York and London.",
        "AI helps analyze satellite imagery to track biodiversity loss and endangered species populations.",
        "AI-assisted climate models are helping scientists simulate and understand long-term environmental changes.",
        "AI systems enable farmers to reduce pesticide and fertilizer use by analyzing soil and crop data, leading to sustainable agriculture."
    ]
    
    @State private var currentFactIndex: Int = 0
    
    //Variables for Take Action page
    struct ToDoItem: Identifiable, Codable {
        var id = UUID()
        var name: String
        var isChecked: Bool
    }
    
    @State private var toDoItems = [
        ToDoItem(name: "Plant a tree in your community.", isChecked: false),
        ToDoItem(name: "Switch to reusable shopping bags.", isChecked: false),
        ToDoItem(name: "Reduce water usage by fixing leaks and turning off taps.", isChecked: false),
        ToDoItem(name: "Turn off lights when not in use.", isChecked: false),
        ToDoItem(name: "Carpool or use public transportation.", isChecked: false),
        ToDoItem(name: "Start composting at home.", isChecked: false),
        ToDoItem(name: "Recycle old electronics responsibly.", isChecked: false),
        ToDoItem(name: "Install energy-efficient light bulbs.", isChecked: false),
        ToDoItem(name: "Use a reusable water bottle.", isChecked: false),
        ToDoItem(name: "Shop locally and support small businesses.", isChecked: false),
        ToDoItem(name: "Reduce single-use plastics, like straws and utensils.", isChecked: false),
        ToDoItem(name: "Unplug electronics when not in use to save energy.", isChecked: false),
        ToDoItem(name: "Participate in a community clean-up event.", isChecked: false),
        ToDoItem(name: "Switch to a vegetarian meal once a week.", isChecked: false),
        ToDoItem(name: "Donate old clothes instead of throwing them away.", isChecked: false),
        ToDoItem(name: "Advocate for green policies in your local government.", isChecked: false),
        ToDoItem(name: "Support companies that prioritize sustainability.", isChecked: false),
        ToDoItem(name: "Use a clothesline instead of a dryer.", isChecked: false),
        ToDoItem(name: "Educate yourself and others about climate change.", isChecked: false),
        ToDoItem(name: "Volunteer with an environmental organization.", isChecked: false)
    ]
        
    var taskCompletion: [(name: String, count: Int)] {
        let remaining = toDoItems.filter { !$0.isChecked }.count
        let completed = toDoItems.count - remaining
        return [
            (name: "Completed Tasks", count: completed),
            (name: "Remaining Tasks", count: remaining)
        ]
    }
    
    private func saveToDoItems() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(toDoItems)
            UserDefaults.standard.set(data, forKey: "toDoItems")
        } catch {
            print("Failed to save to-do items: \(error)")
        }
    }

    private func loadToDoItems() {
        if let data = UserDefaults.standard.data(forKey: "toDoItems") {
            do {
                let decoder = JSONDecoder()
                toDoItems = try decoder.decode([ToDoItem].self, from: data)
                UserDefaults.standard.removeObject(forKey: "toDoItems")
            } catch {
                print("Failed to load to-do items: \(error)")
            }
        }
    }

    
    //Variables for Learn page
    
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
    
    @State private var positiveQuizScore: Double = 0.0 // Tracks Positive Quiz progress
    @State private var negativeQuizScore: Double = 0.0 // Tracks Negative Quiz progress
    
    func saveQuizScores() {
        UserDefaults.standard.set(positiveQuizScore, forKey: "PositiveQuizScore")
        UserDefaults.standard.set(negativeQuizScore, forKey: "NegativeQuizScore")
    }

    func loadQuizScores() {
        positiveQuizScore = UserDefaults.standard.double(forKey: "PositiveQuizScore")
        negativeQuizScore = UserDefaults.standard.double(forKey: "NegativeQuizScore")
    }
    
    struct Article: Identifiable {
        var id = UUID()
        var name: String
        var author: String
        var image: String
        var desc: String
        var link: String
    }
    
    @State private var articles = [
        Article(name: "Explainer: How AI helps combat climate change", author: "UN News", image: "article1img", desc: "AI can revolutionize the world's approach to carbon neutrality...", link: "https://news.un.org/en/story/2023/11/1143187"),
        Article(name: "Can We Mitigate AI’s Environmental Impacts?", author: "Yale School of the Environment", image: "article2img", desc: "AI can enhance energy efficiency and reduce energy...", link: "https://environment.yale.edu/news/article/can-we-mitigate-ais-environmental-impacts"),
        Article(name: "Generative AI's Impact On Climate Change: Benefits...", author: "Forbes", image: "article3img", desc: "Researchers are using genAI to design more sustainable...", link: "https://www.forbes.com/sites/corneliawalther/2024/11/12/generative-ais-impact-on-climate-change-benefits-and-costs/")
    ]
    
    private func articleLinkView(name: String, link: String, author: String, desc: String, image: String) -> some View {
        Link(destination: URL(string: link) ?? URL(string: "https://example.com")!) {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.leading)
                Text(author)
                    .font(.footnote)
                    .italic()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                Text(desc)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
            }
            Spacer()
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 90, alignment: .center)
                .border(.green, width: 2)
                .cornerRadius(10)
                .clipped()
            
        
            
        }
        
        
    }
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack() {
                ScrollView{
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
                        
                        Text("Recent Activity")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                            .padding(.top, 20)
                            .padding(.leading, 20)
                        
                        VStack (alignment: .center) {
                            Chart {
                                ForEach(taskCompletion, id: \.name) {taskCount in
                                    SectorMark(
                                        angle: .value("Cup", taskCount.count),
                                        innerRadius: .ratio(0.6),
                                        angularInset: 2
                                    )
                                    .cornerRadius(5)
                                    .cornerRadius(5)
                                    .foregroundStyle(
                                        taskCount.name == "Completed Tasks" ? .green : .brown
                                    )
                                }
                            }
                            .frame(height: 300)
                            .chartLegend(alignment: .center, spacing: 16)
                            .chartBackground { chartProxy in
                                GeometryReader { geometry in
                                    if let anchor = chartProxy.plotFrame {
                                        let frame = geometry[anchor]
                                        Text("Actions \nTaken")
                                            .fontWeight(.bold)
                                            .position(x: frame.midX, y: frame.midY)
                                            .font(.title2)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            
                            HStack {
                                Label("Remaining Tasks", systemImage: "circle.fill")
                                    .font(.footnote)
                                    .foregroundColor(.brown)
                                
                                Label("Completed Tasks", systemImage: "circle.fill")
                                    .font(.footnote)
                                    .foregroundColor(.green)
                            }
                            .padding(.top, 10)
                            
                        }
                    }
                    
                    Spacer()
                }
                
                
                .navigationTitle("Homepage")}
            .tabItem {
                Text("Home")
                Image(systemName: "house.fill")}
            .tag(1)
            
            
            NavigationStack() {
                ScrollView{
                    VStack{
                        VStack(spacing: 20) {
                            
                            NavigationLink(destination: PositiveEffectsView(quizScore: $positiveQuizScore)) {
                                VStack(alignment: .leading) {
                                    Text("Positive Effects of AI")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    ProgressView(value: positiveQuizScore, total: 1.0)
                                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                                        .padding(.top, 20)
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
                                        .foregroundColor(.red)
                                    ProgressView(value: negativeQuizScore, total: 1.0)
                                        .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                        .padding(.top, 20)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(10)
                            }
                            
                        }
                        .padding()
                        .navigationTitle("Learn")
                        
                        Text("Related Articles")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                            .padding(.top, 20)
                            .padding(.leading, 20)
                        
                        VStack(spacing: 20){
                            ForEach($articles, id: \.id) { $item in
                                HStack {
                                    articleLinkView(name: item.name, link: item.link, author: item.author, desc: item.desc, image: item.image)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                            
                        }
                    }
                }
            }
            .tabItem {
                Label("Learn", systemImage: "lightbulb.fill")}
            .tag(2)
            
            NavigationStack() {
                VStack {
                    Text("Things You Can Do")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                    
                    List {
                        Section {
                            ForEach(toDoItems) { item in
                                HStack {
                                    Button(action: {
                                        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
                                            toDoItems[index].isChecked.toggle() // Toggle the checkbox status
                                            saveToDoItems() // Save updated data
                                        }
                                    }) {
                                        Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(item.isChecked ? .green : .brown)
                                    }
                                    Text(item.name)
                                        .strikethrough(item.isChecked, color: .brown)
                                }
                                .padding(.vertical, 5)
                                
                            }
                        }
                        .listSectionSeparatorTint(.white)
                        
                        
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Take Action")
                
                
            }
            .tabItem {
                Label("Take Action", systemImage: "leaf.fill")}
            .tag(3)
            .badge(toDoItems.filter { !$0.isChecked }.count)
            
            NavigationStack() {
                TabView(selection: $selectedTab) {
                    ChatbotView()
                    .toolbar(.hidden, for: .tabBar)
                }
            }
            
            .tabItem {
                Label("Chatbot", systemImage: "message.fill")}
            .tag(4)

        }
        
        .tint(.green)
        .background(Color.brown.ignoresSafeArea())
        .onAppear(perform: {
            
            UITabBar.appearance().unselectedItemTintColor = .systemBrown
            UITabBar.appearance().backgroundColor = .systemBrown.withAlphaComponent(0.2)
            
            loadToDoItems()
            loadQuizScores()
            
        })
        .onChange(of: positiveQuizScore) {
                saveQuizScores() // Save positive quiz score whenever it changes
            }
        .onChange(of: negativeQuizScore) {
                saveQuizScores() // Save negative quiz score whenever it changes
            }
    }

}

#Preview {
    ContentView()
}

