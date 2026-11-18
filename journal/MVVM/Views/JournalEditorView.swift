//
//  JournalEditorView.swift
//  journal
//
//  Created by layan alshehri on 04/06/1448 AH.
//
import SwiftUI

struct JournalEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var content: String
    @State private var showDiscardDialog = false
    private let initialTitle: String
    private let initialContent: String
    private let date: Date
    let onSave: (String, String) -> Void
    
    init(journal: Journal? = nil, onSave: @escaping (String, String) -> Void) {
        _title = State(initialValue: journal?.title ?? "")
        _content = State(initialValue: journal?.content ?? "")
        initialTitle = journal?.title ?? ""
        initialContent = journal?.content ?? ""
        date = journal?.date ?? Date()
        self.onSave = onSave
    }
    private var hasChanges: Bool {
        title != initialTitle || content != initialContent
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Button {
                    if hasChanges {
                        showDiscardDialog = true
                    } else {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Circle().fill(Color(white: 0.1)))
                }

                Spacer()

                Button {
                    onSave(title, content)
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                        .background(Circle().fill(Color("PrimaryAccent")))
                }
            }

            TextField("", text: $title, prompt: Text("Title").foregroundColor(Color(white: 0.24)))
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(Color("TextPrimary"))

            Text(date.formatted(date: .numeric, time: .omitted))
                .font(.system(size: 16))
                .foregroundColor(Color("TextSecondary"))

            ZStack(alignment: .topLeading) {
                if content.isEmpty {
                    Text("Type your Journal…")
                        .font(.system(size: 20))
                        .foregroundColor(Color(white: 0.31))
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                TextEditor(text: $content)
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextPrimary"))
                    .scrollContentBackground(.hidden)
            }
        }
        .padding(.horizontal, 21)
        .padding(.top, 20)
        .preferredColorScheme(.dark)
        .alert("Are you sure you want to discard changes on this journal?", isPresented: $showDiscardDialog) {
            Button("Discard Changes", role: .destructive) {
                dismiss()
            }
            Button("Keep Editing", role: .cancel) { }
        }
    }
}

#Preview {
    JournalEditorView { _, _ in }
}
