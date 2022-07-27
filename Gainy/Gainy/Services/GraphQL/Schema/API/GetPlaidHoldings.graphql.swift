// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPlaidHoldingsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPlaidHoldings($profileId: Int!) {
      portfolio_gains(where: {profile_id: {_eq: $profileId}}) {
        __typename
        absolute_gain_1d
        absolute_gain_1m
        absolute_gain_1w
        absolute_gain_1y
        absolute_gain_3m
        absolute_gain_5y
        absolute_gain_total
        actual_value
        relative_gain_1d
        relative_gain_1m
        relative_gain_1w
        relative_gain_1y
        relative_gain_3m
        relative_gain_5y
        relative_gain_total
      }
      profile_holding_groups(where: {profile_id: {_eq: $profileId}}) {
        __typename
        tags {
          __typename
          collection {
            __typename
            id
            uniq_id
            name
          }
          interest {
            __typename
            id
            name
            icon_url
          }
          category {
            __typename
            id
            name
            icon_url
            collection_id
          }
        }
        details {
          __typename
          ltt_quantity_total
          market_capitalization
          next_earnings_date
          purchase_date
          relative_gain_1d
          relative_gain_total
          ticker_name
          ticker_symbol
          value_to_portfolio_value
        }
        gains {
          __typename
          absolute_gain_1d
          absolute_gain_1m
          absolute_gain_1w
          absolute_gain_1y
          absolute_gain_3m
          absolute_gain_5y
          absolute_gain_total
          actual_value
          ltt_quantity_total
          relative_gain_1m
          relative_gain_1d
          relative_gain_1w
          relative_gain_1y
          relative_gain_3m
          relative_gain_5y
          relative_gain_total
          value_to_portfolio_value
        }
        holdings {
          __typename
          account_id
          holding_id
          name
          quantity
          ticker_symbol
          type
          holding_details {
            __typename
            holding {
              __typename
              access_token {
                __typename
                institution {
                  __typename
                  id
                  name
                }
              }
            }
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
          gains {
            __typename
            absolute_gain_1d
            absolute_gain_1m
            absolute_gain_1w
            absolute_gain_1y
            absolute_gain_3m
            absolute_gain_5y
            absolute_gain_total
            actual_value
            ltt_quantity_total
            relative_gain_1m
            relative_gain_1d
            relative_gain_1w
            relative_gain_1y
            relative_gain_3m
            relative_gain_5y
            relative_gain_total
            value_to_portfolio_value
          }
        }
        quantity
        symbol
        ticker {
          __typename
          name
          ...RemoteTickerDetailsFull
          realtime_metrics {
            __typename
            absolute_daily_change
            actual_price
            daily_volume
            relative_daily_change
            symbol
            time
          }
        }
      }
    }
    """

  public let operationName: String = "GetPlaidHoldings"

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
        GraphQLField("portfolio_gains", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]]], type: .nonNull(.list(.nonNull(.object(PortfolioGain.selections))))),
        GraphQLField("profile_holding_groups", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]]], type: .nonNull(.list(.nonNull(.object(ProfileHoldingGroup.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(portfolioGains: [PortfolioGain], profileHoldingGroups: [ProfileHoldingGroup]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "portfolio_gains": portfolioGains.map { (value: PortfolioGain) -> ResultMap in value.resultMap }, "profile_holding_groups": profileHoldingGroups.map { (value: ProfileHoldingGroup) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220727102416.portfolio_gains"
    public var portfolioGains: [PortfolioGain] {
      get {
        return (resultMap["portfolio_gains"] as! [ResultMap]).map { (value: ResultMap) -> PortfolioGain in PortfolioGain(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: PortfolioGain) -> ResultMap in value.resultMap }, forKey: "portfolio_gains")
      }
    }

    /// fetch data from the table: "public_220727102416.profile_holding_groups"
    public var profileHoldingGroups: [ProfileHoldingGroup] {
      get {
        return (resultMap["profile_holding_groups"] as! [ResultMap]).map { (value: ResultMap) -> ProfileHoldingGroup in ProfileHoldingGroup(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: ProfileHoldingGroup) -> ResultMap in value.resultMap }, forKey: "profile_holding_groups")
      }
    }

    public struct PortfolioGain: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["portfolio_gains"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("absolute_gain_1d", type: .scalar(float8.self)),
          GraphQLField("absolute_gain_1m", type: .scalar(float8.self)),
          GraphQLField("absolute_gain_1w", type: .scalar(float8.self)),
          GraphQLField("absolute_gain_1y", type: .scalar(float8.self)),
          GraphQLField("absolute_gain_3m", type: .scalar(float8.self)),
          GraphQLField("absolute_gain_5y", type: .scalar(float8.self)),
          GraphQLField("absolute_gain_total", type: .scalar(float8.self)),
          GraphQLField("actual_value", type: .scalar(float8.self)),
          GraphQLField("relative_gain_1d", type: .scalar(float8.self)),
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

      public init(absoluteGain_1d: float8? = nil, absoluteGain_1m: float8? = nil, absoluteGain_1w: float8? = nil, absoluteGain_1y: float8? = nil, absoluteGain_3m: float8? = nil, absoluteGain_5y: float8? = nil, absoluteGainTotal: float8? = nil, actualValue: float8? = nil, relativeGain_1d: float8? = nil, relativeGain_1m: float8? = nil, relativeGain_1w: float8? = nil, relativeGain_1y: float8? = nil, relativeGain_3m: float8? = nil, relativeGain_5y: float8? = nil, relativeGainTotal: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "portfolio_gains", "absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "relative_gain_1d": relativeGain_1d, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var absoluteGain_1d: float8? {
        get {
          return resultMap["absolute_gain_1d"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "absolute_gain_1d")
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

      public var relativeGain_1d: float8? {
        get {
          return resultMap["relative_gain_1d"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "relative_gain_1d")
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

    public struct ProfileHoldingGroup: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["profile_holding_groups"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("tags", type: .nonNull(.list(.nonNull(.object(Tag.selections))))),
          GraphQLField("details", type: .object(Detail.selections)),
          GraphQLField("gains", type: .object(Gain.selections)),
          GraphQLField("holdings", type: .nonNull(.list(.nonNull(.object(Holding.selections))))),
          GraphQLField("quantity", type: .scalar(float8.self)),
          GraphQLField("symbol", type: .scalar(String.self)),
          GraphQLField("ticker", type: .object(Ticker.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(tags: [Tag], details: Detail? = nil, gains: Gain? = nil, holdings: [Holding], quantity: float8? = nil, symbol: String? = nil, ticker: Ticker? = nil) {
        self.init(unsafeResultMap: ["__typename": "profile_holding_groups", "tags": tags.map { (value: Tag) -> ResultMap in value.resultMap }, "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }, "gains": gains.flatMap { (value: Gain) -> ResultMap in value.resultMap }, "holdings": holdings.map { (value: Holding) -> ResultMap in value.resultMap }, "quantity": quantity, "symbol": symbol, "ticker": ticker.flatMap { (value: Ticker) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// An array relationship
      public var tags: [Tag] {
        get {
          return (resultMap["tags"] as! [ResultMap]).map { (value: ResultMap) -> Tag in Tag(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Tag) -> ResultMap in value.resultMap }, forKey: "tags")
        }
      }

      /// An object relationship
      public var details: Detail? {
        get {
          return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "details")
        }
      }

      /// An object relationship
      public var gains: Gain? {
        get {
          return (resultMap["gains"] as? ResultMap).flatMap { Gain(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "gains")
        }
      }

      /// An array relationship
      public var holdings: [Holding] {
        get {
          return (resultMap["holdings"] as! [ResultMap]).map { (value: ResultMap) -> Holding in Holding(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Holding) -> ResultMap in value.resultMap }, forKey: "holdings")
        }
      }

      public var quantity: float8? {
        get {
          return resultMap["quantity"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "quantity")
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

      /// An object relationship
      public var ticker: Ticker? {
        get {
          return (resultMap["ticker"] as? ResultMap).flatMap { Ticker(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "ticker")
        }
      }

      public struct Tag: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["portfolio_holding_group_tags"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("collection", type: .object(Collection.selections)),
            GraphQLField("interest", type: .object(Interest.selections)),
            GraphQLField("category", type: .object(Category.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(collection: Collection? = nil, interest: Interest? = nil, category: Category? = nil) {
          self.init(unsafeResultMap: ["__typename": "portfolio_holding_group_tags", "collection": collection.flatMap { (value: Collection) -> ResultMap in value.resultMap }, "interest": interest.flatMap { (value: Interest) -> ResultMap in value.resultMap }, "category": category.flatMap { (value: Category) -> ResultMap in value.resultMap }])
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
        public var collection: Collection? {
          get {
            return (resultMap["collection"] as? ResultMap).flatMap { Collection(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "collection")
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

        /// An object relationship
        public var category: Category? {
          get {
            return (resultMap["category"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "category")
          }
        }

        public struct Collection: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["collections"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("uniq_id", type: .scalar(String.self)),
              GraphQLField("name", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, uniqId: String? = nil, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "collections", "id": id, "uniq_id": uniqId, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var uniqId: String? {
            get {
              return resultMap["uniq_id"] as? String
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

        public struct Interest: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["interests"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(Int.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("icon_url", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, name: String? = nil, iconUrl: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "interests", "id": id, "name": name, "icon_url": iconUrl])
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

          public var iconUrl: String? {
            get {
              return resultMap["icon_url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "icon_url")
            }
          }
        }

        public struct Category: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["categories"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(Int.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("icon_url", type: .scalar(String.self)),
              GraphQLField("collection_id", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, name: String? = nil, iconUrl: String? = nil, collectionId: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "categories", "id": id, "name": name, "icon_url": iconUrl, "collection_id": collectionId])
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

          public var iconUrl: String? {
            get {
              return resultMap["icon_url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "icon_url")
            }
          }

          public var collectionId: Int? {
            get {
              return resultMap["collection_id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "collection_id")
            }
          }
        }
      }

      public struct Detail: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["portfolio_holding_group_details"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("ltt_quantity_total", type: .scalar(float8.self)),
            GraphQLField("market_capitalization", type: .scalar(bigint.self)),
            GraphQLField("next_earnings_date", type: .scalar(timestamp.self)),
            GraphQLField("purchase_date", type: .scalar(timestamp.self)),
            GraphQLField("relative_gain_1d", type: .scalar(float8.self)),
            GraphQLField("relative_gain_total", type: .scalar(float8.self)),
            GraphQLField("ticker_name", type: .scalar(String.self)),
            GraphQLField("ticker_symbol", type: .scalar(String.self)),
            GraphQLField("value_to_portfolio_value", type: .scalar(float8.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(lttQuantityTotal: float8? = nil, marketCapitalization: bigint? = nil, nextEarningsDate: timestamp? = nil, purchaseDate: timestamp? = nil, relativeGain_1d: float8? = nil, relativeGainTotal: float8? = nil, tickerName: String? = nil, tickerSymbol: String? = nil, valueToPortfolioValue: float8? = nil) {
          self.init(unsafeResultMap: ["__typename": "portfolio_holding_group_details", "ltt_quantity_total": lttQuantityTotal, "market_capitalization": marketCapitalization, "next_earnings_date": nextEarningsDate, "purchase_date": purchaseDate, "relative_gain_1d": relativeGain_1d, "relative_gain_total": relativeGainTotal, "ticker_name": tickerName, "ticker_symbol": tickerSymbol, "value_to_portfolio_value": valueToPortfolioValue])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var purchaseDate: timestamp? {
          get {
            return resultMap["purchase_date"] as? timestamp
          }
          set {
            resultMap.updateValue(newValue, forKey: "purchase_date")
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

        public var relativeGainTotal: float8? {
          get {
            return resultMap["relative_gain_total"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "relative_gain_total")
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

        public var tickerSymbol: String? {
          get {
            return resultMap["ticker_symbol"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "ticker_symbol")
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
      }

      public struct Gain: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["portfolio_holding_group_gains"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("absolute_gain_1d", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_1m", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_1w", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_1y", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_3m", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_5y", type: .scalar(float8.self)),
            GraphQLField("absolute_gain_total", type: .scalar(float8.self)),
            GraphQLField("actual_value", type: .scalar(float8.self)),
            GraphQLField("ltt_quantity_total", type: .scalar(float8.self)),
            GraphQLField("relative_gain_1m", type: .scalar(float8.self)),
            GraphQLField("relative_gain_1d", type: .scalar(float8.self)),
            GraphQLField("relative_gain_1w", type: .scalar(float8.self)),
            GraphQLField("relative_gain_1y", type: .scalar(float8.self)),
            GraphQLField("relative_gain_3m", type: .scalar(float8.self)),
            GraphQLField("relative_gain_5y", type: .scalar(float8.self)),
            GraphQLField("relative_gain_total", type: .scalar(float8.self)),
            GraphQLField("value_to_portfolio_value", type: .scalar(float8.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(absoluteGain_1d: float8? = nil, absoluteGain_1m: float8? = nil, absoluteGain_1w: float8? = nil, absoluteGain_1y: float8? = nil, absoluteGain_3m: float8? = nil, absoluteGain_5y: float8? = nil, absoluteGainTotal: float8? = nil, actualValue: float8? = nil, lttQuantityTotal: float8? = nil, relativeGain_1m: float8? = nil, relativeGain_1d: float8? = nil, relativeGain_1w: float8? = nil, relativeGain_1y: float8? = nil, relativeGain_3m: float8? = nil, relativeGain_5y: float8? = nil, relativeGainTotal: float8? = nil, valueToPortfolioValue: float8? = nil) {
          self.init(unsafeResultMap: ["__typename": "portfolio_holding_group_gains", "absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "ltt_quantity_total": lttQuantityTotal, "relative_gain_1m": relativeGain_1m, "relative_gain_1d": relativeGain_1d, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "value_to_portfolio_value": valueToPortfolioValue])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var absoluteGain_1d: float8? {
          get {
            return resultMap["absolute_gain_1d"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "absolute_gain_1d")
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

        public var lttQuantityTotal: float8? {
          get {
            return resultMap["ltt_quantity_total"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "ltt_quantity_total")
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

        public var relativeGain_1d: float8? {
          get {
            return resultMap["relative_gain_1d"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "relative_gain_1d")
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
      }

      public struct Holding: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["profile_holdings_normalized"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("account_id", type: .scalar(Int.self)),
            GraphQLField("holding_id", type: .scalar(Int.self)),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("quantity", type: .scalar(float8.self)),
            GraphQLField("ticker_symbol", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("holding_details", type: .object(HoldingDetail.selections)),
            GraphQLField("gains", type: .object(Gain.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(accountId: Int? = nil, holdingId: Int? = nil, name: String? = nil, quantity: float8? = nil, tickerSymbol: String? = nil, type: String? = nil, holdingDetails: HoldingDetail? = nil, gains: Gain? = nil) {
          self.init(unsafeResultMap: ["__typename": "profile_holdings_normalized", "account_id": accountId, "holding_id": holdingId, "name": name, "quantity": quantity, "ticker_symbol": tickerSymbol, "type": type, "holding_details": holdingDetails.flatMap { (value: HoldingDetail) -> ResultMap in value.resultMap }, "gains": gains.flatMap { (value: Gain) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var holdingId: Int? {
          get {
            return resultMap["holding_id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "holding_id")
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

        public var quantity: float8? {
          get {
            return resultMap["quantity"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "quantity")
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

        /// An object relationship
        public var holdingDetails: HoldingDetail? {
          get {
            return (resultMap["holding_details"] as? ResultMap).flatMap { HoldingDetail(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "holding_details")
          }
        }

        /// An object relationship
        public var gains: Gain? {
          get {
            return (resultMap["gains"] as? ResultMap).flatMap { Gain(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "gains")
          }
        }

        public struct HoldingDetail: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["portfolio_holding_details"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("holding", type: .object(Holding.selections)),
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

          public init(holding: Holding? = nil, purchaseDate: timestamp? = nil, relativeGainTotal: float8? = nil, relativeGain_1d: float8? = nil, valueToPortfolioValue: float8? = nil, tickerName: String? = nil, marketCapitalization: bigint? = nil, nextEarningsDate: timestamp? = nil, lttQuantityTotal: float8? = nil, securityType: String? = nil, accountId: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "portfolio_holding_details", "holding": holding.flatMap { (value: Holding) -> ResultMap in value.resultMap }, "purchase_date": purchaseDate, "relative_gain_total": relativeGainTotal, "relative_gain_1d": relativeGain_1d, "value_to_portfolio_value": valueToPortfolioValue, "ticker_name": tickerName, "market_capitalization": marketCapitalization, "next_earnings_date": nextEarningsDate, "ltt_quantity_total": lttQuantityTotal, "security_type": securityType, "account_id": accountId])
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
          public var holding: Holding? {
            get {
              return (resultMap["holding"] as? ResultMap).flatMap { Holding(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "holding")
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

          public struct Holding: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["app_profile_holdings"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("access_token", type: .object(AccessToken.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(accessToken: AccessToken? = nil) {
              self.init(unsafeResultMap: ["__typename": "app_profile_holdings", "access_token": accessToken.flatMap { (value: AccessToken) -> ResultMap in value.resultMap }])
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
            public var accessToken: AccessToken? {
              get {
                return (resultMap["access_token"] as? ResultMap).flatMap { AccessToken(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "access_token")
              }
            }

            public struct AccessToken: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["app_profile_plaid_access_tokens"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("institution", type: .object(Institution.selections)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(institution: Institution? = nil) {
                self.init(unsafeResultMap: ["__typename": "app_profile_plaid_access_tokens", "institution": institution.flatMap { (value: Institution) -> ResultMap in value.resultMap }])
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
              public var institution: Institution? {
                get {
                  return (resultMap["institution"] as? ResultMap).flatMap { Institution(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "institution")
                }
              }

              public struct Institution: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["app_plaid_institutions"]

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
                  self.init(unsafeResultMap: ["__typename": "app_plaid_institutions", "id": id, "name": name])
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

        public struct Gain: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["portfolio_holding_gains"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("absolute_gain_1d", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_1m", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_1w", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_1y", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_3m", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_5y", type: .scalar(float8.self)),
              GraphQLField("absolute_gain_total", type: .scalar(float8.self)),
              GraphQLField("actual_value", type: .scalar(float8.self)),
              GraphQLField("ltt_quantity_total", type: .scalar(float8.self)),
              GraphQLField("relative_gain_1m", type: .scalar(float8.self)),
              GraphQLField("relative_gain_1d", type: .scalar(float8.self)),
              GraphQLField("relative_gain_1w", type: .scalar(float8.self)),
              GraphQLField("relative_gain_1y", type: .scalar(float8.self)),
              GraphQLField("relative_gain_3m", type: .scalar(float8.self)),
              GraphQLField("relative_gain_5y", type: .scalar(float8.self)),
              GraphQLField("relative_gain_total", type: .scalar(float8.self)),
              GraphQLField("value_to_portfolio_value", type: .scalar(float8.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(absoluteGain_1d: float8? = nil, absoluteGain_1m: float8? = nil, absoluteGain_1w: float8? = nil, absoluteGain_1y: float8? = nil, absoluteGain_3m: float8? = nil, absoluteGain_5y: float8? = nil, absoluteGainTotal: float8? = nil, actualValue: float8? = nil, lttQuantityTotal: float8? = nil, relativeGain_1m: float8? = nil, relativeGain_1d: float8? = nil, relativeGain_1w: float8? = nil, relativeGain_1y: float8? = nil, relativeGain_3m: float8? = nil, relativeGain_5y: float8? = nil, relativeGainTotal: float8? = nil, valueToPortfolioValue: float8? = nil) {
            self.init(unsafeResultMap: ["__typename": "portfolio_holding_gains", "absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "ltt_quantity_total": lttQuantityTotal, "relative_gain_1m": relativeGain_1m, "relative_gain_1d": relativeGain_1d, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "value_to_portfolio_value": valueToPortfolioValue])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var absoluteGain_1d: float8? {
            get {
              return resultMap["absolute_gain_1d"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "absolute_gain_1d")
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

          public var lttQuantityTotal: float8? {
            get {
              return resultMap["ltt_quantity_total"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "ltt_quantity_total")
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

          public var relativeGain_1d: float8? {
            get {
              return resultMap["relative_gain_1d"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "relative_gain_1d")
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
        }
      }

      public struct Ticker: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["tickers"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLFragmentSpread(RemoteTickerDetailsFull.self),
            GraphQLField("realtime_metrics", type: .object(RealtimeMetric.selections)),
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

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// An object relationship
        public var realtimeMetrics: RealtimeMetric? {
          get {
            return (resultMap["realtime_metrics"] as? ResultMap).flatMap { RealtimeMetric(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "realtime_metrics")
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

        public struct RealtimeMetric: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ticker_realtime_metrics"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("absolute_daily_change", type: .scalar(float8.self)),
              GraphQLField("actual_price", type: .scalar(float8.self)),
              GraphQLField("daily_volume", type: .scalar(float8.self)),
              GraphQLField("relative_daily_change", type: .scalar(float8.self)),
              GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
              GraphQLField("time", type: .scalar(timestamp.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(absoluteDailyChange: float8? = nil, actualPrice: float8? = nil, dailyVolume: float8? = nil, relativeDailyChange: float8? = nil, symbol: String, time: timestamp? = nil) {
            self.init(unsafeResultMap: ["__typename": "ticker_realtime_metrics", "absolute_daily_change": absoluteDailyChange, "actual_price": actualPrice, "daily_volume": dailyVolume, "relative_daily_change": relativeDailyChange, "symbol": symbol, "time": time])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var absoluteDailyChange: float8? {
            get {
              return resultMap["absolute_daily_change"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "absolute_daily_change")
            }
          }

          public var actualPrice: float8? {
            get {
              return resultMap["actual_price"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "actual_price")
            }
          }

          public var dailyVolume: float8? {
            get {
              return resultMap["daily_volume"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "daily_volume")
            }
          }

          public var relativeDailyChange: float8? {
            get {
              return resultMap["relative_daily_change"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "relative_daily_change")
            }
          }

          public var symbol: String {
            get {
              return resultMap["symbol"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "symbol")
            }
          }

          public var time: timestamp? {
            get {
              return resultMap["time"] as? timestamp
            }
            set {
              resultMap.updateValue(newValue, forKey: "time")
            }
          }
        }
      }
    }
  }
}
