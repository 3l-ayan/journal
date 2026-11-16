import Foundation
import Combine

// نوع الترتيب: بالتاريخ أو بالبوك مارك
enum JournalFilter {
    case entryDate
    case bookmark
}

final class JournalViewModel: ObservableObject {
    @Published var journals: [Journal] = [] {
        didSet { save() }
    }
    @Published var searchText = ""                    // الكلمة اللي في خانة البحث
    @Published var filter: JournalFilter = .entryDate // الترتيب الحالي

    private let saveKey = "savedJournals"

    init() {
        load()
    }

    // القائمة اللي تنعرض للمستخدم (بعد البحث والترتيب)
    var visibleJournals: [Journal] {
        var result = journals

        // 1) البحث
        if !searchText.isEmpty {
            result = result.filter { journal in
                journal.title.localizedCaseInsensitiveContains(searchText) ||
                journal.content.localizedCaseInsensitiveContains(searchText)
            }
        }

        // 2) الترتيب
        switch filter {
        case .bookmark:
            // اللي عليها بوك مارك فوق، والباقي تحتها
            result.sort { first, second in
                if first.isBookmarked != second.isBookmarked {
                    return first.isBookmarked
                }
                return first.date > second.date
            }
        case .entryDate:
            // الأحدث أول
            result.sort { first, second in
                first.date > second.date
            }
        }

        return result
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

