// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPlaidHoldingsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPlaidHoldings($profileId: Int!) {
      get_portfolio_holdings(profile_id: $profileId) {
        __typename
        holding {
          __typename
          id
          quantity
          profile_id
          security_id
          account {
            __typename
            balance_available
            balance_current
            balance_iso_currency_code
            balance_limit
            created_at
            id
            mask
            name
            official_name
            subtype
            type
          }
          holding_details {
            __typename
            purchase_date
            relative_gain_total
            relative_gain_1d
            value_to_portfolio_value
            ticker_name
            market_capitalization
            next_earnings_date
            ltt_quantity_total
            security_type
            account_id
          }
        }
      }
    }
    """

  public let operationName: String = "GetPlaidHoldings"

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
        GraphQLField("get_portfolio_holdings", arguments: ["profile_id": GraphQLVariable("profileId")], type: .list(.object(GetPortfolioHolding.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPortfolioHoldings: [GetPortfolioHolding?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_portfolio_holdings": getPortfolioHoldings.flatMap { (value: [GetPortfolioHolding?]) -> [ResultMap?] in value.map { (value: GetPortfolioHolding?) -> ResultMap? in value.flatMap { (value: GetPortfolioHolding) -> ResultMap in value.resultMap } } }])
    }

    public var getPortfolioHoldings: [GetPortfolioHolding?]? {
      get {
        return (resultMap["get_portfolio_holdings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetPortfolioHolding?] in value.map { (value: ResultMap?) -> GetPortfolioHolding? in value.flatMap { (value: ResultMap) -> GetPortfolioHolding in GetPortfolioHolding(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetPortfolioHolding?]) -> [ResultMap?] in value.map { (value: GetPortfolioHolding?) -> ResultMap? in value.flatMap { (value: GetPortfolioHolding) -> ResultMap in value.resultMap } } }, forKey: "get_portfolio_holdings")
      }
    }

    public struct GetPortfolioHolding: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PortfolioHolding"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("holding", type: .nonNull(.object(Holding.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(holding: Holding) {
        self.init(unsafeResultMap: ["__typename": "PortfolioHolding", "holding": holding.resultMap])
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
      public var holding: Holding {
        get {
          return Holding(unsafeResultMap: resultMap["holding"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "holding")
        }
      }

      public struct Holding: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_holdings"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("quantity", type: .nonNull(.scalar(float8.self))),
            GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("security_id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("account", type: .object(Account.selections)),
            GraphQLField("holding_details", type: .object(HoldingDetail.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, quantity: float8, profileId: Int, securityId: Int, account: Account? = nil, holdingDetails: HoldingDetail? = nil) {
          self.init(unsafeResultMap: ["__typename": "app_profile_holdings", "id": id, "quantity": quantity, "profile_id": profileId, "security_id": securityId, "account": account.flatMap { (value: Account) -> ResultMap in value.resultMap }, "holding_details": holdingDetails.flatMap { (value: HoldingDetail) -> ResultMap in value.resultMap }])
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

        public var quantity: float8 {
          get {
            return resultMap["quantity"]! as! float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "quantity")
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

        public var securityId: Int {
          get {
            return resultMap["security_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "security_id")
          }
        }

        /// An object relationship
        public var account: Account? {
          get {
            return (resultMap["account"] as? ResultMap).flatMap { Account(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "account")
          }
        }

        /// An object relationship
        public var holdingDetails: HoldingDetail? {
          get {
            return (resultMap["holding_details"] as? ResultMap).flatMap { HoldingDetail(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "holding_details")
          }
        }

        public struct Account: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["app_profile_portfolio_accounts"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("balance_available", type: .scalar(float8.self)),
              GraphQLField("balance_current", type: .nonNull(.scalar(float8.self))),
              GraphQLField("balance_iso_currency_code", type: .nonNull(.scalar(String.self))),
              GraphQLField("balance_limit", type: .scalar(float8.self)),
              GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
              GraphQLField("id", type: .nonNull(.scalar(Int.self))),
              GraphQLField("mask", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("official_name", type: .scalar(String.self)),
              GraphQLField("subtype", type: .nonNull(.scalar(String.self))),
              GraphQLField("type", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(balanceAvailable: float8? = nil, balanceCurrent: float8, balanceIsoCurrencyCode: String, balanceLimit: float8? = nil, createdAt: timestamptz, id: Int, mask: String, name: String, officialName: String? = nil, subtype: String, type: String) {
            self.init(unsafeResultMap: ["__typename": "app_profile_portfolio_accounts", "balance_available": balanceAvailable, "balance_current": balanceCurrent, "balance_iso_currency_code": balanceIsoCurrencyCode, "balance_limit": balanceLimit, "created_at": createdAt, "id": id, "mask": mask, "name": name, "official_name": officialName, "subtype": subtype, "type": type])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var balanceAvailable: float8? {
            get {
              return resultMap["balance_available"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "balance_available")
            }
          }

          public var balanceCurrent: float8 {
            get {
              return resultMap["balance_current"]! as! float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "balance_current")
            }
          }

          public var balanceIsoCurrencyCode: String {
            get {
              return resultMap["balance_iso_currency_code"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "balance_iso_currency_code")
            }
          }

          public var balanceLimit: float8? {
            get {
              return resultMap["balance_limit"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "balance_limit")
            }
          }

          public var createdAt: timestamptz {
            get {
              return resultMap["created_at"]! as! timestamptz
            }
            set {
              resultMap.updateValue(newValue, forKey: "created_at")
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

          public var mask: String {
            get {
              return resultMap["mask"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "mask")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var officialName: String? {
            get {
              return resultMap["official_name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "official_name")
            }
          }

          public var subtype: String {
            get {
              return resultMap["subtype"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "subtype")
            }
          }

          public var type: String {
            get {
              return resultMap["type"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }
        }

        public struct HoldingDetail: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["portfolio_holding_details"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("purchase_date", type: .scalar(timestamp.self)),
              GraphQLField("relative_gain_total", type: .scalar(float8.self)),
              GraphQLField("relative_gain_1d", type: .scalar(float8.self)),
              GraphQLField("value_to_portfolio_value", type: .scalar(float8.self)),
              GraphQLField("ticker_name", type: .scalar(String.self)),
              GraphQLField("market_capitalization", type: .scalar(bigint.self)),
              GraphQLField("next_earnings_date", type: .scalar(timestamp.self)),
              GraphQLField("ltt_quantity_total", type: .scalar(float8.self)),
              GraphQLField("security_type", type: .scalar(String.self)),
              GraphQLField("account_id", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(purchaseDate: timestamp? = nil, relativeGainTotal: float8? = nil, relativeGain_1d: float8? = nil, valueToPortfolioValue: float8? = nil, tickerName: String? = nil, marketCapitalization: bigint? = nil, nextEarningsDate: timestamp? = nil, lttQuantityTotal: float8? = nil, securityType: String? = nil, accountId: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "portfolio_holding_details", "purchase_date": purchaseDate, "relative_gain_total": relativeGainTotal, "relative_gain_1d": relativeGain_1d, "value_to_portfolio_value": valueToPortfolioValue, "ticker_name": tickerName, "market_capitalization": marketCapitalization, "next_earnings_date": nextEarningsDate, "ltt_quantity_total": lttQuantityTotal, "security_type": securityType, "account_id": accountId])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var purchaseDate: timestamp? {
            get {
              return resultMap["purchase_date"] as? timestamp
            }
            set {
              resultMap.updateValue(newValue, forKey: "purchase_date")
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

          public var relativeGain_1d: float8? {
            get {
              return resultMap["relative_gain_1d"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "relative_gain_1d")
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

          public var tickerName: String? {
            get {
              return resultMap["ticker_name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "ticker_name")
            }
          }

          public var marketCapitalization: bigint? {
            get {
              return resultMap["market_capitalization"] as? bigint
            }
            set {
              resultMap.updateValue(newValue, forKey: "market_capitalization")
            }
          }

          public var nextEarningsDate: timestamp? {
            get {
              return resultMap["next_earnings_date"] as? timestamp
            }
            set {
              resultMap.updateValue(newValue, forKey: "next_earnings_date")
            }
          }

          public var lttQuantityTotal: float8? {
            get {
              return resultMap["ltt_quantity_total"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "ltt_quantity_total")
            }
          }

          public var securityType: String? {
            get {
              return resultMap["security_type"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "security_type")
            }
          }

          public var accountId: Int? {
            get {
              return resultMap["account_id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "account_id")
            }
          }
        }
      }
    }
  }
}
