import Foundation
import RxCocoa
import RxSwift
import Domain

class ContactInfoViewModel: ContactInfoViewModelProtocol {
    
    private let contactUseCase: Domain.ContactUseCase
    private var people: Domain.People
    private let router: ContactInfoRouter.Routes
    
    init(container: Container) {
        router = container.router
        people = container.people
        contactUseCase = container.contactUseCase
        
    }
    
    func getContact(people: Domain.People) -> Single<Domain.People> {
        return Single.create{
            single in
            let contact = Domain.People(
                names: people.names,
                phoneNumbers: people.phoneNumbers
                    ?? [Domain.PhoneNumber(value: "No number")],
                photos: people.photos ?? [Domain.Photo(url: "")],
                emailAddresses: people.emailAddresses
            )
            single(.success(contact))
            return Disposables.create()
        }
    }
    
    func transform(input: Input) -> Output {
        let people = self.getContact( people: self.people)
        .asDriverOnErrorJustComplete()
        return Output(people: people)
    }
    
    func downloadImage(url: String) -> Driver<Data> {
        return contactUseCase.getPhoto(photoUrl: url)
            .asDriverOnErrorJustComplete()
    }
    
}

extension ContactInfoViewModel {
    struct Container {
        let router: ContactInfoRouter
        let people: Domain.People
        let contactUseCase: Domain.ContactUseCase
    }
    struct Input {
        let peopleTrigger: Driver<Void>
    }
    struct Output {
        var people: Driver<Domain.People>
    }
}

