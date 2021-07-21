import Foundation
import RxCocoa
import RxSwift

class ContactInfoViewModel: ContactInfoViewModelProtocol {
    
    let networkManager = NetworkManager()
    
    var people: People
    private let router: ContactInfoRouter.Routes
    
    init(container: Container) {
        router = container.router
        self.people = container.people
        
    }
    
    func getContact(name: String, phoneNumber: String?, email: String, photoUrl: String? ) -> Single<People> {
        return Single.create{
            single in
            let name: Name = Name(displayName: name)
            let phoneNumber = PhoneNumber(value: phoneNumber ?? "No number")
            let email = EmailAddress(value: email)
            let photo = photoUrl != nil ? [Photo(url: photoUrl!)] : nil
            let people = People(
                names: [name],
                phoneNumbers: [phoneNumber],
                photos: photo,
                emailAddresses: [email]
            )
            single(.success(people))
            return Disposables.create()
        }
    }
    
    func transform(input: Input) -> Output {
        let people = self.getContact(
            name: self.people.names[0].displayName,
            phoneNumber: self.people.phoneNumbers?[0].value,
            email: self.people.emailAddresses[0].value,
            photoUrl: self.people.photos?[0].url
            )
            .asDriverOnErrorJustComplete()
        return Output(people: people)
    }
    
    func downloadImage(url: String) -> Driver<Data> {
        return networkManager.getPhoto(photoUrl: url)
            .asDriverOnErrorJustComplete()
    }
    
}

extension ContactInfoViewModel {
    struct Container {
        let router: ContactInfoRouter
        let people: People
    }
    struct Input {
        let peopleTrigger: Driver<Void>
    }
    struct Output {
        var people: Driver<People>
    }
}

