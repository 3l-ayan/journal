//
//  JournalListView.swift
//  journal
//
//  Created by layan alshehri on 04/06/1448 AH.
//

import SwiftUI

struct JournalListView: View {
    let journals: [Journal]
    let onBookmark: (Journal) -> Void
    let onDelete: (Journal) -> Void
    let onEdit: (Journal) -> Void

    @State private var journalToDelete: Journal?
    @State private var showDeleteAlert = false

    var body: some View {
        List {
            ForEach(journals) { journal in
                CardView(journal: journal) {
                    onBookmark(journal)
                }
                .onTapGesture {
                    onEdit(journal)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 8, leading: 21.5, bottom: 8, trailing: 21.5))
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {

                    Button {
                        journalToDelete = journal
                        showDeleteAlert = true
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    .tint(Color("SemanticDestructive"))
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color("BackgroundPrimary"))
        .alert("Delete Journal?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {
                journalToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let journal = journalToDelete {
                    onDelete(journal)
                }
                journalToDelete = nil
            }
        } message: {
            Text("Are you sure you want to delete this journal?")
        }
    }
}

#Preview {
    JournalListView(
        journals: [
            Journal(title: "Sample one", content: "Sample text for testing."),
            Journal(title: "Sample two", content: "Another sample text.", isBookmarked: true)
        ],
        onBookmark: { _ in },
        onDelete: { _ in },
        onEdit: { _ in }
    )
}
