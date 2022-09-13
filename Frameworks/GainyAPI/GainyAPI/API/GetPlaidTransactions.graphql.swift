// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPlaidTransactionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPlaidTransactions($profileId: Int!) {
      get_portfolio_transactions(profile_id: $profileId) {
        __typename
        id
        quantity
        iso_currency_code
        profile_id
        security_id
        security {
          __typename
          created_at
          iso_currency_code
          id
          name
          ticker_symbol
          tickers {
            __typename
            ...RemoteTickerDetailsFull
          }
          type
          updated_at
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
        amount
        date
        fees
        name
        price
      }
    }
    """

  public let operationName: String = "GetPlaidTransactions"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteTickerDetailsFull.fragmentDefinition)
    document.append("\n" + RemoteTickerDetails.fragmentDefinition)
    return document
  }

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
        GraphQLField("get_portfolio_transactions", arguments: ["profile_id": GraphQLVariable("profileId")], type: .list(.object(GetPortfolioTransaction.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPortfolioTransactions: [GetPortfolioTransaction?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_portfolio_transactions": getPortfolioTransactions.flatMap { (value: [GetPortfolioTransaction?]) -> [ResultMap?] in value.map { (value: GetPortfolioTransaction?) -> ResultMap? in value.flatMap { (value: GetPortfolioTransaction) -> ResultMap in value.resultMap } } }])
    }

    public var getPortfolioTransactions: [GetPortfolioTransaction?]? {
      get {
        return (resultMap["get_portfolio_transactions"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetPortfolioTransaction?] in value.map { (value: ResultMap?) -> GetPortfolioTransaction? in value.flatMap { (value: ResultMap) -> GetPortfolioTransaction in GetPortfolioTransaction(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetPortfolioTransaction?]) -> [ResultMap?] in value.map { (value: GetPortfolioTransaction?) -> ResultMap? in value.flatMap { (value: GetPortfolioTransaction) -> ResultMap in value.resultMap } } }, forKey: "get_portfolio_transactions")
      }
    }

    public struct GetPortfolioTransaction: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PortfolioTransaction"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("quantity", type: .nonNull(.scalar(Double.self))),
          GraphQLField("iso_currency_code", type: .scalar(String.self)),
          GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("security_id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("security", type: .object(Security.selections)),
          GraphQLField("account", type: .object(Account.selections)),
          GraphQLField("amount", type: .nonNull(.scalar(Double.self))),
          GraphQLField("date", type: .nonNull(.scalar(String.self))),
          GraphQLField("fees", type: .nonNull(.scalar(Double.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("price", type: .nonNull(.scalar(Double.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, quantity: Double, isoCurrencyCode: String? = nil, profileId: Int, securityId: Int, security: Security? = nil, account: Account? = nil, amount: Double, date: String, fees: Double, name: String, price: Double) {
        self.init(unsafeResultMap: ["__typename": "PortfolioTransaction", "id": id, "quantity": quantity, "iso_currency_code": isoCurrencyCode, "profile_id": profileId, "security_id": securityId, "security": security.flatMap { (value: Security) -> ResultMap in value.resultMap }, "account": account.flatMap { (value: Account) -> ResultMap in value.resultMap }, "amount": amount, "date": date, "fees": fees, "name": name, "price": price])
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

      public var isoCurrencyCode: String? {
        get {
          return resultMap["iso_currency_code"] as? String
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

      public var security: Security? {
        get {
          return (resultMap["security"] as? ResultMap).flatMap { Security(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "security")
        }
      }

      public var account: Account? {
        get {
          return (resultMap["account"] as? ResultMap).flatMap { Account(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "account")
        }
      }

      public var amount: Double {
        get {
          return resultMap["amount"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "amount")
        }
      }

      public var date: String {
        get {
          return resultMap["date"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "date")
        }
      }

      public var fees: Double {
        get {
          return resultMap["fees"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "fees")
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

      public var price: Double {
        get {
          return resultMap["price"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "price")
        }
      }

      public struct Security: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_portfolio_securities"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
            GraphQLField("iso_currency_code", type: .scalar(String.self)),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("ticker_symbol", type: .scalar(String.self)),
            GraphQLField("tickers", type: .object(Ticker.selections)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("updated_at", type: .nonNull(.scalar(timestamptz.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(createdAt: timestamptz, isoCurrencyCode: String? = nil, id: Int, name: String, tickerSymbol: String? = nil, tickers: Ticker? = nil, type: String? = nil, updatedAt: timestamptz) {
          self.init(unsafeResultMap: ["__typename": "app_portfolio_securities", "created_at": createdAt, "iso_currency_code": isoCurrencyCode, "id": id, "name": name, "ticker_symbol": tickerSymbol, "tickers": tickers.flatMap { (value: Ticker) -> ResultMap in value.resultMap }, "type": type, "updated_at": updatedAt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var isoCurrencyCode: String? {
          get {
            return resultMap["iso_currency_code"] as? String
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

        /// An object relationship
        public var tickers: Ticker? {
          get {
            return (resultMap["tickers"] as? ResultMap).flatMap { Ticker(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "tickers")
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

        public struct Ticker: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["tickers"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(RemoteTickerDetailsFull.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var remoteTickerDetailsFull: RemoteTickerDetailsFull {
              get {
                return RemoteTickerDetailsFull(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
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
