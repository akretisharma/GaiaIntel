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
                Text("AI plays a crucial role in promoting sustainability and addressing environmental challenges. It optimizes energy usage in buildings and homes, improving efficiency and reducing waste. AI enhances the management of renewable energy grids, ensuring their operations are more effective and reliable. Additionally, AI helps predict natural disasters, enabling better planning and response strategies to minimize their impact. It also monitors deforestation through satellite imagery, helping to detect and reduce illegal activities, and supports conservation efforts. These advancements demonstrate how AI can contribute to a more sustainable and resilient future.")
                
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
