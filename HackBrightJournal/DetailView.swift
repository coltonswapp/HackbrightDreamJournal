//
//  DetailView.swift
//  HackBrightJournal
//
//  Created by Colton Swapp on 7/5/22.
//

import SwiftUI

struct DetailView: View {
    
    // ViewModel
    @ObservedObject var entryViewModel: EntryViewModel
    
    // State variables
    @State private var entryTitle: String = ""
    @State private var bodyText: String = "Record your hopes and dreams down here..."
    
    // Environment variables
    @Environment(\.dismiss) var dismiss
    
    // Landing Pad
    var entry: Entry?
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Dream Title")
                    .font(.system(size: 18, weight: .heavy, design: .monospaced))
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                TextField("Title here...", text: $entryTitle)
            }
            Divider()
            HStack {
                Rectangle().fill(.secondary).frame(width: 2, height: 400)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Dream Details")
                            .font(.system(size: 18, weight: .heavy, design: .monospaced))
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                        Spacer()
                        Button {
                            bodyText = ""
                        } label: {
                            Image(systemName: "x.circle.fill")
                        }
                    }
                    TextEditor(text: $bodyText)
                }
            }
            Spacer()
            VStack(spacing: 4) {
                HStack(spacing: 0) {
                    Text("Created on ")
                    Text(Date.now, format: .dateTime.day().month().year())
                }.font(.caption)
                    .foregroundColor(.secondary)
                Button {
                    if prepareForCreateUpdateEntry(entry: entry, title: entryTitle, body: bodyText) {
                        dismiss()
                    }
                } label: {
                    ZStack {
                        Rectangle().fill(.ultraThinMaterial)
                            .cornerRadius(12)
                        Text(entry != nil ? "Update" : "Save")
                            .font(.system(size: 18, weight: .heavy, design: .monospaced))
                    }
                    
                }.frame(width: UIScreen.main.bounds.width - 40, height: 55)
            }
        }
        .padding()
        #if DEBUG
        .navigationTitle("Debug Dream")
        #endif
        .navigationTitle("New Dream")
        .onAppear {
            displayEntry(entry: entry)
        }
    }
    
    func displayEntry(entry: Entry?) {
        if let entry = entry {
            self.entryTitle = entry.title
            self.bodyText = entry.body
        }
    }
    
    func prepareForCreateUpdateEntry(entry: Entry?, title: String?, body: String?) -> Bool {
        guard let title = title, !title.isEmpty,
              let body = body, !body.isEmpty else { return false }
        if let entry = entry {
            // update
            entryViewModel.update(entry: entry, title: title, body: body)
            return true
        }
        entryViewModel.createEntry(Entry(title: title, body: body))
        return true
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(entryViewModel: EntryViewModel())
        }
    }
}
