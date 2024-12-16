//
//  ArchiveView.swift
//  sport
//
//  Created by pc on 02.10.24.
//

import SwiftUI

struct DoneView: View {

    var onTap: (() -> ())
    
    var body: some View {
        VStack(spacing: 20) {
            Image("cong")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(64)
            
            Text("Training Complete!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text("(You can find it's record in settings tab)")
                .multilineTextAlignment(.center)
                .padding(.bottom)

            Button(action: {
                onTap()
            }) {
                Text("Go Back")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    DoneView(onTap: {})
}
