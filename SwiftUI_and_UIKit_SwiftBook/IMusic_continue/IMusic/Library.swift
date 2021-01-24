//
//  Library.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 1/1/21.
//  Copyright © 2021 Анас Бен Мустафа. All rights reserved.
//

import SwiftUI
import URLImage

struct Library: View {
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                List {
                    ForEach (tracks) { track in
                        LibraryCell(cell: track).gesture(LongPressGesture().onEnded({ _ in
                            self.track = track
                            self.showingAlert = true
                        }))
                    }.onDelete(perform: delete)
                }.listStyle(PlainListStyle())
            }.actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("Are you sure you want to delete this track?"), buttons: [.destructive(Text("Delete"), action: {
                    self.delete(track: self.track)
                }), .cancel() ])
            })
            .navigationBarTitle("Library")
        }
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myindex = index else { return }
        tracks.remove(at: myindex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
}

struct LibraryCell: View {
    var cell: SearchViewModel.Cell
    var body: some View {
        HStack (spacing: 15) {
            URLImage(url: URL(string: cell.iconUrlString ?? "")!,
                     content: { image in
                        image
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding(.leading, -4)
                            .cornerRadius(3)
                     })
            VStack (alignment: .leading, spacing: 4) {
                Text(cell.trackName)
                    .fontWeight(.medium)
                    .font(.system(size: 18))
                Text(cell.artistName)
                    .fontWeight(.light)
                    .font(.system(size: 15))
                    .padding(.leading, 0)
            }
        }.frame(height: 67)
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
