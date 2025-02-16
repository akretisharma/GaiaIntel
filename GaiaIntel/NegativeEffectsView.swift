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
                Text("Training large AI models consumes significant amounts of energy, making them resource-intensive and environmentally taxing. AI technologies often depend on rare earth materials, which are challenging to mine sustainably and can have negative ecological impacts. Additionally, the increased reliance on AI can sometimes lead to energy inefficiencies, particularly when systems are not optimized for sustainable use. Moreover, data centers that power AI applications are significant contributors to carbon emissions, further highlighting the environmental challenges associated with AI development and deployment.")
                
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
