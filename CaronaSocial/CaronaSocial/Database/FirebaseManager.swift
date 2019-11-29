//
//  FirebaseManager.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 11/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import KeychainSwift
import Firebase
import FirebaseDatabase


class FirebaseManager {
    

    private var authUser : User? {
        return Auth.auth().currentUser
    }

    private var _keyChain = KeychainSwift()

    var keyChain: KeychainSwift {
        get {
            return _keyChain
        } set {
            _keyChain = newValue
        }
    }

    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                self.sendVerificationMail()
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }

    func completeSignIn(id: String) {
        keyChain.set(id, forKey: "uid")
    }

    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                // Notify the user that the mail has sent or couldn't because of an error.
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
        }
    }

    func handleError(_ error: Error) -> UIAlertController{
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return alert
        }
        return UIAlertController()
    }
    
    static func downloadImage(withURL url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        // Downloading image from database
        print(url)
        let dataTask = URLSession.shared.dataTask(with: url) { data, url, error in
            var downloadedImage: UIImage?
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
        dataTask.resume()
    }
    
    static func downloadImages(drivers: [DriverModel], completion: @escaping ([UIImage]) -> Void){
        // Downloading image from database
        var images: [UIImage] = []
        let group = DispatchGroup()

        
        for driver in drivers{
            print(driver.profileImageURL)
            group.enter()
            FirebaseManager.self.downloadImage(withURL: URL(string: driver.profileImageURL)!){ result in
                if (result != nil){
                    images.append(result!)
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            print(images)
            completion(images)
        }
    }
    
    
    @objc static func uploadProfileImage(imageView: UIImageView) {
        
        guard  let image = imageView.image, let data = image.jpegData(compressionQuality: 0.75) else {
            // TODO: Present an alert on view controller
            return
        }
        
        let imageName =  UUID().uuidString // Random String
        let imageReference = Storage.storage().reference()
            .child("driversProfilePhoto")
            .child(imageName)
        
        imageReference.putData(data, metadata: nil) { (metada, err) in
            if let err = err {
                // TODO: Present an alert on view controller
                print(err.localizedDescription)
                return
            }
             
        imageReference.downloadURL(completion: { (url, err) in
            if let err = err {
                // TODO: Present an alert on view controller
                print(err.localizedDescription)
                return
            }
            
            guard let url = url else {
                print("URL error")
                return
            }
            
            // TODO: Get userID based com logged profile and insert in document
            let dataReference = Firestore.firestore().collection("driver").document("userID")
            let documentUID = dataReference.documentID
            let urlString = url.absoluteString
            
            let data = [
                "uid": documentUID,
                "profileImageURL": urlString
                ] as [String : Any]
            
            dataReference.updateData(data, completion: { (err) in
                if let err = err {
                    // TODO: Present an aler on view controller
                    print(err.localizedDescription)
                    return
                }
                print("Image has been successfully saved into Firebase")
            })
        })
            
        }
    }

}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
        default:
            return "Unknown error occurred"
        }
    }
}
