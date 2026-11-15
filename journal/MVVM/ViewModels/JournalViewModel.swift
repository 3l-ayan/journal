//
//  JournalViewModel.swift
//  journal
//
//  Created by layan alshehri on 04/06/1448 AH.
//
import SwiftUI
import Combine

final class JournalViewModel: ObservableObject {
    @Published var journals: [Journal] = [] {
        didSet { save() }
    }

    private let saveKey = "savedJournals"

    init() {
        load()
    }

    func addJournal(title: String, content: String) {
        let journal = Journal(title: title, content: content)
        journals.insert(journal, at: 0)
    }

    func toggleBookmark(_ journal: Journal) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            journals[index].isBookmarked.toggle()
        }
    }
    func update(_ journal: Journal, title: String, content: String) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            journals[index].title = title
            journals[index].content = content
        }
    }

    func delete(_ journal: Journal) {
        journals.removeAll { $0.id == journal.id }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(journals) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let saved = try? JSONDecoder().decode([Journal].self, from: data) {
            journals = saved
        }
    }
}
