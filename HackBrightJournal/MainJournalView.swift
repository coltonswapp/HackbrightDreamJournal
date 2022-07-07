//
//  MainJournalView.swift
//  HackBrightJournal
//
//  Created by Colton Swapp on 7/5/22.
//

import SwiftUI

struct MainJournalView: View {
    
    @ObservedObject var viewModel = EntryViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                            VStack(alignment: .center, spacing: 10) {
                                Text(String(viewModel.streak))
                                    .font(.title)
                                    .bold()
                                HStack {
                                    Text("Day Streak")
                                        .font(.system(size: 14, weight: .heavy, design: .monospaced))
                                        .foregroundColor(Color(UIColor.secondaryLabel))
                                    Image("streak")
                                        .resizable()
                                        .frame(width: 14, height: 14)
                                }
                            }
                        }.cornerRadius(10)
                        
                        VStack {
                            ZStack {
                                Rectangle().fill(.ultraThinMaterial)
                                VStack(alignment: .center, spacing: 4) {
                                    Text(String(viewModel.entries.count))
                                        .font(.title2)
                                        .bold()
                                    HStack {
                                        Text("Entries")
                                            .font(.system(size: 14, weight: .heavy, design: .monospaced))
                                            .foregroundColor(Color(UIColor.secondaryLabel))
                                        Image("chart")
                                            .resizable()
                                            .frame(width: 14, height: 14)
                                    }
                                }
                            }.cornerRadius(10)
                            ZStack {
                                Rectangle().fill(.ultraThinMaterial)
                                VStack(alignment: .center, spacing: 4) {
                                    Image(viewModel.hasJournaled ? "check-circle" : "x-circle")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text("Today's Dream")
                                        .font(.system(size: 14, weight: .heavy, design: .monospaced))
                                        .foregroundColor(Color(UIColor.secondaryLabel))
                                }
                            }.cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 140)
                    
                    HStack { Text("Entries").font(.title).bold();Image("corner-right-down").resizable().frame(width: 24, height: 24); Spacer() }
                        .padding()
                        .padding(.top)
                    if viewModel.entries.isEmpty{
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                            VStack(alignment: .center, spacing: 10) {
                                Text("You do not have any entries. Tap the + in the upper right-hand corner to create one.")
                                    .font(.system(size: 14, weight: .heavy, design: .monospaced))
                                    .foregroundColor(Color(UIColor.secondaryLabel))
                                    .multilineTextAlignment(.center)
                            }.padding()
                        }.cornerRadius(10)
                            .frame(width: UIScreen.main.bounds.width - 40)
                    } else {
                        List {
                            
                            ForEach(viewModel.entries) { entry in
                                NavigationLink {
                                    DetailView(entryViewModel: viewModel, entry: entry)
                                } label: {
                                    ZStack {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(entry.title)
                                                .font(.headline)
                                                .bold()
                                            Text(entry.body)
                                                .font(.body)
                                                .lineLimit(2)
                                                .truncationMode(.tail)
                                        }
                                        .padding(.vertical)
                                        .padding(.horizontal, 8)
                                    }.frame(maxHeight: 125)
                                }
                            }
                        }.frame(height: CGFloat(viewModel.entries.count) * 125.0)
                            .listStyle(.plain)
                    }
                    
                    Spacer()
                }
                .navigationTitle("Dream Journal")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            DetailView(entryViewModel: viewModel)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .onAppear {
                    viewModel.loadFromPersistentStore()
                    viewModel.getStreak()
                    viewModel.hasJournaledToday()
                }
            }
        }
    }
}

struct MainJournalView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainJournalView()
                .preferredColorScheme(.dark)
        }
    }
}
