import Foundation
import RxSwift

public protocol ContactUseCase {
    
    func getAllContacts(url: String) -> Single<[People]>
    func getPhoto(photoUrl: String) -> Single<Data>
}
