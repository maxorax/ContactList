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
        viewModel.transform(input: input)
    }
    
    

}



