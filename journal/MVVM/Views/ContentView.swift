import SwiftUI

enum JournalFilter {
    case entryDate
    case bookmark
}

struct ContentView: View {
    @StateObject private var viewModel = JournalViewModel()
    @AppStorage("hasSeenSplash") private var hasSeenSplash = false
    @State private var showAddSheet = false
    @State private var journalToEdit: Journal?
    @State private var searchText = ""
    @State private var filter: JournalFilter = .entryDate

    private var visibleJournals: [Journal] {
        var result = viewModel.journals

        if filter == .bookmark {
            result = result.filter { $0.isBookmarked }
        }

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }

        return result.sorted { $0.date > $1.date }
    }

    var body: some View {
        if !hasSeenSplash {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        hasSeenSplash = true
                    }
                }
        } else {

            NavigationStack {
                Group {
                    if viewModel.journals.isEmpty {
                        EmptyStateView()
                    } else {
                        JournalListView(
                            journals: visibleJournals,
                            onBookmark: viewModel.toggleBookmark,
                            onDelete: viewModel.delete,
                            onEdit: { journal in
                                journalToEdit = journal
                            }
                        )
                    }
                }
                .searchable(text: $searchText)
                .sheet(item: $journalToEdit) { journal in
                    JournalEditorView(journal: journal) { title, content in
                        viewModel.update(journal, title: title, content: content)
                    }
                }
                .navigationTitle("Journal")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Menu {
                            Button("Sort by Bookmark") {
                                filter = .bookmark
                            }
                            Button("Sort by Entry Date") {
                                filter = .entryDate
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }

                        Button {
                            showAddSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
            .tint(.white)
            .sheet(isPresented: $showAddSheet) {
                JournalEditorView { title, content in
                    viewModel.addJournal(title: title, content: content)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
