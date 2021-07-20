import UIKit
import RxSwift
import RxCocoa
import RxViewController

class RootViewController: UIViewController {
    
    var viewModel: RootViewModel!
    let disposeBag = DisposeBag()
    
    init(_ viewModel: RootViewModel) {
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
        let viewTrigger = self.rx.viewWillAppear.asDriver().mapToVoid()
        let input = RootViewModel.Input(viewTrigger: viewTrigger, disposeBag: disposeBag)
        let output = viewModel.transform(input: input)
        output.errorTracker.drive(onNext: { error in
            self.showAlert()
        }).disposed(by: disposeBag)
    }
}

extension RootViewController {
    private func showAlert() {
        let alert = UIAlertController(
            title: "Error!",
            message: "The internet connection is disconnected. Turn on the internet and click OK.",
            preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.bindViewModel()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

