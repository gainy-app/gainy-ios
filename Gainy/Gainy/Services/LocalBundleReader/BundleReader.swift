import Foundation

/**
 Represents service that can read files from the application's bundle.
 */
struct BundleReader {
    // MARK: Internal

    // MARK: Internal properties

    /**
     The GraphQL endpoint requires token to be able to request the data.
     You can find this in the admin's dashboard.
     Put the key into the Info.plist and assign to the `HasuraAdminSecret` entry.
     */
    private(set) var graphQLToken: String = {
        let plistValue = Bundle.main.object(forInfoDictionaryKey: InfoPlistKey.hasuraAdminSecret)
        guard let apiKey = plistValue as? String else {
            assertionFailure(ErrorMessage.apiKeyMustBeSet)
            return ""
        }

        return apiKey
    }()

    private(set) var appsFlyerDevKey: String = {
        let plistValue = Bundle.main.object(forInfoDictionaryKey: InfoPlistKey.appsFlyerDevKey)
        guard let apiKey = plistValue as? String else {
            assertionFailure(ErrorMessage.appsFlyerDevKeyMustBeSet)
            return ""
        }

        return apiKey
    }()

    // MARK: Private

    private enum InfoPlistKey {
        static let hasuraAdminSecret = "HasuraAdminSecret"
        static let appsFlyerDevKey = "AppsFlyerDevKey"
    }

    private enum ErrorMessage {
        static let apiKeyMustBeSet =
            "Hasura's admin key must be set in the Info.plist as `\(InfoPlistKey.hasuraAdminSecret)`."
        static let appsFlyerDevKeyMustBeSet =
            "AppsFlyer dev key must be set in the Info.plist as `\(InfoPlistKey.appsFlyerDevKey)`."
    }
}
