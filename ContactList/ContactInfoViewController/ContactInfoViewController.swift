//
//  ContactInfoViewController.swift
//  ContactList
//
//  Created by Maxorax on 25.06.2021.
//

import UIKit

class ContactInfoViewController: UIViewController {
    
    var name: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var photo: UIImageView?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Information"
        nameLabel.text = name
        phoneNumberLabel.text = phoneNumber
        emailLabel.text = email
        guard let image = photo?.image else {return}
        photoImageView.image = image

        // Do any additional setup after loading the view.
    }

}
