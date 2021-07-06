//
//  File.swift
//  ContactList
//
//  Created by Maxorax on 01.07.2021.
//

import Foundation
import Alamofire


struct ContactViewModel: ContactViewModelProtocol {
    
    var contactDataCellArray: Dynamic<[ContactDataCell]>!
    
    let gIDSignInManager: GIDSignInManager = GIDSignInManager.shared
    let networkManager: NetworkManager = NetworkManager()
    
    init() {
        self.contactDataCellArray = Dynamic([])
        getContacts()
    }
    
    func signOut() {
        gIDSignInManager.signOut()
        
    }
    
    func getContacts() {
        guard
            let accessToken = gIDSignInManager.getAccessToken()
        else { return }

        let urlString = Constants.urlAPI + accessToken
        AF.request(urlString, method: .get).responseJSON{ (response) in
            guard let data = response.data else {return}
            
            do{
                let peoples = try JSONDecoder().decode(Peoples.self, from: data)
                for index in 0..<peoples.people.count{

                    contactDataCellArray.value.append(ContactDataCell(
                                                        name: "",
                                                        photoData: nil,
                                                        email: "",
                                                        phoneNumber: ""
                    ))

                    self.contactDataCellArray.value[index].name =
                        peoples.people[index].names[0].displayName

                    self.contactDataCellArray.value[index].email =
                      peoples.people[index].emailAddresses[0].value
                    self.contactDataCellArray.value[index].phoneNumber =
                        peoples.people[index].phoneNumbers?[0].value ??
                        "No number"
                    if let photoUrl = peoples.people[index].photos?[0].url {
                        AF.request(photoUrl, method: .get).response{
                            response in
                            guard let data = response.data else { return }
                                
                            self.contactDataCellArray.value[index].photoData = data
                        }
                    }

                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
        
}
