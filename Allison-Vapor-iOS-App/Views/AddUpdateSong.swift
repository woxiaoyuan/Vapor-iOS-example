//
//  AddUpdateSong.swift
//  Allison-Vapor-iOS-App
//
//  Created by 耶啵的小头盔 on 12/29/22.
//

import SwiftUI

struct AddUpdateSong: View {
    @ObservedObject var viewModel: AddUpdateSongViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("song title", text: $viewModel.songTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            Button {
                viewModel.addUpdateAction {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonTitle)
            }
        }
    }
}

struct AddUpdateSong_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateSong(viewModel: AddUpdateSongViewModel())
    }
}
