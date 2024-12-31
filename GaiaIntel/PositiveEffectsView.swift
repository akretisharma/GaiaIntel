//
//  PositiveEffectsView.swift
//  GaiaIntel
//
//  Created by Akreti Sharma on 2024-12-30.
//

import SwiftUI

struct PositiveEffectsView: View {
    @Binding var quizScore: Double
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("AI optimizes energy usage in buildings and homes.\n\rAI helps predict natural disasters and enables better planning.\n\rAI monitors and reduces deforestation with satellite imagery.\n\rAI improves the efficiency of renewable energy grids.")
                
                Spacer()
                
                NavigationLink("Take Quiz", destination: PositiveQuizView(quizScore: $quizScore))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Positive Effects of AI")
    }
}

#Preview {
    PositiveEffectsView(quizScore: .constant(0.0))
}
