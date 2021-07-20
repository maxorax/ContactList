import Foundation
import UIKit.UIViewController
import RxSwift
import RxCocoa

protocol LoginViewModelProtocol {
    associatedtype Input
    associatedtype Output
        
    func presentingViewController(vc: UIViewController)
    
    func openContactViewController()
    
    func transform(input: Input) 

}


