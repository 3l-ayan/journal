//
//  CardView.swift
//  journal
//
//  Created by layan alshehri on 04/06/1448 AH.
//

import SwiftUI

struct CardView: View {
    let journal: Journal
    var onBookmark: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(journal.title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Color("TextAccent"))

                Spacer()

                Button(action: onBookmark) {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 24))
                        .foregroundColor(Color("TextAccent"))
                }
                .buttonStyle(.plain)

            }

            Text(journal.date.formatted(date: .numeric, time: .omitted))
                .font(.system(size: 14))
                .foregroundColor(Color("TextSecondary"))

            Text(journal.content)
                .font(.system(size: 18))
                .foregroundColor(Color("TextPrimary"))
                .lineLimit(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(26)
        .background(Color("CardSurface"))
        .cornerRadius(14)
    }

}

#Preview {
    ZStack {
        Color("BackgroundPrimary")
            .ignoresSafeArea()
        CardView(journal: Journal(title: "My Birthday", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."))
            .padding(.horizontal, 21.5)


    }
}
