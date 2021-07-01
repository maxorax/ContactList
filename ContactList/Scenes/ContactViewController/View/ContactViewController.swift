//
//  ContactViewController.swift
//  ContactList
//
//  Created by Maxorax on 24.06.2021.
//

import UIKit
import GoogleSignIn
import Alamofire

class ContactViewController: UIViewController {
    
    var peoples: [People] = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getContacts()
        self.navigationItem.title = "Contact list"
        let logoutButtonItem =  UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logout)
        )
        self.navigationItem.leftBarButtonItem = logoutButtonItem
        let contactCell = UINib(nibName: "ContactTableViewCell", bundle: nil)
        self.tableView.register(
            contactCell,
            forCellReuseIdentifier: "contactCell"
        )
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func getContacts() {
        guard
            let accessToken = GIDSignIn.sharedInstance()?.currentUser.authentication.accessToken
        else { return }
        
        let urlString = Constants.urlAPI + accessToken
        AF.request(urlString , method: .get)
            .responseJSON { (response) in
                guard let data = response.data else {return}
                    
                do{
                    let peoples = try JSONDecoder().decode(
                        Peoples.self,
                        from:data
                    )
                    self.peoples = peoples.people
                    guard self.peoples.count > 0 else { return }
                    
                    self.tableView.reloadData()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
    }
    
    @objc func logout() {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        GIDSignIn.sharedInstance().signOut()
        appDelegate.window?.rootViewController = RegisterLoginViewController()
    }

}

// MARK: - Table view data source

extension ContactViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "contactCell",
            for: indexPath
        ) as! ContactTableViewCell
        cell.fullNameLabel.text = peoples[indexPath.row].names[0].displayName
        cell.phoneNumberLabel.text =
            peoples[indexPath.row].phoneNumbers?[0] != nil
            ? peoples[indexPath.row].phoneNumbers?[0].value
            : "No number"
        guard
            let photoUrl = peoples[indexPath.row].photos?[0].url
        else {
            cell.indicator.stopAnimating()
            return cell
        }
        
        AF.request(photoUrl, method: .get).response{
            response in
            
            guard let data = response.data else { return }
           
            DispatchQueue.main.async {
                let cell = tableView.cellForRow(at: indexPath) as? ContactTableViewCell
                cell?.photoImageView.image = UIImage(data: data)
                cell?.indicator.stopAnimating()
            }
    
        }
        return cell
    }
    
}

//MARK: -Table view delegate

extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ContactTableViewCell
        
        let contactInfoViewController = ContactInfoViewController()
        contactInfoViewController.email = "Email: \(peoples[indexPath.row].emailAddresses[0].value)"
        contactInfoViewController.phoneNumber = "Phone number: \(cell.phoneNumberLabel.text ?? "no number")"
        contactInfoViewController.photo = cell.photoImageView
        contactInfoViewController.name = "Full name: \(cell.fullNameLabel.text ?? "")"
        
        self.navigationController?.pushViewController(contactInfoViewController, animated: true)
    }
    
}
