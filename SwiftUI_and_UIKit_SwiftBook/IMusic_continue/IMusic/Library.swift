//
//  Library.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 1/1/21.
//  Copyright © 2021 Алексей Пархоменко. All rights reserved.
//

import SwiftUI
import URLImage

struct Library: View {
    var tracks = UserDefaults.standard.savedTracks()
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                GeometryReader { geometry in
                    HStack (spacing: 20) {
                        Button(action: {
                            print("12345")
                        }, label: {
                            Image(systemName: "play.fill")
                                .frame(width: abs(geometry.size.width / 2 - 10), height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.9728454947, green: 0.9389790297, blue: 0.9806990027, alpha: 1)))
                                .cornerRadius(10.0)
                        })
                        Button(action: {
                            print("54321")
                        }, label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: abs(geometry.size.width / 2 - 10), height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.9728454947, green: 0.9389790297, blue: 0.9806990027, alpha: 1)))
                                .cornerRadius(10.0)
                        })
                    }
                }.padding().frame(height: 50)
                Divider().padding(.top, 25).padding(.leading).padding(.trailing)
                
                List (tracks) { track in
                    LibraryCell(cell: track)
                }.listStyle(PlainListStyle())
            }
            
            .navigationBarTitle("Library")
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
