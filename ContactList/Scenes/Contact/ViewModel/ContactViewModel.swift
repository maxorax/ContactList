import Foundation
import RxSwift
import RxCocoa
import Domain

struct ContactViewModel: ContactViewModelProtocol {
    
    private let router: ContactRouter.Routes
    private let errorTracker: ErrorTracker = ErrorTracker()
    private let contactUseCase: Domain.ContactUseCase
    private let signInUseCase: Domain.SignInUseCase
    private let accessUseCase: Domain.AccessUseCase
    
    
    init(container: Container) {
        router = container.router
        contactUseCase = container.contactUseCase
        signInUseCase = container.signInUseCase
        accessUseCase = container.accessUseCase
    }
    
    func signOut() {
        signInUseCase.signOut()
    }
    
    func transform(input: Input) -> Output {
        var accessToken = ""
         accessUseCase.obtainToken()
            .asDriverOnErrorJustComplete()
            .drive(onNext:{ token in
                accessToken = token?.token ?? ""
            })
            .disposed(by: input.disposeBag)

        let contacts = contactUseCase
            .getAllContacts(url: Domain.Constants.urlAPI + accessToken)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        
        return Output(contacts: contacts, errorTracker: errorTracker)

    }
    
    func openSelectedCells(people: Domain.People) {
        router.openContactInfoModule(people: people)
    }
   
    func openLoginController() {
        router.openLoginModule()
    }
    
}

extension ContactViewModel {
    struct Container {
        let router: ContactRouter
        let signInUseCase: Domain.SignInUseCase
        let contactUseCase: Domain.ContactUseCase
        let accessUseCase: Domain.AccessUseCase
        
    }
    struct Input {
        let contactTrigger: Driver<Void>
        let disposeBag : DisposeBag
    }
    struct Output {
        let contacts: Driver<[Domain.People]>
        let errorTracker: ErrorTracker
    }
    
}

extension ContactViewModel: ContactTableViewCellDelegate {
    
    func downloadImage(url: String) -> Driver<Data> {
        return contactUseCase.getPhoto(photoUrl: url)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        
    }
}
