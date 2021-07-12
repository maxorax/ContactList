import UIKit

final class RootRouter: Router<RootViewController>, RootRouter.Routes {
    typealias Routes = LoginRoute & ContactRoute
    
}
