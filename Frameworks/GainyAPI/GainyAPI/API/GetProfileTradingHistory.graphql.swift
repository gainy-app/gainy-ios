// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetProfileTradingHistoryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetProfileTradingHistory($profile_id: Int!, $types: [String!]!) {
      trading_history(
        where: {profile_id: {_eq: $profile_id}, type: {_in: $types}}
        order_by: {datetime: desc}
      ) {
        __typename
        ...TradingHistoryFrag
      }
    }
    """

  public let operationName: String = "GetProfileTradingHistory"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + TradingHistoryFrag.fragmentDefinition)
    return document
  }

  public var profile_id: Int
  public var types: [String]

  public init(profile_id: Int, types: [String]) {
    self.profile_id = profile_id
    self.types = types
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "types": types]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_history", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")], "type": ["_in": GraphQLVariable("types")]], "order_by": ["datetime": "desc"]], type: .nonNull(.list(.nonNull(.object(TradingHistory.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingHistory: [TradingHistory]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "trading_history": tradingHistory.map { (value: TradingHistory) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230111122944.trading_history"
    public var tradingHistory: [TradingHistory] {
      get {
        return (resultMap["trading_history"] as! [ResultMap]).map { (value: ResultMap) -> TradingHistory in TradingHistory(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: TradingHistory) -> ResultMap in value.resultMap }, forKey: "trading_history")
      }
    }

    public struct TradingHistory: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["trading_history"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(TradingHistoryFrag.self),
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

        public var tradingHistoryFrag: TradingHistoryFrag {
          get {
            return TradingHistoryFrag(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct TradingHistoryFrag: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment TradingHistoryFrag on trading_history {
      __typename
      amount
      datetime
      name
      tags
      type
      trading_collection_version {
        __typename
        id
        trading_account {
          __typename
          account_no
        }
        created_at
        status
        target_amount_delta
        weights
      }
      trading_money_flow {
        __typename
        trading_account {
          __typename
          account_no
        }
        created_at
        status
        amount
        id
      }
      trading_order {
        __typename
        id
        trading_account {
          __typename
          account_no
        }
        created_at
        status
        target_amount_delta
      }
    }
    """

  public static let possibleTypes: [String] = ["trading_history"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("amount", type: .scalar(float8.self)),
      GraphQLField("datetime", type: .scalar(timestamptz.self)),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("tags", type: .scalar(json.self)),
      GraphQLField("type", type: .scalar(String.self)),
      GraphQLField("trading_collection_version", type: .object(TradingCollectionVersion.selections)),
      GraphQLField("trading_money_flow", type: .object(TradingMoneyFlow.selections)),
      GraphQLField("trading_order", type: .object(TradingOrder.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(amount: float8? = nil, datetime: timestamptz? = nil, name: String? = nil, tags: json? = nil, type: String? = nil, tradingCollectionVersion: TradingCollectionVersion? = nil, tradingMoneyFlow: TradingMoneyFlow? = nil, tradingOrder: TradingOrder? = nil) {
    self.init(unsafeResultMap: ["__typename": "trading_history", "amount": amount, "datetime": datetime, "name": name, "tags": tags, "type": type, "trading_collection_version": tradingCollectionVersion.flatMap { (value: TradingCollectionVersion) -> ResultMap in value.resultMap }, "trading_money_flow": tradingMoneyFlow.flatMap { (value: TradingMoneyFlow) -> ResultMap in value.resultMap }, "trading_order": tradingOrder.flatMap { (value: TradingOrder) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var amount: float8? {
    get {
      return resultMap["amount"] as? float8
    }
    set {
      resultMap.updateValue(newValue, forKey: "amount")
    }
  }

  public var datetime: timestamptz? {
    get {
      return resultMap["datetime"] as? timestamptz
    }
    set {
      resultMap.updateValue(newValue, forKey: "datetime")
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

  public var tags: json? {
    get {
      return resultMap["tags"] as? json
    }
    set {
      resultMap.updateValue(newValue, forKey: "tags")
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

  /// An object relationship
  public var tradingCollectionVersion: TradingCollectionVersion? {
    get {
      return (resultMap["trading_collection_version"] as? ResultMap).flatMap { TradingCollectionVersion(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "trading_collection_version")
    }
  }

  /// An object relationship
  public var tradingMoneyFlow: TradingMoneyFlow? {
    get {
      return (resultMap["trading_money_flow"] as? ResultMap).flatMap { TradingMoneyFlow(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "trading_money_flow")
    }
  }

  /// An object relationship
  public var tradingOrder: TradingOrder? {
    get {
      return (resultMap["trading_order"] as? ResultMap).flatMap { TradingOrder(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "trading_order")
    }
  }

  public struct TradingCollectionVersion: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["app_trading_collection_versions"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        GraphQLField("trading_account", type: .nonNull(.object(TradingAccount.selections))),
        GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
        GraphQLField("status", type: .scalar(String.self)),
        GraphQLField("target_amount_delta", type: .scalar(numeric.self)),
        GraphQLField("weights", type: .scalar(json.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: Int, tradingAccount: TradingAccount, createdAt: timestamptz, status: String? = nil, targetAmountDelta: numeric? = nil, weights: json? = nil) {
      self.init(unsafeResultMap: ["__typename": "app_trading_collection_versions", "id": id, "trading_account": tradingAccount.resultMap, "created_at": createdAt, "status": status, "target_amount_delta": targetAmountDelta, "weights": weights])
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

    /// An object relationship
    public var tradingAccount: TradingAccount {
      get {
        return TradingAccount(unsafeResultMap: resultMap["trading_account"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "trading_account")
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

    public var status: String? {
      get {
        return resultMap["status"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "status")
      }
    }

    public var targetAmountDelta: numeric? {
      get {
        return resultMap["target_amount_delta"] as? numeric
      }
      set {
        resultMap.updateValue(newValue, forKey: "target_amount_delta")
      }
    }

    public var weights: json? {
      get {
        return resultMap["weights"] as? json
      }
      set {
        resultMap.updateValue(newValue, forKey: "weights")
      }
    }

    public struct TradingAccount: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_trading_accounts"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("account_no", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(accountNo: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "app_trading_accounts", "account_no": accountNo])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var accountNo: String? {
        get {
          return resultMap["account_no"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "account_no")
        }
      }
    }
  }

  public struct TradingMoneyFlow: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["app_trading_money_flow"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("trading_account", type: .nonNull(.object(TradingAccount.selections))),
        GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
        GraphQLField("status", type: .scalar(String.self)),
        GraphQLField("amount", type: .nonNull(.scalar(numeric.self))),
        GraphQLField("id", type: .nonNull(.scalar(Int.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingAccount: TradingAccount, createdAt: timestamptz, status: String? = nil, amount: numeric, id: Int) {
      self.init(unsafeResultMap: ["__typename": "app_trading_money_flow", "trading_account": tradingAccount.resultMap, "created_at": createdAt, "status": status, "amount": amount, "id": id])
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
    public var tradingAccount: TradingAccount {
      get {
        return TradingAccount(unsafeResultMap: resultMap["trading_account"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "trading_account")
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

    public var status: String? {
      get {
        return resultMap["status"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "status")
      }
    }

    public var amount: numeric {
      get {
        return resultMap["amount"]! as! numeric
      }
      set {
        resultMap.updateValue(newValue, forKey: "amount")
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

    public struct TradingAccount: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_trading_accounts"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("account_no", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(accountNo: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "app_trading_accounts", "account_no": accountNo])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var accountNo: String? {
        get {
          return resultMap["account_no"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "account_no")
        }
      }
    }
  }

  public struct TradingOrder: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["app_trading_orders"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        GraphQLField("trading_account", type: .nonNull(.object(TradingAccount.selections))),
        GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
        GraphQLField("status", type: .scalar(String.self)),
        GraphQLField("target_amount_delta", type: .scalar(numeric.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: Int, tradingAccount: TradingAccount, createdAt: timestamptz, status: String? = nil, targetAmountDelta: numeric? = nil) {
      self.init(unsafeResultMap: ["__typename": "app_trading_orders", "id": id, "trading_account": tradingAccount.resultMap, "created_at": createdAt, "status": status, "target_amount_delta": targetAmountDelta])
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

    /// An object relationship
    public var tradingAccount: TradingAccount {
      get {
        return TradingAccount(unsafeResultMap: resultMap["trading_account"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "trading_account")
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

    public var status: String? {
      get {
        return resultMap["status"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "status")
      }
    }

    public var targetAmountDelta: numeric? {
      get {
        return resultMap["target_amount_delta"] as? numeric
      }
      set {
        resultMap.updateValue(newValue, forKey: "target_amount_delta")
      }
    }

    public struct TradingAccount: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_trading_accounts"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("account_no", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(accountNo: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "app_trading_accounts", "account_no": accountNo])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var accountNo: String? {
        get {
          return resultMap["account_no"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "account_no")
        }
      }
    }
  }
}
