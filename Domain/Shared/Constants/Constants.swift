import Foundation

public struct Constants {
    public static let urlAPI = "https://people.googleapis.com/v1/people:listDirectoryPeople?mergeSources=DIRECTORY_MERGE_SOURCE_TYPE_CONTACT&sources=DIRECTORY_SOURCE_TYPE_DOMAIN_CONTACT&sources=DIRECTORY_SOURCE_TYPE_DOMAIN_PROFILE&readMask=names,emailAddresses,phoneNumbers,photos&pageSize=1000&access_token="
    
    public static let scopesAPI = [
        "https://www.google.com/m8/feeds",
        "https://www.googleapis.com/auth/user.phonenumbers.read",
        "https://www.googleapis.com/auth/user.organization.read",
        "https://www.googleapis.com/auth/userinfo.profile",
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/directory.readonly"
    ]
    
    public static let clientIDAPI = "276109197611-ue1ounudsot2j7efbrvi56s7l23hncon.apps.googleusercontent.com"
}
