//
//  NegativeQuizView.swift
//  GaiaIntel
//
//  Created by Akreti Sharma on 2024-12-30.
//

import SwiftUI

struct NegativeQuizView: View {
    @Binding var quizScore: Double
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var isQuizComplete = false
    
    @Environment(\.dismiss) var dismiss
    
    let questions: [(question: String, options: [String], correctAnswer: Int)] = [
        ("What is one drawback of AI?", ["High energy usage", "Low cost", "Improved efficiency"], 0),
        ("What do data centers consume the most?", ["Electricity", "Water", "Land"], 0),
        ("AI relies on what rare resource?", ["Earth materials", "Coal", "Air"], 0),
        ("AI contributes to what type of emissions?", ["Carbon", "Methane", "Oxygen"], 0),
        ("What is a negative impact of AI?", ["Energy consumption", "Predicting disasters", "Monitoring deforestation"], 0)
    ]
    var body: some View {
        VStack {
            if isQuizComplete {
                
                Text("Quiz Complete!")
                    .font(.largeTitle)
                Text("Your score: \(score) / \(questions.count)")
                    .font(.title)
                Button("Finish") {
                    quizScore = Double(score) / Double(questions.count)
                    dismiss()
                }
                .padding()
                .background(Color.green.opacity(0.2))
                .cornerRadius(8)
            } else {
                Text(questions[currentQuestionIndex].question)
                    .font(.headline)
                    .padding()
                
                ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                    Button(questions[currentQuestionIndex].options[index]) {
                        if index == questions[currentQuestionIndex].correctAnswer {
                            score += 1
                        }
                        if currentQuestionIndex < questions.count - 1 {
                            currentQuestionIndex += 1
                        } else {
                            isQuizComplete = true
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .navigationTitle("Negative Effects Quiz")
    }
}

#Preview {
    NegativeQuizView(quizScore: .constant(0.0))
}
