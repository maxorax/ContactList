import UIKit

class ContactInfoViewController: UIViewController {
    
    var viewModel: ContactInfoViewModelProtocol!
    
    init(_ viewModel: ContactInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.name.bind {
            [weak self] name in
            self?.nameLabel.text = "Full name: \(name)"
        }
        viewModel.phoneNumber.bind {
            [weak self] phoneNumber in
            self?.phoneNumberLabel.text = "Phone number: \(phoneNumber)"
        }
        viewModel.email.bind {
            [weak self] email in
            self?.emailLabel.text = "Email: \(email)"
        }
        viewModel.photoData.bind {
            [weak self] photoData in
            self?.photoImageView.image = UIImage(data: photoData)
        }
        
        navigationItem.title = "Information"
        viewModel.getContact()
    }

}
