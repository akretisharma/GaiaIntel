//
//  PositiveQuizView.swift
//  GaiaIntel
//
//  Created by Akreti Sharma on 2024-12-30.
//

import SwiftUI

struct PositiveQuizView: View {
    @Binding var quizScore: Double
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var isQuizComplete = false
    
    @Environment(\.dismiss) var dismiss
    
    let questions: [(question: String, options: [String], correctAnswer: Int)] = [
        ("What does AI optimize in buildings?", ["Energy use", "Water consumption", "Air quality"], 0),
        ("How does AI help with disasters?", ["Satellite imagery", "Manual tracking", "News reports"], 0),
        ("What resource does AI monitor to prevent deforestation?", ["Forests", "Rivers", "Mountains"], 0),
        ("What type of energy does AI improve?", ["Renewable", "Nuclear", "Non-renewable"], 0),
        ("What is a positive effect of AI?", ["Predicting weather", "Using fossil fuels", "Mining more resources"], 0)
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
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .navigationTitle("Positive Effects Quiz")
    }
}

#Preview {
    PositiveQuizView(quizScore: .constant(0.0))
}
