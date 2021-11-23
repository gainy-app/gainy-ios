// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetProfileGainsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetProfileGains($profileID: Int!) {
      app_profiles(where: {id: {_eq: $profileID}}) {
        __typename
        portfolio_gains {
          __typename
          absolute_gain_1m
          absolute_gain_1w
          absolute_gain_1y
          absolute_gain_3m
          absolute_gain_5y
          absolute_gain_total
          actual_value
          relative_gain_1m
          relative_gain_1w
          relative_gain_1y
          relative_gain_3m
          relative_gain_5y
          relative_gain_total
          profile_id
        }
        profile_holdings {
          __typename
          portfolio_holding_gains {
            __typename
            absolute_gain_1m
            absolute_gain_1w
            absolute_gain_1y
            absolute_gain_3m
            absolute_gain_5y
            absolute_gain_total
            actual_value
            relative_gain_1m
            relative_gain_1w
            relative_gain_1y
            relative_gain_3m
            relative_gain_5y
            relative_gain_total
            value_to_portfolio_value
            holding_id
            holding {
              __typename
              security_id
              profile_id
            }
          }
          holding_transactions {
            __typename
            portfolio_transaction_gains {
              __typename
              absolute_gain_1m
              absolute_gain_1w
              absolute_gain_1y
              absolute_gain_3m
              absolute_gain_5y
              absolute_gain_total
              relative_gain_1m
              relative_gain_1w
              relative_gain_1y
              relative_gain_3m
              relative_gain_5y
              relative_gain_total
            }
            security_id
            profile_id
          }
          security_id
          profile_id
        }
      }
    }
    """

  public let operationName: String = "GetProfileGains"

  public var profileID: Int

  public init(profileID: Int) {
    self.profileID = profileID
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_profiles", arguments: ["where": ["id": ["_eq": GraphQLVariable("profileID")]]], type: .nonNull(.list(.nonNull(.object(AppProfile.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appProfiles: [AppProfile]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_profiles": appProfiles.map { (value: AppProfile) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.profiles"
    public var appProfiles: [AppProfile] {
      get {
        return (resultMap["app_profiles"] as! [ResultMap]).map { (value: ResultMap) -> AppProfile in AppProfile(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppProfile) -> ResultMap in value.resultMap }, forKey: "app_profiles")
      }
    }

    public struct AppProfile: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profiles"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("portfolio_gains", type: .object(PortfolioGain.selections)),
          GraphQLField("profile_holdings", type: .nonNull(.list(.nonNull(.object(ProfileHolding.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(portfolioGains: PortfolioGain? = nil, profileHoldings: [ProfileHolding]) {
        self.init(unsafeResultMap: ["__typename": "app_profiles", "portfolio_gains": portfolioGains.flatMap { (value: PortfolioGain) -> ResultMap in value.resultMap }, "profile_holdings": profileHoldings.map { (value: ProfileHolding) -> ResultMap in value.resultMap }])
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
      public var portfolioGains: PortfolioGain? {
        get {
          return (resultMap["portfolio_gains"] as? ResultMap).flatMap { PortfolioGain(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "portfolio_gains")
        }
      }

      /// An array relationship
      public var profileHoldings: [ProfileHolding] {
        get {
          return (resultMap["profile_holdings"] as! [ResultMap]).map { (value: ResultMap) -> ProfileHolding in ProfileHolding(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: ProfileHolding) -> ResultMap in value.resultMap }, forKey: "profile_holdings")
        }
      }

      public struct PortfolioGain: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["portfolio_gains"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("absolute_gain_1m", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_1w", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_1y", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_3m", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_5y", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_total", type: .scalar(float8.self)),
            GraphQLField("actual_value", type: .scalar(float8.self)),
            GraphQLField("relative_gain_1m", type: .scalar(float8.self)),
            GraphQLField("relative_gain_1w", type: .scalar(float8.self)),
            GraphQLField("relative_gain_1y", type: .scalar(float8.self)),
            GraphQLField("relative_gain_3m", type: .scalar(float8.self)),
            GraphQLField("relative_gain_5y", type: .scalar(float8.self)),
            GraphQLField("relative_gain_total", type: .scalar(float8.self)),
            GraphQLField("profile_id", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(absoluteGain_1m: float8? = nil, absoluteGain_1w: float8? = nil, absoluteGain_1y: float8? = nil, absoluteGain_3m: float8? = nil, absoluteGain_5y: float8? = nil, absoluteGainTotal: float8? = nil, actualValue: float8? = nil, relativeGain_1m: float8? = nil, relativeGain_1w: float8? = nil, relativeGain_1y: float8? = nil, relativeGain_3m: float8? = nil, relativeGain_5y: float8? = nil, relativeGainTotal: float8? = nil, profileId: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "portfolio_gains", "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "profile_id": profileId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var absoluteGain_1m: float8? {
          get {
            return resultMap["absolute_gain_1m"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "absolute_gain_1m")
          }
        }

        public var absoluteGain_1w: float8? {
          get {
            return resultMap["absolute_gain_1w"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "absolute_gain_1w")
          }
        }

        public var absoluteGain_1y: float8? {
          get {
            return resultMap["absolute_gain_1y"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "absolute_gain_1y")
          }
        }

        public var absoluteGain_3m: float8? {
          get {
            return resultMap["absolute_gain_3m"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "absolute_gain_3m")
          }
        }

        public var absoluteGain_5y: float8? {
          get {
            return resultMap["absolute_gain_5y"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "absolute_gain_5y")
          }
        }

        public var absoluteGainTotal: float8? {
          get {
            return resultMap["absolute_gain_total"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "absolute_gain_total")
          }
        }

        public var actualValue: float8? {
          get {
            return resultMap["actual_value"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "actual_value")
          }
        }

        public var relativeGain_1m: float8? {
          get {
            return resultMap["relative_gain_1m"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "relative_gain_1m")
          }
        }

        public var relativeGain_1w: float8? {
          get {
            return resultMap["relative_gain_1w"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "relative_gain_1w")
          }
        }

        public var relativeGain_1y: float8? {
          get {
            return resultMap["relative_gain_1y"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "relative_gain_1y")
          }
        }

        public var relativeGain_3m: float8? {
          get {
            return resultMap["relative_gain_3m"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "relative_gain_3m")
          }
        }

        public var relativeGain_5y: float8? {
          get {
            return resultMap["relative_gain_5y"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "relative_gain_5y")
          }
        }

        public var relativeGainTotal: float8? {
          get {
            return resultMap["relative_gain_total"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "relative_gain_total")
          }
        }

        public var profileId: Int? {
          get {
            return resultMap["profile_id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "profile_id")
          }
        }
      }

      public struct ProfileHolding: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_holdings"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("portfolio_holding_gains", type: .object(PortfolioHoldingGain.selections)),
            GraphQLField("holding_transactions", type: .nonNull(.list(.nonNull(.object(HoldingTransaction.selections))))),
            GraphQLField("security_id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(portfolioHoldingGains: PortfolioHoldingGain? = nil, holdingTransactions: [HoldingTransaction], securityId: Int, profileId: Int) {
          self.init(unsafeResultMap: ["__typename": "app_profile_holdings", "portfolio_holding_gains": portfolioHoldingGains.flatMap { (value: PortfolioHoldingGain) -> ResultMap in value.resultMap }, "holding_transactions": holdingTransactions.map { (value: HoldingTransaction) -> ResultMap in value.resultMap }, "security_id": securityId, "profile_id": profileId])
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
        public var portfolioHoldingGains: PortfolioHoldingGain? {
          get {
            return (resultMap["portfolio_holding_gains"] as? ResultMap).flatMap { PortfolioHoldingGain(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "portfolio_holding_gains")
          }
        }

        /// An array relationship
        public var holdingTransactions: [HoldingTransaction] {
          get {
            return (resultMap["holding_transactions"] as! [ResultMap]).map { (value: ResultMap) -> HoldingTransaction in HoldingTransaction(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: HoldingTransaction) -> ResultMap in value.resultMap }, forKey: "holding_transactions")
          }
        }

        public var securityId: Int {
          get {
            return resultMap["security_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "security_id")
          }
        }

        public var profileId: Int {
          get {
            return resultMap["profile_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "profile_id")
          }
        }

        public struct PortfolioHoldingGain: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["portfolio_holding_gains"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("absolute_gain_1m", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_1w", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_1y", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_3m", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_5y", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_total", type: .scalar(float8.self)),
              GraphQLField("actual_value", type: .scalar(float8.self)),
              GraphQLField("relative_gain_1m", type: .scalar(float8.self)),
              GraphQLField("relative_gain_1w", type: .scalar(float8.self)),
              GraphQLField("relative_gain_1y", type: .scalar(float8.self)),
              GraphQLField("relative_gain_3m", type: .scalar(float8.self)),
              GraphQLField("relative_gain_5y", type: .scalar(float8.self)),
              GraphQLField("relative_gain_total", type: .scalar(float8.self)),
              GraphQLField("value_to_portfolio_value", type: .scalar(float8.self)),
              GraphQLField("holding_id", type: .scalar(Int.self)),
              GraphQLField("holding", type: .object(Holding.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(absoluteGain_1m: float8? = nil, absoluteGain_1w: float8? = nil, absoluteGain_1y: float8? = nil, absoluteGain_3m: float8? = nil, absoluteGain_5y: float8? = nil, absoluteGainTotal: float8? = nil, actualValue: float8? = nil, relativeGain_1m: float8? = nil, relativeGain_1w: float8? = nil, relativeGain_1y: float8? = nil, relativeGain_3m: float8? = nil, relativeGain_5y: float8? = nil, relativeGainTotal: float8? = nil, valueToPortfolioValue: float8? = nil, holdingId: Int? = nil, holding: Holding? = nil) {
            self.init(unsafeResultMap: ["__typename": "portfolio_holding_gains", "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "value_to_portfolio_value": valueToPortfolioValue, "holding_id": holdingId, "holding": holding.flatMap { (value: Holding) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var absoluteGain_1m: float8? {
            get {
              return resultMap["absolute_gain_1m"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "absolute_gain_1m")
            }
          }

          public var absoluteGain_1w: float8? {
            get {
              return resultMap["absolute_gain_1w"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "absolute_gain_1w")
            }
          }

          public var absoluteGain_1y: float8? {
            get {
              return resultMap["absolute_gain_1y"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "absolute_gain_1y")
            }
          }

          public var absoluteGain_3m: float8? {
            get {
              return resultMap["absolute_gain_3m"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "absolute_gain_3m")
            }
          }

          public var absoluteGain_5y: float8? {
            get {
              return resultMap["absolute_gain_5y"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "absolute_gain_5y")
            }
          }

          public var absoluteGainTotal: float8? {
            get {
              return resultMap["absolute_gain_total"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "absolute_gain_total")
            }
          }

          public var actualValue: float8? {
            get {
              return resultMap["actual_value"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "actual_value")
            }
          }

          public var relativeGain_1m: float8? {
            get {
              return resultMap["relative_gain_1m"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "relative_gain_1m")
            }
          }

          public var relativeGain_1w: float8? {
            get {
              return resultMap["relative_gain_1w"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "relative_gain_1w")
            }
          }

          public var relativeGain_1y: float8? {
            get {
              return resultMap["relative_gain_1y"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "relative_gain_1y")
            }
          }

          public var relativeGain_3m: float8? {
            get {
              return resultMap["relative_gain_3m"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "relative_gain_3m")
            }
          }

          public var relativeGain_5y: float8? {
            get {
              return resultMap["relative_gain_5y"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "relative_gain_5y")
            }
          }

          public var relativeGainTotal: float8? {
            get {
              return resultMap["relative_gain_total"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "relative_gain_total")
            }
          }

          public var valueToPortfolioValue: float8? {
            get {
              return resultMap["value_to_portfolio_value"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "value_to_portfolio_value")
            }
          }

          public var holdingId: Int? {
            get {
              return resultMap["holding_id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "holding_id")
            }
          }

          /// An object relationship
          public var holding: Holding? {
            get {
              return (resultMap["holding"] as? ResultMap).flatMap { Holding(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "holding")
            }
          }

          public struct Holding: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["app_profile_holdings"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("security_id", type: .nonNull(.scalar(Int.self))),
                GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(securityId: Int, profileId: Int) {
              self.init(unsafeResultMap: ["__typename": "app_profile_holdings", "security_id": securityId, "profile_id": profileId])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var securityId: Int {
              get {
                return resultMap["security_id"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "security_id")
              }
            }

            public var profileId: Int {
              get {
                return resultMap["profile_id"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "profile_id")
              }
            }
          }
        }

        public struct HoldingTransaction: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["app_profile_portfolio_transactions"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("portfolio_transaction_gains", type: .object(PortfolioTransactionGain.selections)),
              GraphQLField("security_id", type: .nonNull(.scalar(Int.self))),
              GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(portfolioTransactionGains: PortfolioTransactionGain? = nil, securityId: Int, profileId: Int) {
            self.init(unsafeResultMap: ["__typename": "app_profile_portfolio_transactions", "portfolio_transaction_gains": portfolioTransactionGains.flatMap { (value: PortfolioTransactionGain) -> ResultMap in value.resultMap }, "security_id": securityId, "profile_id": profileId])
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
          public var portfolioTransactionGains: PortfolioTransactionGain? {
            get {
              return (resultMap["portfolio_transaction_gains"] as? ResultMap).flatMap { PortfolioTransactionGain(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "portfolio_transaction_gains")
            }
          }

          public var securityId: Int {
            get {
              return resultMap["security_id"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "security_id")
            }
          }

          public var profileId: Int {
            get {
              return resultMap["profile_id"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profile_id")
            }
          }

          public struct PortfolioTransactionGain: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["portfolio_transaction_gains"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("absolute_gain_1m", type: .scalar(float8.self)),
                GraphQLField("absolute_gain_1w", type: .scalar(float8.self)),
                GraphQLField("absolute_gain_1y", type: .scalar(float8.self)),
                GraphQLField("absolute_gain_3m", type: .scalar(float8.self)),
                GraphQLField("absolute_gain_5y", type: .scalar(float8.self)),
                GraphQLField("absolute_gain_total", type: .scalar(float8.self)),
                GraphQLField("relative_gain_1m", type: .scalar(float8.self)),
                GraphQLField("relative_gain_1w", type: .scalar(float8.self)),
                GraphQLField("relative_gain_1y", type: .scalar(float8.self)),
                GraphQLField("relative_gain_3m", type: .scalar(float8.self)),
                GraphQLField("relative_gain_5y", type: .scalar(float8.self)),
                GraphQLField("relative_gain_total", type: .scalar(float8.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(absoluteGain_1m: float8? = nil, absoluteGain_1w: float8? = nil, absoluteGain_1y: float8? = nil, absoluteGain_3m: float8? = nil, absoluteGain_5y: float8? = nil, absoluteGainTotal: float8? = nil, relativeGain_1m: float8? = nil, relativeGain_1w: float8? = nil, relativeGain_1y: float8? = nil, relativeGain_3m: float8? = nil, relativeGain_5y: float8? = nil, relativeGainTotal: float8? = nil) {
              self.init(unsafeResultMap: ["__typename": "portfolio_transaction_gains", "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var absoluteGain_1m: float8? {
              get {
                return resultMap["absolute_gain_1m"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "absolute_gain_1m")
              }
            }

            public var absoluteGain_1w: float8? {
              get {
                return resultMap["absolute_gain_1w"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "absolute_gain_1w")
              }
            }

            public var absoluteGain_1y: float8? {
              get {
                return resultMap["absolute_gain_1y"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "absolute_gain_1y")
              }
            }

            public var absoluteGain_3m: float8? {
              get {
                return resultMap["absolute_gain_3m"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "absolute_gain_3m")
              }
            }

            public var absoluteGain_5y: float8? {
              get {
                return resultMap["absolute_gain_5y"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "absolute_gain_5y")
              }
            }

            public var absoluteGainTotal: float8? {
              get {
                return resultMap["absolute_gain_total"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "absolute_gain_total")
              }
            }

            public var relativeGain_1m: float8? {
              get {
                return resultMap["relative_gain_1m"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "relative_gain_1m")
              }
            }

            public var relativeGain_1w: float8? {
              get {
                return resultMap["relative_gain_1w"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "relative_gain_1w")
              }
            }

            public var relativeGain_1y: float8? {
              get {
                return resultMap["relative_gain_1y"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "relative_gain_1y")
              }
            }

            public var relativeGain_3m: float8? {
              get {
                return resultMap["relative_gain_3m"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "relative_gain_3m")
              }
            }

            public var relativeGain_5y: float8? {
              get {
                return resultMap["relative_gain_5y"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "relative_gain_5y")
              }
            }

            public var relativeGainTotal: float8? {
              get {
                return resultMap["relative_gain_total"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "relative_gain_total")
              }
            }
          }
        }
      }
    }
  }
}
