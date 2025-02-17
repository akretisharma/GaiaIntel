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
    
    @State private var searchQuery: String = ""
    
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
    
    var filteredToDoItems: [ToDoItem] {
            if searchQuery.isEmpty {
                return toDoItems
            } else {
                return toDoItems.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
            }
        }
    
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
    
    @State private var articles = [Article]()
    let categories = ["Climate", "Environment", "AI", "Science", "Energy"]
    @State private var selectedCategory = "Climate"  // Category for news
    
    private func loadArticles() {
        let apiKey = ""  // Replace with your New York Times API key
        /*lGrAFoGjchKBm9n95RubpywpDmKB5L5A*/
        
        let searchQuery = selectedCategory  // Use the selected category as the search query
        let urlString = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=\(searchQuery)&api-key=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            session.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(NYTimesSearchResponse.self, from: data)
                        DispatchQueue.main.async {
                            // Limit the articles to the first 10
                            self.articles = Array(response.response.docs.prefix(10)).map { article in
                                Article(name: article.headline.main,
                                        author: article.byline?.original ?? "Unknown",
                                        image: article.multimedia?.first?.url ?? "default_image",
                                        desc: article.abstract ?? "No description",
                                        link: article.web_url)
                            }
                        }
                    } catch {
                        print("Error decoding articles: \(error)")
                    }
                }
            }.resume()
        }
    }
    
    
    struct NYTimesSearchResponse: Codable {
        let response: NYTimesSearchResults
    }
    
    struct NYTimesSearchResults: Codable {
        let docs: [ArticleDoc]
    }
    
    struct ArticleDoc: Codable {
        let headline: Headline
        let byline: Byline?
        let multimedia: [Multimedia]?
        let abstract: String?
        let web_url: String
    }
    
    struct Headline: Codable {
        let main: String
    }
    
    struct Byline: Codable {
        let original: String?
    }
    
    struct Multimedia: Codable {
        let url: String
    }
    
    struct Article: Identifiable {
        var id = UUID()
        var name: String
        var author: String
        var image: String
        var desc: String
        var link: String
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
                                .padding(.top, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            
                            
                            // Scrollable Button Bar
                            Text("Select News Category")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                        // Related Articles Section
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(categories, id: \.self) { category in
                                    Button(action: {
                                        selectedCategory = category
                                        loadArticles()  // Load articles for selected category
                                    }) {
                                        Text(category)
                                            .font(.body)
                                            .fontWeight(.medium)
                                            .padding()
                                            .background(selectedCategory == category ? Color.green.opacity(0.8) : Color.brown.opacity(0.2))
                                            .cornerRadius(15)
                                            .foregroundColor(selectedCategory == category ? .white : .black)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical)
                        }
                        
                        VStack(spacing: 20) {
                            ForEach(articles) { article in
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(article.name)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary) // Text color depending on theme
                                        .lineLimit(2) // Prevents long titles from spilling
                                        .truncationMode(.tail) // Truncate long titles with ellipsis
                                    
                                    Text(article.author)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary) // Lighter color for author
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    
                                    Text(article.desc)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                        .lineLimit(3) // Limits description lines to make it compact
                                        .truncationMode(.tail) // Truncates overflowing text with ellipsis
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Link("Read more", destination: URL(string: article.link)!)
                                        .font(.body)
                                        .foregroundColor(.brown)
                                        .padding(.top, 5) // Space between text and the link
                                        .underline() // Adds an underline to the link
                                }
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(12) // Rounded corners
                                .padding(.horizontal)
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                }
            }
            .tabItem {
                Label("Learn", systemImage: "lightbulb.fill")}
            .tag(2)
            
            NavigationStack() {
                VStack {
                    TextField("Search tasks...", text: $searchQuery)
                                        .padding()
                                        .background(Color.brown.opacity(0.1))
                                        .cornerRadius(8)
                                        .padding(.bottom, 10)
                                        .font(.body)
                                        .textInputAutocapitalization(.never)
                                        .disableAutocorrection(true)
                    
                    List {
                                        ForEach(filteredToDoItems) { item in
                                            HStack {
                                                Button(action: {
                                                    if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
                                                        withAnimation(.easeInOut(duration: 0.3)) {
                                                            toDoItems[index].isChecked.toggle() // Toggle the checkbox status
                                                            saveToDoItems() // Save updated data
                                                        }
                                                    }
                                                }) {
                                                    Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                                                        .foregroundColor(item.isChecked ? .green : .brown)
                                                        .transition(.scale) // Add scale transition for the checkmark
                                                }
                                                
                                                Text(item.name)
                                                    .strikethrough(item.isChecked, color: .brown)
                                                    .opacity(item.isChecked ? 0.5 : 1.0)  // Fade out when completed
                                                    .animation(.easeInOut(duration: 0.3), value: item.isChecked)
                                            }
                                            .padding(.vertical, 5)
                                            .background(item.isChecked ? Color.green.opacity(0.2) : Color.clear)
                                            .cornerRadius(8)
                                            .transition(.move(edge: .top))  // Smooth transition when item is checked or unchecked
                                        }
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

