//
//  ContentView.swift
//  Allison-Vapor-iOS-App
//
//  Created by 耶啵的小头盔 on 12/29/22.
//

import SwiftUI

struct SongList: View {
    
    @StateObject var viewModel = SongListViewModel()
    
    @State var model: ModelType? = nil
    
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.songs) {
                    song in
                    Button {
                        model = .update(song)
                    } label: {
                        Text(song.title)
                            .font(.title3)
                            .foregroundColor(Color(.label))
                    }
                }.onDelete(perform: viewModel.delete)
            }
            .navigationTitle(Text("🎵 Song"))
            .toolbar {
                Button {
                    model = .add
                } label: {
                    Label("Add Song",systemImage: "plus.circle")
                }
            }
        }
        .sheet (item: $model, onDismiss: {
            Task {
                do {
                    try await viewModel.fetchSongs()
                } catch {
                    print("error ❌ ")
                }
            }
        }) {
            model in
            switch model {
            case .add:
                AddUpdateSong(viewModel: AddUpdateSongViewModel())
            case .update(let song):
                AddUpdateSong(viewModel: AddUpdateSongViewModel(currentSong: song))
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchSongs()
                } catch {
                    print("❌ error! ")
                }
                
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SongList()
    }
}
