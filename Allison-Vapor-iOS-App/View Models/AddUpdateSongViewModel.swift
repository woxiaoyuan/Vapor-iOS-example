//
//  AddUpdateSongViewModel.swift
//  Allison-Vapor-iOS-App
//
//  Created by 耶啵的小头盔 on 12/29/22.
//

import Foundation

final class AddUpdateSongViewModel: ObservableObject {
    @Published var songTitle = ""
    
    var songID: UUID?
    
    var isUpdating: Bool {
        songID != nil
    }
    
    var buttonTitle: String {
        songID != nil ? "Updating Song" : "Add Song"
    }
    
    init(){}
    
    init(currentSong: Song) {
        self.songTitle = currentSong.title
        self.songID = currentSong.id
    }
    
    func addSong() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let song = Song(id: nil, title: songTitle)
        
        try await HttpClient.shared.sendData(to: url, object: song, httpMethod: HttpMethod.POST.rawValue)
    }
    
    
    func updateSong() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let songUpdate = Song(id: songID, title: songTitle)
        
        try await HttpClient.shared.sendData(to: url, object: songUpdate, httpMethod: HttpMethod.PUT.rawValue)
        
    }
    
    
    
    func addUpdateAction(completion: @escaping () -> Void) {
        Task {
            do {
                if isUpdating {
                    try await updateSong()
                } else {
                    try await addSong()
                }
                
            } catch {
                print("error ❌ ")
            }
            completion()
        }
    }
}
