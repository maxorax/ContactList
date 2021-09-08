import Foundation
import UIKit.UIViewController
import RxSwift
import RxCocoa

protocol LoginViewModelProtocol {
    associatedtype Input
            
    func transform(input: Input) 
}


