//
//  ContactViewController.swift
//  ContactList
//
//  Created by Maxorax on 24.06.2021.
//

import UIKit


class ContactViewController: UIViewController {
    
    var contactDataCellArray: [ContactDataCell] = []
    var viewModel: ContactViewModelProtocol! = ContactViewModel()
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        indicator.startAnimating()
        viewModel.contactDataCellArray.bind {
            [weak self] contactDataCellArray in
            
                self?.indicator.stopAnimating()
                self?.contactDataCellArray = contactDataCellArray
                self?.tableView.reloadData()
        }
        self.viewModel.getContacts()
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
    
    @objc func logout() {
        viewModel.signOut()
        dissmisContactViewController(vc: LoginViewController())
    }

}

// MARK: - Table view data source

extension ContactViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDataCellArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "contactCell",
            for: indexPath
        ) as! ContactTableViewCell
        cell.fullNameLabel.text = contactDataCellArray[indexPath.row].name
        cell.phoneNumberLabel.text = contactDataCellArray[indexPath.row].phoneNumber
        guard  let photoData = contactDataCellArray[indexPath.row].photoData else {
            cell.indicator.stopAnimating()
            return cell
        }
        
        cell.photoImageView.image = UIImage(data: photoData)
        cell.indicator.stopAnimating()
        return cell
    }
    
}

//MARK: -Table view delegate

extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contactInfoViewController = ContactInfoViewController()
        contactInfoViewController.name = contactDataCellArray[indexPath.row].name
        contactInfoViewController.email = contactDataCellArray[indexPath.row].email
        contactInfoViewController.phoneNumber = contactDataCellArray[indexPath.row].phoneNumber
        guard let photoData = contactDataCellArray[indexPath.row].photoData else {
            pushViewController(vc: contactInfoViewController)
            return
        }
        
        contactInfoViewController.photoData = photoData
            
        pushViewController(vc: contactInfoViewController)
        
    }
    
}

//MARK: -Routing

extension ContactViewController {
    
    func pushViewController(vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func dissmisContactViewController(vc: UIViewController){
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        appDelegate.window?.rootViewController = vc
    }
    
}
