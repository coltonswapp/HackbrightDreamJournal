//
//  EntryViewModel.swift
//  HackBrightJournal
//
//  Created by Colton Swapp on 7/6/22.
//

import Foundation

struct Entry: Identifiable, Codable, Equatable {
    
    var id: String = UUID().uuidString
    var title: String
    var body: String
    var date: Date = Date()
    
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        lhs.id == rhs.id
    }
}

class EntryViewModel: ObservableObject {
    
    @Published var entries: [Entry] = []
    @Published var streak: Int = 0
    @Published var hasJournaled = false
    
    func getStreak() {
        var localStreak: Int = 0
        var previousEntry: Entry?
        for entry in entries {
            guard let previousEntryDate = previousEntry?.date else {
                localStreak += 1
                previousEntry = entry
                continue
            }
            let diffComponents = Calendar.current.dateComponents([.hour], from: previousEntryDate, to: entry.date)
            let hours = diffComponents.hour
            if let hours = hours, hours <= 48, hours >= 24 {
                print(hours)
                localStreak += 1
            } else {
                self.streak = localStreak
            }
            previousEntry = entry
        }
        self.streak = localStreak
    }
    
    func hasJournaledToday(){
        let now = Date()
        for entry in entries.reversed() {
            let diffComponents = Calendar.current.dateComponents([.hour], from: now, to: entry.date)
            let hours = diffComponents.hour
            if let hours = hours, hours <= 24 {
                hasJournaled = true
            }
            return
        }
        hasJournaled = false
    }
    
    func createEntry(_ entry: Entry) {
      entries.append(entry)
      saveToPersistentStore()
    }
    
    func update(entry: Entry, title: String, body: String) {
      guard let index = entries.firstIndex(of: entry) else { return }

      entries[index].title = title
      entries[index].body = body
      saveToPersistentStore()
    }
    
    // MARK: - Persistent Storage
    
    func createPersistenceStore() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filename = "Entries.json"
        let fileURL = documentDirectory.appendingPathComponent(filename)
        return fileURL
    }
    
    func saveToPersistentStore() {
        do {
            let data = try JSONEncoder().encode(entries)
            print(data)
            print(String(data: data, encoding: .utf8)!)
            try data.write(to: createPersistenceStore())
            
        } catch let error {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            self.entries = try JSONDecoder().decode([Entry].self, from: data)
            
        } catch {
            print("Error loading data drom disk \(error)")
        }
    }
}
