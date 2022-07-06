//
//  MainJournalView.swift
//  HackBrightJournal
//
//  Created by Colton Swapp on 7/5/22.
//

import SwiftUI

struct MainJournalView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                            VStack(alignment: .center, spacing: 10) {
                                Text("2")
                                    .font(.title)
                                    .bold()
                                
                                Text("Day Streak")
                                    .font(.system(size: 14, weight: .heavy, design: .monospaced))
                                    .foregroundColor(Color(UIColor.secondaryLabel))
                            }
                        }.cornerRadius(10)
                        
                        VStack {
                            ZStack {
                                Rectangle().fill(.ultraThinMaterial)
                                VStack(alignment: .center, spacing: 4) {
                                    Text("4")
                                        .font(.title2)
                                        .bold()
                                    Text("Entries")
                                        .font(.system(size: 14, weight: .heavy, design: .monospaced))
                                        .foregroundColor(Color(UIColor.secondaryLabel))
                                }
                            }.cornerRadius(10)
                            ZStack {
                                Rectangle().fill(.ultraThinMaterial)
                                VStack(alignment: .center, spacing: 4) {
                                    Text("4 / 7")
                                        .font(.title2)
                                        .bold()
                                    Text("This week")
                                        .font(.system(size: 14, weight: .heavy, design: .monospaced))
                                        .foregroundColor(Color(UIColor.secondaryLabel))
                                }
                            }.cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 140)
                    
                    HStack { Text("Entries").font(.title).bold(); Spacer() }
                        .padding()
                        .padding(.top)
                    
                    List {
                        ZStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("This is my title")
                                    .font(.headline)
                                    .bold()
                                Text("& this is the body of my entry that I am testing, & this is the body of my entry that I am testing, & this is the body of my entry that I am testing")
                                    .font(.body)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 8)
                        }.frame(maxHeight: 125)
                        
                        ZStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("This is my title")
                                    .font(.headline)
                                    .bold()
                                Text("& this is the body of my entry that I am testing, & this is the body of my entry that I am testing, & this is the body of my entry that I am testing")
                                    .font(.body)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 8)
                        }.frame(maxHeight: 125)
                        
                        ZStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("This is my title")
                                    .font(.headline)
                                    .bold()
                                Text("& this is the body of my entry that I am testing, & this is the body of my entry that I am testing, & this is the body of my entry that I am testing")
                                    .font(.body)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 8)
                        }.frame(maxHeight: 125)
                        
                        ZStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("This is my title")
                                    .font(.headline)
                                    .bold()
                                Text("& this is the body of my entry that I am testing, & this is the body of my entry that I am testing, & this is the body of my entry that I am testing")
                                    .font(.body)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 8)
                        }.frame(maxHeight: 125)
                    }.frame(height: 500)
                        .listStyle(.plain)
                    
                    Spacer()
                }
                .navigationTitle("Dream Journal")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            DetailView()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
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
