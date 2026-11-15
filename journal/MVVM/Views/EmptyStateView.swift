//
//  EmptyStateView.swift
//  journal
//
//  Created by layan alshehri on 04/06/1448 AH.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image("emptyStateBook")
                .resizable()
                .scaledToFit()
                .frame(width: 151)
                .padding(.bottom, 13)

            Text("Begin Your Journal")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("TextAccent"))

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size: 18, weight: .light))
                .foregroundColor(Color("TextPrimary"))
                .multilineTextAlignment(.center)
                .frame(width: 282)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundPrimary").ignoresSafeArea())
    }
}

#Preview {
    EmptyStateView()
}
