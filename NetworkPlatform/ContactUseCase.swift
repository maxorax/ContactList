import Foundation
import Alamofire
import RxSwift
import Domain

public class ContactUseCase: Domain.ContactUseCase {
   
    public func getAllContacts(url: String) -> Single<[Domain.People]> {
        return Single.create{ single in
            AF.request(url, method: .get).responseJSON{ (response) in
                guard let data = response.data else {
                    guard let error = response.error?.underlyingError else {
                        return
                    }
                    
                    single(.failure(error))
                    return
                }
                
                do{
                    let peoples = try JSONDecoder().decode(Domain.Peoples.self, from: data)
                    single(.success(peoples.people))
                } catch let error {
                    single(.failure(error))
                }
            }
            return Disposables.create{
                AF.cancelAllRequests()
            }
        }
    }
    
    public func getPhoto(photoUrl: String) -> Single<Data> {
        return Single.create{ single in
            DispatchQueue.global().async {
                do {
                    single(.success(try Data(contentsOf: URL(string: photoUrl)!)))
                }
                catch let error {
                    single(.failure(error))
                }
            }
            return Disposables.create{ AF.cancelAllRequests() }

        }
    }
    
}
