import UIKit

final class ContactViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    private var contactDataCellArray: [ContactDataCell] = []
    var viewModel: ContactViewModelProtocol!
    
    init(_ viewModel: ContactViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        viewModel.openLoginController()
    }

}

// MARK: - Table view data source

extension ContactViewController: UITableViewDataSource {
    
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
        viewModel.openSelectedCells(contactDataCell: contactDataCellArray[indexPath.row])
    }
    
}


