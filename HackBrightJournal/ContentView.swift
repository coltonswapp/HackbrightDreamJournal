//
//  ContentView.swift
//  HackBrightJournal
//
//  Created by Colton Swapp on 7/5/22.
//

import SwiftUI

struct ContentView: View {
    @State var profileImageSize = "Small"
    @State var notifyMeAbout = "Messages"
    @State var playNotificationSounds = true
    @State var sendReadReceipts = true
    var body: some View {
        
        VStack {
            Form {
                Section(header: Text("Notifications")) {
                    Picker("Notify Me About", selection: $notifyMeAbout) {
                        Text("Direct Messages").tag(5)
                        Text("Mentions").tag(6)
                        Text("Anything").tag(7)
                    }
                    Toggle("Play notification sounds", isOn: $playNotificationSounds)
                    Toggle("Send read receipts", isOn: $sendReadReceipts)
                }
                Section(header: Text("User Profiles")) {
                    Picker("Profile Image Size", selection: $profileImageSize) {
                        Text("Large").tag(0)
                        Text("Medium").tag(1)
                        Text("Small").tag(2)
                    }
                    Button("Clear Image Cache") {}
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
