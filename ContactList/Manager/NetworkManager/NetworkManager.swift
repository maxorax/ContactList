import Foundation
import Alamofire
import RxSwift

class NetworkManager {
        
    func getAllContacts(accessToken: String) -> Single<[People]> {
        return Single.create{ single in
            let urlString = Constants.urlAPI + accessToken
            AF.request(urlString, method: .get).responseJSON{ (response) in
                guard let data = response.data else {
                    guard let error = response.error?.underlyingError else {
                        return
                    }
                    
                    single(.failure(error))
                    return
                }
                
                do{
                  let peoples = try JSONDecoder().decode(Peoples.self, from: data)
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
    
  
    func getPhoto(photoUrl: String) -> Single<Data> {
        return Single.create{ single in
            DispatchQueue.global().async {
                do {
                    single(.success(try Data(contentsOf: URL(string: photoUrl)!)))
                }
                catch let error {
                    single(.failure(error))                }
            }
            return Disposables.create{ AF.cancelAllRequests() }

        }
    }
    
}
