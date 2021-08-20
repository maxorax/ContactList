import UIKit
import RxSwift
import RxCocoa
import RxViewController
import Domain


final class ContactViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    private var peoples: [Domain.People]
    private var viewModel: ContactViewModel!
    private let disposeBag = DisposeBag()
    
    init(_ viewModel: ContactViewModel) {
        self.viewModel = viewModel
        peoples = []
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        indicator.startAnimating()
        bindViewModel()
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
    
    private func bindViewModel() {
        let contactTrigger = self.rx.viewWillAppear.asDriver().mapToVoid()
        let input = ContactViewModel.Input.init(contactTrigger: contactTrigger, disposeBag: disposeBag)
        let output = viewModel.transform(input: input)
        
        output.contacts
            .drive(onNext: { (contacts) in
                self.peoples = contacts
                self.indicator.stopAnimating()
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.errorTracker.asObservable().take(1)
            .subscribe(onNext:{ error in
                DispatchQueue.main.async {
                    self.showAlert()
                }
            })
            .disposed(by: disposeBag)
    }

}

// MARK: - Table view data source

extension ContactViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "contactCell",
            for: indexPath
        ) as! ContactTableViewCell
        cell.tag = indexPath.row
        cell.setup(people: self.peoples[indexPath.row], index: indexPath.row, output: viewModel)
        return cell
    }

    
}

//MARK: -Table view delegate

extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openSelectedCells(people: peoples[indexPath.row])
    }
    
}

//MARK: -Alert

extension ContactViewController {
    private func showAlert() {
        let alert = UIAlertController(
            title: "Error!",
            message: "The internet connection is disconnected. Turn on the internet and click OK.",
            preferredStyle: .actionSheet
        )
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { _ in
                    self.bindViewModel()
                }
            )
        )
        self.present(alert, animated: true, completion: nil)
    }
}




