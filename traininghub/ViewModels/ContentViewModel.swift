//
//  ContentViewModel.swift
//  traininghub
//
//  Created by Annika Whitwam on 2024-09-07.
//

import Foundation
import FirebaseAuth

class ContentViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async{
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool{
        print(Auth.auth().currentUser as Any)
        return Auth.auth().currentUser != nil
    }
}
