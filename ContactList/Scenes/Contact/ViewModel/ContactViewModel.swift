import Foundation
import RxSwift
import RxCocoa

struct ContactViewModel: ContactViewModelProtocol {
    
    private let gIDSignInManager: GIDSignInManager = GIDSignInManager.shared
    private let networkManager: NetworkManager = NetworkManager()
    private let router: ContactRouter.Routes
    private let errorTracker: ErrorTracker = ErrorTracker()
    
    
    init(container: Container) {
        router = container.router
    }
    
    func signOut() {
        gIDSignInManager.signOut()
    }
    
    func transform(input: Input) -> Output {

        let accessToken = gIDSignInManager.getAccessToken()!

        let contacts = self.networkManager
            .getAllContacts(accessToken: accessToken)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        
        return Output(contacts: contacts, errorTracker: errorTracker)

    }
    
    func openSelectedCells(people: People) {
        router.openContactInfoModule(people: people)
    }
   
    func openLoginController() {
        router.openLoginModule()
    }
    
}

extension ContactViewModel {
    struct Container {
        var router: ContactRouter
    }
    struct Input {
        let contactTrigger: Driver<Void>
        let disposeBag : DisposeBag
    }
    struct Output {
        let contacts: Driver<[People]>
        let errorTracker: ErrorTracker
    }
    
}

extension ContactViewModel: ContactTableViewCellDelegate {
    
    func downloadImage(url: String) -> Driver<Data> {
        return networkManager.getPhoto(photoUrl: url)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        
    }
}
