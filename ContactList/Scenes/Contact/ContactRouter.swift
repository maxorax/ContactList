import UIKit

final class ContactRouter: Router<ContactViewController>, ContactRouter.Routes {
    typealias Routes = ContactInfoRoute & LoginRoute
}
