import UIKit

protocol RouterProtocol: class {
    associatedtype GeneriController: UIViewController
    var viewController: GeneriController? { get }
    
    func open(_ viewController: UIViewController, transition: Transition)
    func close()
}
