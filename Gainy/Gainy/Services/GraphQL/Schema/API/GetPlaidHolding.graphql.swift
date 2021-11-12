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
        id
        quantity
        iso_currency_code
        profile_id
        security_id
        security {
          __typename
          close_price
          close_price_as_of
          created_at
          iso_currency_code
          id
          name
          ticker_symbol
          type
          updated_at
          tickers {
            __typename
            name
            sector
            symbol
          }
        }
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
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("quantity", type: .nonNull(.scalar(Double.self))),
          GraphQLField("iso_currency_code", type: .nonNull(.scalar(String.self))),
          GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("security_id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("security", type: .nonNull(.list(.nonNull(.object(Security.selections))))),
          GraphQLField("account", type: .nonNull(.object(Account.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, quantity: Double, isoCurrencyCode: String, profileId: Int, securityId: Int, security: [Security], account: Account) {
        self.init(unsafeResultMap: ["__typename": "PortfolioHolding", "id": id, "quantity": quantity, "iso_currency_code": isoCurrencyCode, "profile_id": profileId, "security_id": securityId, "security": security.map { (value: Security) -> ResultMap in value.resultMap }, "account": account.resultMap])
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

      public var quantity: Double {
        get {
          return resultMap["quantity"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "quantity")
        }
      }

      public var isoCurrencyCode: String {
        get {
          return resultMap["iso_currency_code"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "iso_currency_code")
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

      /// An array relationship
      public var security: [Security] {
        get {
          return (resultMap["security"] as! [ResultMap]).map { (value: ResultMap) -> Security in Security(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Security) -> ResultMap in value.resultMap }, forKey: "security")
        }
      }

      /// An object relationship
      public var account: Account {
        get {
          return Account(unsafeResultMap: resultMap["account"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "account")
        }
      }

      public struct Security: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_portfolio_securities"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("close_price", type: .nonNull(.scalar(float8.self))),
            GraphQLField("close_price_as_of", type: .nonNull(.scalar(date.self))),
            GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
            GraphQLField("iso_currency_code", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("ticker_symbol", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("updated_at", type: .nonNull(.scalar(timestamptz.self))),
            GraphQLField("tickers", type: .object(Ticker.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(closePrice: float8, closePriceAsOf: date, createdAt: timestamptz, isoCurrencyCode: String, id: Int, name: String, tickerSymbol: String? = nil, type: String? = nil, updatedAt: timestamptz, tickers: Ticker? = nil) {
          self.init(unsafeResultMap: ["__typename": "app_portfolio_securities", "close_price": closePrice, "close_price_as_of": closePriceAsOf, "created_at": createdAt, "iso_currency_code": isoCurrencyCode, "id": id, "name": name, "ticker_symbol": tickerSymbol, "type": type, "updated_at": updatedAt, "tickers": tickers.flatMap { (value: Ticker) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var closePrice: float8 {
          get {
            return resultMap["close_price"]! as! float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "close_price")
          }
        }

        public var closePriceAsOf: date {
          get {
            return resultMap["close_price_as_of"]! as! date
          }
          set {
            resultMap.updateValue(newValue, forKey: "close_price_as_of")
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

        public var isoCurrencyCode: String {
          get {
            return resultMap["iso_currency_code"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "iso_currency_code")
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

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var tickerSymbol: String? {
          get {
            return resultMap["ticker_symbol"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "ticker_symbol")
          }
        }

        public var type: String? {
          get {
            return resultMap["type"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var updatedAt: timestamptz {
          get {
            return resultMap["updated_at"]! as! timestamptz
          }
          set {
            resultMap.updateValue(newValue, forKey: "updated_at")
          }
        }

        /// An object relationship
        public var tickers: Ticker? {
          get {
            return (resultMap["tickers"] as? ResultMap).flatMap { Ticker(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "tickers")
          }
        }

        public struct Ticker: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["tickers"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("sector", type: .scalar(String.self)),
              GraphQLField("symbol", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String? = nil, sector: String? = nil, symbol: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "tickers", "name": name, "sector": sector, "symbol": symbol])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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

          public var sector: String? {
            get {
              return resultMap["sector"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "sector")
            }
          }

          public var symbol: String? {
            get {
              return resultMap["symbol"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "symbol")
            }
          }
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
    }
  }
}
