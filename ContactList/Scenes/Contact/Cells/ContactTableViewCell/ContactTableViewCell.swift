import UIKit
import RxSwift
import RxCocoa
import Domain

protocol ContactTableViewCellDelegate {
    func downloadImage(url: String) -> Driver<Data>
}

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let disposeBag: DisposeBag = DisposeBag()
        
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
        indicator.startAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setup(people: Domain.People, index: Int ,output: ContactTableViewCellDelegate ) {
        indicator.startAnimating()
        fullNameLabel.text = people.names[0].displayName
        phoneNumberLabel.text = people.phoneNumbers?[0].value ?? "No number"
        guard let photoUrl = people.photos?[0].url else {
            self.photoImageView.image = UIImage(named: "profile")
            indicator.stopAnimating()
            return
        }
         
        let imageData = output.downloadImage(url: photoUrl)
        imageData.drive(onNext: { data in
            DispatchQueue.main.async {
                guard self.tag == index  else { return }
                
                self.photoImageView.image = UIImage(data: data)
                self.indicator.stopAnimating()
            }
        }).disposed(by: self.disposeBag)
    }
}


