import UIKit

class ContactInfoViewController: UIViewController {
    
    var name: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var photoData: Data?
    
    var contactInfoViewModel: ContactInfoViewModelProtocol! {
        didSet{
            
        }
    }
    
    init(_ viewModel: ContactInfoViewModel) {
        self.contactInfoViewModel = viewModel
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
        contactInfoViewModel.name.bind{
            [weak self] name in
            self?.nameLabel.text = "Full name: \(name)"
        }
        contactInfoViewModel.phoneNumber.bind{
            [weak self] phoneNumber in
            self?.phoneNumberLabel.text = "Phone number: \(phoneNumber)"
        }
        contactInfoViewModel.email.bind{
            [weak self] email in
            self?.emailLabel.text = "Email: \(email)"
        }
        contactInfoViewModel.photoData.bind{
            [weak self] photoData in
            self?.photoImageView.image = UIImage(data: photoData)
        }
        navigationItem.title = "Information"
        nameLabel.text = "Full name: \(name)"
        phoneNumberLabel.text = "Phone number: \(phoneNumber)"
        emailLabel.text = "Email: \(email)"
        guard let data = photoData else { return }

        photoImageView.image = UIImage(data: data)
    }

}
