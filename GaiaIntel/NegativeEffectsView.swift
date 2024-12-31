//
//  NegativeEffectsView.swift
//  GaiaIntel
//
//  Created by Akreti Sharma on 2024-12-30.
//

import SwiftUI

struct NegativeEffectsView: View {
    @Binding var quizScore: Double
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Training large AI models consumes significant energy. \n\rAI technologies often rely on rare earth materials, which are hard to mine sustainably. \n\rIncreased reliance on AI can sometimes lead to energy inefficiencies. \n\rData centers used for AI are a significant contributor to carbon emissions.")
                
                Spacer()
                
                NavigationLink("Take Quiz", destination: NegativeQuizView(quizScore: $quizScore))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)

            }
            .padding()
        }
        .navigationTitle("Negative Effects of AI")
    }
}


#Preview {
    NegativeEffectsView(quizScore: .constant(0.0))
}
