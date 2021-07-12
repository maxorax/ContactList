import Foundation
import Alamofire

class NetworkManager {
    
    func getContacs(accessToken: String, _ complitionHandler: @escaping ([People]) -> Void ) {
        let urlString = Constants.urlAPI + accessToken
        AF.request(urlString, method: .get).responseJSON{ (response) in
            guard let data = response.data else { return }
            
            do{
              let peoples = try JSONDecoder().decode(Peoples.self, from: data)
              complitionHandler(peoples.people)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getContactPhoto(photoUrl: String,_ complitionHandeler: @escaping (Data) -> Void ) {
        AF.request(photoUrl, method: .get).response{
            response in
            guard let data = response.data else { return }
                
            complitionHandeler(data)
        }
    }
}
