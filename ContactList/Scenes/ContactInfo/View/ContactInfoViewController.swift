import UIKit
import RxSwift
import RxCocoa

class ContactInfoViewController: UIViewController {
    
    var viewModel: ContactInfoViewModel!
    let disposeBag = DisposeBag()
    
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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Information"
        indicator.startAnimating()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let peopleTrigger = self.rx.viewWillAppear.asDriver().mapToVoid()
        let input = ContactInfoViewModel.Input(peopleTrigger: peopleTrigger)
        let output = viewModel.transform(input: input)
        output.people
            .drive(onNext:{ people in
                self.nameLabel.text = "Full name: \(people.names[0].displayName)"
                self.phoneNumberLabel.text =
                    "Phone number: \(people.phoneNumbers?.map({$0.value}).joined(separator: ",\n\t\t\t\t  ") ?? "No number")"
                self.phoneNumberLabel.numberOfLines = people.phoneNumbers?.count ?? 0
                self.phoneNumberLabel.sizeToFit()
                self.emailLabel.text = "Email: \(people.emailAddresses.map { $0.value }.joined(separator: ",\n\t\t"))"
                self.emailLabel.numberOfLines = people.emailAddresses.count
                self.emailLabel.sizeToFit()
                guard let photoUrl = people.photos?[0].url else {
                    self.photoImageView.image = UIImage(named: "profile")
                    self.indicator.stopAnimating()
                    return
                }
            
                let imageData = self.viewModel.downloadImage(url: photoUrl)
                imageData
                    .drive(onNext:{ data in
                        self.photoImageView.image = UIImage(data: data)
                        self.indicator.stopAnimating()
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }

}
