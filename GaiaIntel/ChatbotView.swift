//
//  ChatbotView.swift
//  GaiaIntel
//
//  Created by Akreti Sharma on 2025-02-16.
//

import SwiftUI

struct ChatbotView: View {
    @State private var userInput = ""
    @State private var chatMessages: [(String, Bool)] = [] // (Message, isUser)
    @State private var isLoading = false
    

    var body: some View {
        VStack {
            Text("Gaiaintel Chatbot")
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.green.opacity(0.5))
                .padding(.top)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(chatMessages, id: \.0) { message, isUser in
                        HStack {
                            if isUser {
                                Spacer()
                                Text(message)
                                    .padding()
                                    .background(Color.green.opacity(0.8))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            } else {
                                Text(message)
                                    .padding()
                                    .background(Color.brown.opacity(0.2))
                                    .cornerRadius(10)
                                Spacer()
                            }
                        }
                    }
                    
                }
            }
            .padding()
            Spacer()
            HStack {
                TextField("Ask about AI & climate change...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(Circle())
                }
                .disabled(userInput.isEmpty || isLoading)
            }
            .padding()
        }
        
        .navigationTitle("AI Climate Chatbot")
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    

    func sendMessage() {
        let message = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !message.isEmpty else { return }

        chatMessages.append((message, true)) // Add user message
        userInput = ""
        isLoading = true

        let geminiAPIKey = ""
        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\(geminiAPIKey)")!

        let requestBody: [String: Any] = [
            "contents": [
                ["parts": [["text": message]]]
            ]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false
                guard let data = data, error == nil else {
                    chatMessages.append(("Error fetching response", false))
                    return
                }
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let candidates = json["candidates"] as? [[String: Any]],
                   let content = candidates.first?["content"] as? [String: Any],
                   let parts = content["parts"] as? [[String: Any]],
                   let text = parts.first?["text"] as? String {
                    chatMessages.append((text, false))
                } else {
                    chatMessages.append(("Couldn't fetch response", false))
                }
            }
        }.resume()
    }
}


#Preview {
    ChatbotView()
}
