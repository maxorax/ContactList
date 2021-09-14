import UIKit
import RxSwift

class NotConnectionViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    private var viewModel: NotConnectionViewModel!
    let disposeBag = DisposeBag()

    init(_ viewModel: NotConnectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }

    private func bindViewModel() {
        let retryTrigger = button.rx.tap.asDriver().mapToVoid()
        let input = NotConnectionViewModel.Input(retryTrigger: retryTrigger, disposeBag: disposeBag)
        viewModel.transform(input: input)
    }
    
}
