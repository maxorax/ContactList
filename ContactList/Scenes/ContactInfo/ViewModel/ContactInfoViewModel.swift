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
    
    func getContact(name: Domain.Name, phoneNumber: Domain.PhoneNumber?, email: Domain.EmailAddress, photoUrl: Domain.Photo? ) -> Single<Domain.People> {
        return Single.create{
            single in
            let name = name
            let phone = phoneNumber
            let email = email
            let photo = photoUrl
            let people = Domain.People(
                names: [name],
                phoneNumbers: [phone ?? Domain.PhoneNumber(value: "No number") ],
                photos: [photo ?? Domain.Photo(url: "")],
                emailAddresses: [email]
            )
            single(.success(people))
            return Disposables.create()
        }
    }
    
    func transform(input: Input) -> Output {
        let people = self.getContact(
            name: self.people.names[0],
            phoneNumber: self.people.phoneNumbers?[0],
            email: self.people.emailAddresses[0],
            photoUrl: self.people.photos?[0]
            )
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

