//
//  ContactViewController.swift
//  ContactList
//
//  Created by Maxorax on 24.06.2021.
//

import UIKit
import GoogleSignIn
import Alamofire

class ContactViewController: UITableViewController {
    
    var peoples: [People] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContacts()
        self.navigationItem.title = "Contact list"
        let logoutButtonItem =  UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.leftBarButtonItem = logoutButtonItem
        let contactCell = UINib(nibName: "ContactTableViewCell", bundle: nil)
        self.tableView.register(contactCell, forCellReuseIdentifier: "contactCell")
    }
    
    func getContacts() {
        guard let accessToken = GIDSignIn.sharedInstance()?.currentUser.authentication.accessToken  else {
            return
        }
        
        let urlString = "https://people.googleapis.com/v1/people:listDirectoryPeople?mergeSources=DIRECTORY_MERGE_SOURCE_TYPE_CONTACT&sources=DIRECTORY_SOURCE_TYPE_DOMAIN_CONTACT&sources=DIRECTORY_SOURCE_TYPE_DOMAIN_PROFILE&readMask=names,emailAddresses,phoneNumbers,photos&pageSize=1000&access_token=\(accessToken)"
        
        AF.request(urlString , method: .get)
                .responseJSON { (response) in
                    guard let data = response.data else {return}
                    do{
                        let peoples = try JSONDecoder().decode(Peoples.self, from:data)
                        self.peoples = peoples.people
                        guard self.peoples.count > 0 else {
                            return
                        }
                        self.tableView.reloadData()
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
    }
    
     
    @objc func logout(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        GIDSignIn.sharedInstance().signOut()
        appDelegate.window?.rootViewController = RegisterLoginViewController()
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        cell.fullNameLabel.text = peoples[indexPath.row].names[0].displayName
        cell.phoneNumberLabel.text =  peoples[indexPath.row].phoneNumbers?[0] != nil
            ? peoples[indexPath.row].phoneNumbers?[0].value
            : "No number"
        guard let photosUrl = peoples[indexPath.row].photos?[0].url  else {
            return cell
        }
        AF.request(photosUrl, method: .get).response{
            response in
            guard let data = response.data else {
                return
            }
            DispatchQueue.main.async {
                cell.photoImageView.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ContactTableViewCell
        
        let contactInfoViewController = ContactInfoViewController()
        contactInfoViewController.email = "Email: \(peoples[indexPath.row].emailAddresses[0].value)"
        contactInfoViewController.phoneNumber = "Phone number: \(cell.phoneNumberLabel.text ?? "no number")"
        contactInfoViewController.photo = cell.photoImageView
        contactInfoViewController.name = "Full name: \(cell.fullNameLabel.text ?? "")"
        
        self.navigationController?.pushViewController(contactInfoViewController, animated: true)
    }

}
