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
        ...PortoGains
      }
      profile_holding_groups(where: {profile_id: {_eq: $profileId}}) {
        __typename
        tags(order_by: {priority: desc}) {
          __typename
          collection {
            __typename
            id
            name
          }
          interest {
            __typename
            id
            name
          }
          category {
            __typename
            id
            name
          }
        }
        details {
          __typename
          ltt_quantity_total
          market_capitalization
          next_earnings_date
          purchase_date
          name
          ticker_symbol
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
        symbol
        ticker {
          __typename
          name
          match_score {
            __typename
            match_score
          }
          ...RemoteTickerDetailsFull
        }
        collection {
          __typename
          id
          name
          match_score {
            __typename
            match_score
          }
        }
        holdings {
          __typename
          broker {
            __typename
            name
            uniq_id
          }
          name
          type
        }
      }
    }
    """

  public let operationName: String = "GetPlaidHoldings"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + PortoGains.fragmentDefinition)
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

    /// fetch data from the table: "public_230131134718.portfolio_gains"
    public var portfolioGains: [PortfolioGain] {
      get {
        return (resultMap["portfolio_gains"] as! [ResultMap]).map { (value: ResultMap) -> PortfolioGain in PortfolioGain(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: PortfolioGain) -> ResultMap in value.resultMap }, forKey: "portfolio_gains")
      }
    }

    /// fetch data from the table: "public_230131134718.profile_holding_groups"
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
          GraphQLFragmentSpread(PortoGains.self),
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

        public var portoGains: PortoGains {
          get {
            return PortoGains(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

    public struct ProfileHoldingGroup: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["profile_holding_groups"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("tags", arguments: ["order_by": ["priority": "desc"]], type: .nonNull(.list(.nonNull(.object(Tag.selections))))),
          GraphQLField("details", type: .object(Detail.selections)),
          GraphQLField("gains", type: .object(Gain.selections)),
          GraphQLField("symbol", type: .scalar(String.self)),
          GraphQLField("ticker", type: .object(Ticker.selections)),
          GraphQLField("collection", type: .object(Collection.selections)),
          GraphQLField("holdings", type: .nonNull(.list(.nonNull(.object(Holding.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(tags: [Tag], details: Detail? = nil, gains: Gain? = nil, symbol: String? = nil, ticker: Ticker? = nil, collection: Collection? = nil, holdings: [Holding]) {
        self.init(unsafeResultMap: ["__typename": "profile_holding_groups", "tags": tags.map { (value: Tag) -> ResultMap in value.resultMap }, "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }, "gains": gains.flatMap { (value: Gain) -> ResultMap in value.resultMap }, "symbol": symbol, "ticker": ticker.flatMap { (value: Ticker) -> ResultMap in value.resultMap }, "collection": collection.flatMap { (value: Collection) -> ResultMap in value.resultMap }, "holdings": holdings.map { (value: Holding) -> ResultMap in value.resultMap }])
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

      /// An object relationship
      public var collection: Collection? {
        get {
          return (resultMap["collection"] as? ResultMap).flatMap { Collection(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "collection")
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
              GraphQLField("name", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "collections", "id": id, "name": name])
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

      public struct Detail: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["portfolio_holding_group_details"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("ltt_quantity_total", type: .scalar(float8.self)),
            GraphQLField("market_capitalization", type: .scalar(bigint.self)),
            GraphQLField("next_earnings_date", type: .scalar(timestamp.self)),
            GraphQLField("purchase_date", type: .scalar(timestamp.self)),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("ticker_symbol", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(lttQuantityTotal: float8? = nil, marketCapitalization: bigint? = nil, nextEarningsDate: timestamp? = nil, purchaseDate: timestamp? = nil, name: String? = nil, tickerSymbol: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "portfolio_holding_group_details", "ltt_quantity_total": lttQuantityTotal, "market_capitalization": marketCapitalization, "next_earnings_date": nextEarningsDate, "purchase_date": purchaseDate, "name": name, "ticker_symbol": tickerSymbol])
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

        public var name: String? {
          get {
            return resultMap["name"] as? String
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

      public struct Ticker: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["tickers"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("match_score", type: .object(MatchScore.selections)),
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

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// An object relationship
        public var matchScore: MatchScore? {
          get {
            return (resultMap["match_score"] as? ResultMap).flatMap { MatchScore(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "match_score")
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

        public struct MatchScore: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["app_profile_ticker_match_score"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("match_score", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(matchScore: Int) {
            self.init(unsafeResultMap: ["__typename": "app_profile_ticker_match_score", "match_score": matchScore])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var matchScore: Int {
            get {
              return resultMap["match_score"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "match_score")
            }
          }
        }
      }

      public struct Collection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("match_score", type: .object(MatchScore.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, name: String? = nil, matchScore: MatchScore? = nil) {
          self.init(unsafeResultMap: ["__typename": "collections", "id": id, "name": name, "match_score": matchScore.flatMap { (value: MatchScore) -> ResultMap in value.resultMap }])
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

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// An object relationship
        public var matchScore: MatchScore? {
          get {
            return (resultMap["match_score"] as? ResultMap).flatMap { MatchScore(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "match_score")
          }
        }

        public struct MatchScore: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["collection_match_score"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("match_score", type: .scalar(float8.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(matchScore: float8? = nil) {
            self.init(unsafeResultMap: ["__typename": "collection_match_score", "match_score": matchScore])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var matchScore: float8? {
            get {
              return resultMap["match_score"] as? float8
            }
            set {
              resultMap.updateValue(newValue, forKey: "match_score")
            }
          }
        }
      }

      public struct Holding: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["profile_holdings_normalized"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("broker", type: .object(Broker.selections)),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(broker: Broker? = nil, name: String? = nil, type: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "profile_holdings_normalized", "broker": broker.flatMap { (value: Broker) -> ResultMap in value.resultMap }, "name": name, "type": type])
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

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
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

        public struct Broker: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["portfolio_brokers"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("uniq_id", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String? = nil, uniqId: String) {
            self.init(unsafeResultMap: ["__typename": "portfolio_brokers", "name": name, "uniq_id": uniqId])
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

          public var uniqId: String {
            get {
              return resultMap["uniq_id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "uniq_id")
            }
          }
        }
      }
    }
  }
}

public struct PortoGains: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment PortoGains on portfolio_gains {
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
    """

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
