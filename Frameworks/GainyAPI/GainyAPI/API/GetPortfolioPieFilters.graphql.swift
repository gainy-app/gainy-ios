// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPortfolioPieFiltersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPortfolioPieFilters($profileId: Int!) {
      profile_brokers(where: {profile_id: {_eq: $profileId}}) {
        __typename
        broker {
          __typename
          uniq_id
          name
        }
      }
      portfolio_interests(where: {profile_id: {_eq: $profileId}}) {
        __typename
        interest {
          __typename
          id
          name
        }
      }
      portfolio_categories(where: {profile_id: {_eq: $profileId}}) {
        __typename
        category {
          __typename
          id
          name
        }
      }
    }
    """

  public let operationName: String = "GetPortfolioPieFilters"

  public var profileId: Int

  public init(profileId: Int) {
    self.profileId = profileId
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("profile_brokers", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]]], type: .nonNull(.list(.nonNull(.object(ProfileBroker.selections))))),
        GraphQLField("portfolio_interests", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]]], type: .nonNull(.list(.nonNull(.object(PortfolioInterest.selections))))),
        GraphQLField("portfolio_categories", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]]], type: .nonNull(.list(.nonNull(.object(PortfolioCategory.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(profileBrokers: [ProfileBroker], portfolioInterests: [PortfolioInterest], portfolioCategories: [PortfolioCategory]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "profile_brokers": profileBrokers.map { (value: ProfileBroker) -> ResultMap in value.resultMap }, "portfolio_interests": portfolioInterests.map { (value: PortfolioInterest) -> ResultMap in value.resultMap }, "portfolio_categories": portfolioCategories.map { (value: PortfolioCategory) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230214114216.profile_brokers"
    public var profileBrokers: [ProfileBroker] {
      get {
        return (resultMap["profile_brokers"] as! [ResultMap]).map { (value: ResultMap) -> ProfileBroker in ProfileBroker(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: ProfileBroker) -> ResultMap in value.resultMap }, forKey: "profile_brokers")
      }
    }

    /// fetch data from the table: "public_230214114216.portfolio_interests"
    public var portfolioInterests: [PortfolioInterest] {
      get {
        return (resultMap["portfolio_interests"] as! [ResultMap]).map { (value: ResultMap) -> PortfolioInterest in PortfolioInterest(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: PortfolioInterest) -> ResultMap in value.resultMap }, forKey: "portfolio_interests")
      }
    }

    /// fetch data from the table: "public_230214114216.portfolio_categories"
    public var portfolioCategories: [PortfolioCategory] {
      get {
        return (resultMap["portfolio_categories"] as! [ResultMap]).map { (value: ResultMap) -> PortfolioCategory in PortfolioCategory(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: PortfolioCategory) -> ResultMap in value.resultMap }, forKey: "portfolio_categories")
      }
    }

    public struct ProfileBroker: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["profile_brokers"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("broker", type: .object(Broker.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(broker: Broker? = nil) {
        self.init(unsafeResultMap: ["__typename": "profile_brokers", "broker": broker.flatMap { (value: Broker) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// An object relationship
      public var broker: Broker? {
        get {
          return (resultMap["broker"] as? ResultMap).flatMap { Broker(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "broker")
        }
      }

      public struct Broker: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["portfolio_brokers"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("uniq_id", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(uniqId: String, name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "portfolio_brokers", "uniq_id": uniqId, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var uniqId: String {
          get {
            return resultMap["uniq_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "uniq_id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }

    public struct PortfolioInterest: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["portfolio_interests"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("interest", type: .object(Interest.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(interest: Interest? = nil) {
        self.init(unsafeResultMap: ["__typename": "portfolio_interests", "interest": interest.flatMap { (value: Interest) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// An object relationship
      public var interest: Interest? {
        get {
          return (resultMap["interest"] as? ResultMap).flatMap { Interest(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "interest")
        }
      }

      public struct Interest: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["interests"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "interests", "id": id, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }

    public struct PortfolioCategory: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["portfolio_categories"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("category", type: .object(Category.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(category: Category? = nil) {
        self.init(unsafeResultMap: ["__typename": "portfolio_categories", "category": category.flatMap { (value: Category) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// An object relationship
      public var category: Category? {
        get {
          return (resultMap["category"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "category")
        }
      }

      public struct Category: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["categories"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "categories", "id": id, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}
