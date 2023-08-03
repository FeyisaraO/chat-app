//
//  SettingsView.swift
//  chat
//
//  Created by Feyisara Odukoya on 02/08/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct SettingsConfig {
    var showPhotoOptions: Bool = false
    var sourceType: UIImagePickerController.SourceType?
    var selectedImage: UIImage?
    var displayName: String = ""
}

struct SettingsView: View {
    
    @State private var settingsConfig = SettingsConfig()
    @FocusState var isEditing: Bool
    @EnvironmentObject private var model: Model
    @EnvironmentObject private var appState: AppState
    
    @State private var currentPhotoURL: URL? = Auth.auth().currentUser!.photoURL
    
    var displayName: String {
        guard let currentUser = Auth.auth().currentUser else { return "Guest" }
        return currentUser.displayName ?? "Guest"
    }
    
    var body: some View {
        NavigationView{
            VStack{
                AsyncImage(url: currentPhotoURL) { image in
                    image.rounded()
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .rounded()
                }.onTapGesture {
                    settingsConfig.showPhotoOptions = true
                }.confirmationDialog("Settings", isPresented: $settingsConfig.showPhotoOptions) {
                    Button("Camera"){
                        settingsConfig.sourceType = .camera
                    }
                    Button("Photo Library"){
                        settingsConfig.sourceType = .photoLibrary
                    }
                }
                
                TextField(settingsConfig.displayName, text: $settingsConfig.displayName)
                    .textFieldStyle(.roundedBorder)
                    .focused($isEditing)
                    .textInputAutocapitalization(.never)
                
                Spacer()
                
                
                Button("Sign Out"){
                    do{
                        try Auth.auth().signOut()
                        appState.routes.append(.login)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            }
            .sheet(item: $settingsConfig.sourceType, content: { sourceType in
                ImagePicker(image: $settingsConfig.selectedImage, sourceType: sourceType)
            })
            .onChange(of: settingsConfig.selectedImage, perform: { image in
                
                //resize image
                guard let img = image,
                      let resizedImage = img.resize(to: CGSize(width: 100, height: 100)),
                      let imageData = resizedImage.pngData()
                else { return }
                
                //Upload image to firebase storage and get the URL
                Task{
                    guard let currentUser = Auth.auth().currentUser else { return }
                    let fileName = "\(currentUser.uid).png"
                    
                    do{
                        let url = try await Storage.storage().uploadData(for: fileName, data: imageData, bucket: .photos)
                        try await model.updatePhotoURL(for: currentUser, photoURL: url)
                        currentPhotoURL = url
                        
                    } catch {
                        print(error)
                    }
                }
            })
            .padding()
            .onAppear{
                settingsConfig.displayName = displayName
            }
            .toolbar(content:  {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        
                        guard let currentUser = Auth.auth().currentUser else { return }
                        Task {
                            do {
                                try await model.UpdateDisplayName(for: currentUser, displayName: settingsConfig.displayName)
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Model())
            .environmentObject(AppState())
    }
}
