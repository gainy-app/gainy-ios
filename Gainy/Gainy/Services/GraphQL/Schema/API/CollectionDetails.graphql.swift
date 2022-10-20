// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DiscoverCollectionDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query DiscoverCollectionDetails($offset: Int!) {
      collections(limit: 20, offset: $offset, where: {enabled: {_eq: "1"}}) {
        __typename
        ...RemoteCollectionDetails
      }
    }
    """

  public let operationName: String = "DiscoverCollectionDetails"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteCollectionDetails.fragmentDefinition)
    return document
  }

  public var offset: Int

  public init(offset: Int) {
    self.offset = offset
  }

  public var variables: GraphQLMap? {
    return ["offset": offset]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("collections", arguments: ["limit": 20, "offset": GraphQLVariable("offset"), "where": ["enabled": ["_eq": "1"]]], type: .nonNull(.list(.nonNull(.object(Collection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collections: [Collection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collections": collections.map { (value: Collection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_221013095638.profile_collections"
    public var collections: [Collection] {
      get {
        return (resultMap["collections"] as! [ResultMap]).map { (value: ResultMap) -> Collection in Collection(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Collection) -> ResultMap in value.resultMap }, forKey: "collections")
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collections"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(RemoteCollectionDetails.self),
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

        public var remoteCollectionDetails: RemoteCollectionDetails {
          get {
            return RemoteCollectionDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct RemoteCollectionDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RemoteCollectionDetails on collections {
      __typename
      id
      uniq_id
      name
      image_url
      description
      size
      enabled
      metrics {
        __typename
        absolute_daily_change
        profile_id
        relative_daily_change
        updated_at
        previous_day_close_price
        market_capitalization_sum
      }
      match_score {
        __typename
        match_score
        risk_level
        risk_similarity
        interest_level
        interest_similarity
        category_level
        category_similarity
      }
    }
    """

  public static let possibleTypes: [String] = ["collections"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .scalar(Int.self)),
      GraphQLField("uniq_id", type: .scalar(String.self)),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("image_url", type: .scalar(String.self)),
      GraphQLField("description", type: .scalar(String.self)),
      GraphQLField("size", type: .scalar(Int.self)),
      GraphQLField("enabled", type: .scalar(String.self)),
      GraphQLField("metrics", type: .object(Metric.selections)),
      GraphQLField("match_score", type: .object(MatchScore.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: Int? = nil, uniqId: String? = nil, name: String? = nil, imageUrl: String? = nil, description: String? = nil, size: Int? = nil, enabled: String? = nil, metrics: Metric? = nil, matchScore: MatchScore? = nil) {
    self.init(unsafeResultMap: ["__typename": "collections", "id": id, "uniq_id": uniqId, "name": name, "image_url": imageUrl, "description": description, "size": size, "enabled": enabled, "metrics": metrics.flatMap { (value: Metric) -> ResultMap in value.resultMap }, "match_score": matchScore.flatMap { (value: MatchScore) -> ResultMap in value.resultMap }])
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

  public var imageUrl: String? {
    get {
      return resultMap["image_url"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "image_url")
    }
  }

  public var description: String? {
    get {
      return resultMap["description"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }

  public var size: Int? {
    get {
      return resultMap["size"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "size")
    }
  }

  public var enabled: String? {
    get {
      return resultMap["enabled"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "enabled")
    }
  }

  /// An object relationship
  public var metrics: Metric? {
    get {
      return (resultMap["metrics"] as? ResultMap).flatMap { Metric(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "metrics")
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

  public struct Metric: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["collection_metrics"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("absolute_daily_change", type: .scalar(float8.self)),
        GraphQLField("profile_id", type: .scalar(Int.self)),
        GraphQLField("relative_daily_change", type: .scalar(float8.self)),
        GraphQLField("updated_at", type: .scalar(timestamptz.self)),
        GraphQLField("previous_day_close_price", type: .scalar(float8.self)),
        GraphQLField("market_capitalization_sum", type: .scalar(bigint.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(absoluteDailyChange: float8? = nil, profileId: Int? = nil, relativeDailyChange: float8? = nil, updatedAt: timestamptz? = nil, previousDayClosePrice: float8? = nil, marketCapitalizationSum: bigint? = nil) {
      self.init(unsafeResultMap: ["__typename": "collection_metrics", "absolute_daily_change": absoluteDailyChange, "profile_id": profileId, "relative_daily_change": relativeDailyChange, "updated_at": updatedAt, "previous_day_close_price": previousDayClosePrice, "market_capitalization_sum": marketCapitalizationSum])
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

    public var profileId: Int? {
      get {
        return resultMap["profile_id"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "profile_id")
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

    public var updatedAt: timestamptz? {
      get {
        return resultMap["updated_at"] as? timestamptz
      }
      set {
        resultMap.updateValue(newValue, forKey: "updated_at")
      }
    }

    public var previousDayClosePrice: float8? {
      get {
        return resultMap["previous_day_close_price"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "previous_day_close_price")
      }
    }

    public var marketCapitalizationSum: bigint? {
      get {
        return resultMap["market_capitalization_sum"] as? bigint
      }
      set {
        resultMap.updateValue(newValue, forKey: "market_capitalization_sum")
      }
    }
  }

  public struct MatchScore: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["collection_match_score"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("match_score", type: .scalar(float8.self)),
        GraphQLField("risk_level", type: .scalar(Int.self)),
        GraphQLField("risk_similarity", type: .scalar(float8.self)),
        GraphQLField("interest_level", type: .scalar(Int.self)),
        GraphQLField("interest_similarity", type: .scalar(float8.self)),
        GraphQLField("category_level", type: .scalar(Int.self)),
        GraphQLField("category_similarity", type: .scalar(float8.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(matchScore: float8? = nil, riskLevel: Int? = nil, riskSimilarity: float8? = nil, interestLevel: Int? = nil, interestSimilarity: float8? = nil, categoryLevel: Int? = nil, categorySimilarity: float8? = nil) {
      self.init(unsafeResultMap: ["__typename": "collection_match_score", "match_score": matchScore, "risk_level": riskLevel, "risk_similarity": riskSimilarity, "interest_level": interestLevel, "interest_similarity": interestSimilarity, "category_level": categoryLevel, "category_similarity": categorySimilarity])
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

    public var riskLevel: Int? {
      get {
        return resultMap["risk_level"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "risk_level")
      }
    }

    public var riskSimilarity: float8? {
      get {
        return resultMap["risk_similarity"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "risk_similarity")
      }
    }

    public var interestLevel: Int? {
      get {
        return resultMap["interest_level"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "interest_level")
      }
    }

    public var interestSimilarity: float8? {
      get {
        return resultMap["interest_similarity"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "interest_similarity")
      }
    }

    public var categoryLevel: Int? {
      get {
        return resultMap["category_level"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "category_level")
      }
    }

    public var categorySimilarity: float8? {
      get {
        return resultMap["category_similarity"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "category_similarity")
      }
    }
  }
}

public struct RemoteTickerDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RemoteTickerDetails on tickers {
      __typename
      symbol
      name
      description
      type
      ticker_highlights {
        __typename
        highlight
      }
      ticker_metrics {
        __typename
        profit_margin
        avg_volume_10d
        short_percent_outstanding
        shares_outstanding
        avg_volume_90d
        shares_float
        short_ratio
        beta
        absolute_historical_volatility_adjusted_current
        relative_historical_volatility_adjusted_current
        absolute_historical_volatility_adjusted_min_1y
        absolute_historical_volatility_adjusted_max_1y
        relative_historical_volatility_adjusted_min_1y
        relative_historical_volatility_adjusted_max_1y
        implied_volatility
        revenue_growth_yoy
        revenue_growth_fwd
        ebitda_growth_yoy
        eps_growth_yoy
        eps_growth_fwd
        address_city
        address_state
        address_county
        address_full
        exchange_name
        market_capitalization
        enterprise_value_to_sales
        price_to_earnings_ttm
        price_to_sales_ttm
        price_to_book_value
        enterprise_value_to_ebitda
        price_change_1m
        price_change_3m
        price_change_1y
        dividend_yield
        dividends_per_share
        dividend_payout_ratio
        years_of_consecutive_dividend_growth
        dividend_frequency
        eps_actual
        eps_estimate
        beaten_quarterly_eps_estimation_count_ttm
        eps_surprise
        revenue_estimate_avg_0y
        revenue_actual
        revenue_ttm
        revenue_per_share_ttm
        net_income
        roi
        asset_cash_and_equivalents
        roa
        total_assets
        ebitda
        net_debt
        price_change_1m
        price_change_1w
        price_change_1y
        price_change_3m
        price_change_5y
        price_change_all
      }
      realtime_metrics {
        __typename
        actual_price
        relative_daily_change
        time
        symbol
        last_known_price
        last_known_price_datetime
        previous_day_close_price
      }
      match_score {
        __typename
        category_matches
        fits_categories
        fits_interests
        fits_risk
        interest_matches
        match_score
        risk_similarity
        symbol
      }
    }
    """

  public static let possibleTypes: [String] = ["tickers"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("description", type: .scalar(String.self)),
      GraphQLField("type", type: .scalar(String.self)),
      GraphQLField("ticker_highlights", type: .nonNull(.list(.nonNull(.object(TickerHighlight.selections))))),
      GraphQLField("ticker_metrics", type: .object(TickerMetric.selections)),
      GraphQLField("realtime_metrics", type: .object(RealtimeMetric.selections)),
      GraphQLField("match_score", type: .object(MatchScore.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(symbol: String, name: String? = nil, description: String? = nil, type: String? = nil, tickerHighlights: [TickerHighlight], tickerMetrics: TickerMetric? = nil, realtimeMetrics: RealtimeMetric? = nil, matchScore: MatchScore? = nil) {
    self.init(unsafeResultMap: ["__typename": "tickers", "symbol": symbol, "name": name, "description": description, "type": type, "ticker_highlights": tickerHighlights.map { (value: TickerHighlight) -> ResultMap in value.resultMap }, "ticker_metrics": tickerMetrics.flatMap { (value: TickerMetric) -> ResultMap in value.resultMap }, "realtime_metrics": realtimeMetrics.flatMap { (value: RealtimeMetric) -> ResultMap in value.resultMap }, "match_score": matchScore.flatMap { (value: MatchScore) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
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

  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var description: String? {
    get {
      return resultMap["description"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
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

  /// An array relationship
  public var tickerHighlights: [TickerHighlight] {
    get {
      return (resultMap["ticker_highlights"] as! [ResultMap]).map { (value: ResultMap) -> TickerHighlight in TickerHighlight(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: TickerHighlight) -> ResultMap in value.resultMap }, forKey: "ticker_highlights")
    }
  }

  /// An object relationship
  public var tickerMetrics: TickerMetric? {
    get {
      return (resultMap["ticker_metrics"] as? ResultMap).flatMap { TickerMetric(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "ticker_metrics")
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

  /// An object relationship
  public var matchScore: MatchScore? {
    get {
      return (resultMap["match_score"] as? ResultMap).flatMap { MatchScore(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "match_score")
    }
  }

  public struct TickerHighlight: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_highlights"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("highlight", type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(highlight: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_highlights", "highlight": highlight])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var highlight: String? {
      get {
        return resultMap["highlight"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "highlight")
      }
    }
  }

  public struct TickerMetric: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_metrics"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("profit_margin", type: .scalar(float8.self)),
        GraphQLField("avg_volume_10d", type: .scalar(float8.self)),
        GraphQLField("short_percent_outstanding", type: .scalar(float8.self)),
        GraphQLField("shares_outstanding", type: .scalar(bigint.self)),
        GraphQLField("avg_volume_90d", type: .scalar(float8.self)),
        GraphQLField("shares_float", type: .scalar(bigint.self)),
        GraphQLField("short_ratio", type: .scalar(float8.self)),
        GraphQLField("beta", type: .scalar(float8.self)),
        GraphQLField("absolute_historical_volatility_adjusted_current", type: .scalar(float8.self)),
        GraphQLField("relative_historical_volatility_adjusted_current", type: .scalar(float8.self)),
        GraphQLField("absolute_historical_volatility_adjusted_min_1y", type: .scalar(float8.self)),
        GraphQLField("absolute_historical_volatility_adjusted_max_1y", type: .scalar(float8.self)),
        GraphQLField("relative_historical_volatility_adjusted_min_1y", type: .scalar(float8.self)),
        GraphQLField("relative_historical_volatility_adjusted_max_1y", type: .scalar(float8.self)),
        GraphQLField("implied_volatility", type: .scalar(float8.self)),
        GraphQLField("revenue_growth_yoy", type: .scalar(float8.self)),
        GraphQLField("revenue_growth_fwd", type: .scalar(float8.self)),
        GraphQLField("ebitda_growth_yoy", type: .scalar(float8.self)),
        GraphQLField("eps_growth_yoy", type: .scalar(float8.self)),
        GraphQLField("eps_growth_fwd", type: .scalar(float8.self)),
        GraphQLField("address_city", type: .scalar(String.self)),
        GraphQLField("address_state", type: .scalar(String.self)),
        GraphQLField("address_county", type: .scalar(String.self)),
        GraphQLField("address_full", type: .scalar(String.self)),
        GraphQLField("exchange_name", type: .scalar(String.self)),
        GraphQLField("market_capitalization", type: .scalar(bigint.self)),
        GraphQLField("enterprise_value_to_sales", type: .scalar(float8.self)),
        GraphQLField("price_to_earnings_ttm", type: .scalar(float8.self)),
        GraphQLField("price_to_sales_ttm", type: .scalar(float8.self)),
        GraphQLField("price_to_book_value", type: .scalar(float8.self)),
        GraphQLField("enterprise_value_to_ebitda", type: .scalar(float8.self)),
        GraphQLField("price_change_1m", type: .scalar(float8.self)),
        GraphQLField("price_change_3m", type: .scalar(float8.self)),
        GraphQLField("price_change_1y", type: .scalar(float8.self)),
        GraphQLField("dividend_yield", type: .scalar(float8.self)),
        GraphQLField("dividends_per_share", type: .scalar(float8.self)),
        GraphQLField("dividend_payout_ratio", type: .scalar(float8.self)),
        GraphQLField("years_of_consecutive_dividend_growth", type: .scalar(Int.self)),
        GraphQLField("dividend_frequency", type: .scalar(String.self)),
        GraphQLField("eps_actual", type: .scalar(float8.self)),
        GraphQLField("eps_estimate", type: .scalar(float8.self)),
        GraphQLField("beaten_quarterly_eps_estimation_count_ttm", type: .scalar(Int.self)),
        GraphQLField("eps_surprise", type: .scalar(float8.self)),
        GraphQLField("revenue_estimate_avg_0y", type: .scalar(float8.self)),
        GraphQLField("revenue_actual", type: .scalar(float8.self)),
        GraphQLField("revenue_ttm", type: .scalar(float8.self)),
        GraphQLField("revenue_per_share_ttm", type: .scalar(float8.self)),
        GraphQLField("net_income", type: .scalar(float8.self)),
        GraphQLField("roi", type: .scalar(float8.self)),
        GraphQLField("asset_cash_and_equivalents", type: .scalar(float8.self)),
        GraphQLField("roa", type: .scalar(float8.self)),
        GraphQLField("total_assets", type: .scalar(float8.self)),
        GraphQLField("ebitda", type: .scalar(float8.self)),
        GraphQLField("net_debt", type: .scalar(float8.self)),
        GraphQLField("price_change_1m", type: .scalar(float8.self)),
        GraphQLField("price_change_1w", type: .scalar(float8.self)),
        GraphQLField("price_change_1y", type: .scalar(float8.self)),
        GraphQLField("price_change_3m", type: .scalar(float8.self)),
        GraphQLField("price_change_5y", type: .scalar(float8.self)),
        GraphQLField("price_change_all", type: .scalar(float8.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(profitMargin: float8? = nil, avgVolume_10d: float8? = nil, shortPercentOutstanding: float8? = nil, sharesOutstanding: bigint? = nil, avgVolume_90d: float8? = nil, sharesFloat: bigint? = nil, shortRatio: float8? = nil, beta: float8? = nil, absoluteHistoricalVolatilityAdjustedCurrent: float8? = nil, relativeHistoricalVolatilityAdjustedCurrent: float8? = nil, absoluteHistoricalVolatilityAdjustedMin_1y: float8? = nil, absoluteHistoricalVolatilityAdjustedMax_1y: float8? = nil, relativeHistoricalVolatilityAdjustedMin_1y: float8? = nil, relativeHistoricalVolatilityAdjustedMax_1y: float8? = nil, impliedVolatility: float8? = nil, revenueGrowthYoy: float8? = nil, revenueGrowthFwd: float8? = nil, ebitdaGrowthYoy: float8? = nil, epsGrowthYoy: float8? = nil, epsGrowthFwd: float8? = nil, addressCity: String? = nil, addressState: String? = nil, addressCounty: String? = nil, addressFull: String? = nil, exchangeName: String? = nil, marketCapitalization: bigint? = nil, enterpriseValueToSales: float8? = nil, priceToEarningsTtm: float8? = nil, priceToSalesTtm: float8? = nil, priceToBookValue: float8? = nil, enterpriseValueToEbitda: float8? = nil, priceChange_1m: float8? = nil, priceChange_3m: float8? = nil, priceChange_1y: float8? = nil, dividendYield: float8? = nil, dividendsPerShare: float8? = nil, dividendPayoutRatio: float8? = nil, yearsOfConsecutiveDividendGrowth: Int? = nil, dividendFrequency: String? = nil, epsActual: float8? = nil, epsEstimate: float8? = nil, beatenQuarterlyEpsEstimationCountTtm: Int? = nil, epsSurprise: float8? = nil, revenueEstimateAvg_0y: float8? = nil, revenueActual: float8? = nil, revenueTtm: float8? = nil, revenuePerShareTtm: float8? = nil, netIncome: float8? = nil, roi: float8? = nil, assetCashAndEquivalents: float8? = nil, roa: float8? = nil, totalAssets: float8? = nil, ebitda: float8? = nil, netDebt: float8? = nil, priceChange_1w: float8? = nil, priceChange_5y: float8? = nil, priceChangeAll: float8? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_metrics", "profit_margin": profitMargin, "avg_volume_10d": avgVolume_10d, "short_percent_outstanding": shortPercentOutstanding, "shares_outstanding": sharesOutstanding, "avg_volume_90d": avgVolume_90d, "shares_float": sharesFloat, "short_ratio": shortRatio, "beta": beta, "absolute_historical_volatility_adjusted_current": absoluteHistoricalVolatilityAdjustedCurrent, "relative_historical_volatility_adjusted_current": relativeHistoricalVolatilityAdjustedCurrent, "absolute_historical_volatility_adjusted_min_1y": absoluteHistoricalVolatilityAdjustedMin_1y, "absolute_historical_volatility_adjusted_max_1y": absoluteHistoricalVolatilityAdjustedMax_1y, "relative_historical_volatility_adjusted_min_1y": relativeHistoricalVolatilityAdjustedMin_1y, "relative_historical_volatility_adjusted_max_1y": relativeHistoricalVolatilityAdjustedMax_1y, "implied_volatility": impliedVolatility, "revenue_growth_yoy": revenueGrowthYoy, "revenue_growth_fwd": revenueGrowthFwd, "ebitda_growth_yoy": ebitdaGrowthYoy, "eps_growth_yoy": epsGrowthYoy, "eps_growth_fwd": epsGrowthFwd, "address_city": addressCity, "address_state": addressState, "address_county": addressCounty, "address_full": addressFull, "exchange_name": exchangeName, "market_capitalization": marketCapitalization, "enterprise_value_to_sales": enterpriseValueToSales, "price_to_earnings_ttm": priceToEarningsTtm, "price_to_sales_ttm": priceToSalesTtm, "price_to_book_value": priceToBookValue, "enterprise_value_to_ebitda": enterpriseValueToEbitda, "price_change_1m": priceChange_1m, "price_change_3m": priceChange_3m, "price_change_1y": priceChange_1y, "dividend_yield": dividendYield, "dividends_per_share": dividendsPerShare, "dividend_payout_ratio": dividendPayoutRatio, "years_of_consecutive_dividend_growth": yearsOfConsecutiveDividendGrowth, "dividend_frequency": dividendFrequency, "eps_actual": epsActual, "eps_estimate": epsEstimate, "beaten_quarterly_eps_estimation_count_ttm": beatenQuarterlyEpsEstimationCountTtm, "eps_surprise": epsSurprise, "revenue_estimate_avg_0y": revenueEstimateAvg_0y, "revenue_actual": revenueActual, "revenue_ttm": revenueTtm, "revenue_per_share_ttm": revenuePerShareTtm, "net_income": netIncome, "roi": roi, "asset_cash_and_equivalents": assetCashAndEquivalents, "roa": roa, "total_assets": totalAssets, "ebitda": ebitda, "net_debt": netDebt, "price_change_1w": priceChange_1w, "price_change_5y": priceChange_5y, "price_change_all": priceChangeAll])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var profitMargin: float8? {
      get {
        return resultMap["profit_margin"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "profit_margin")
      }
    }

    public var avgVolume_10d: float8? {
      get {
        return resultMap["avg_volume_10d"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "avg_volume_10d")
      }
    }

    public var shortPercentOutstanding: float8? {
      get {
        return resultMap["short_percent_outstanding"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "short_percent_outstanding")
      }
    }

    public var sharesOutstanding: bigint? {
      get {
        return resultMap["shares_outstanding"] as? bigint
      }
      set {
        resultMap.updateValue(newValue, forKey: "shares_outstanding")
      }
    }

    public var avgVolume_90d: float8? {
      get {
        return resultMap["avg_volume_90d"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "avg_volume_90d")
      }
    }

    public var sharesFloat: bigint? {
      get {
        return resultMap["shares_float"] as? bigint
      }
      set {
        resultMap.updateValue(newValue, forKey: "shares_float")
      }
    }

    public var shortRatio: float8? {
      get {
        return resultMap["short_ratio"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "short_ratio")
      }
    }

    public var beta: float8? {
      get {
        return resultMap["beta"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "beta")
      }
    }

    public var absoluteHistoricalVolatilityAdjustedCurrent: float8? {
      get {
        return resultMap["absolute_historical_volatility_adjusted_current"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_current")
      }
    }

    public var relativeHistoricalVolatilityAdjustedCurrent: float8? {
      get {
        return resultMap["relative_historical_volatility_adjusted_current"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_current")
      }
    }

    public var absoluteHistoricalVolatilityAdjustedMin_1y: float8? {
      get {
        return resultMap["absolute_historical_volatility_adjusted_min_1y"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_min_1y")
      }
    }

    public var absoluteHistoricalVolatilityAdjustedMax_1y: float8? {
      get {
        return resultMap["absolute_historical_volatility_adjusted_max_1y"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_max_1y")
      }
    }

    public var relativeHistoricalVolatilityAdjustedMin_1y: float8? {
      get {
        return resultMap["relative_historical_volatility_adjusted_min_1y"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_min_1y")
      }
    }

    public var relativeHistoricalVolatilityAdjustedMax_1y: float8? {
      get {
        return resultMap["relative_historical_volatility_adjusted_max_1y"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_max_1y")
      }
    }

    public var impliedVolatility: float8? {
      get {
        return resultMap["implied_volatility"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "implied_volatility")
      }
    }

    public var revenueGrowthYoy: float8? {
      get {
        return resultMap["revenue_growth_yoy"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "revenue_growth_yoy")
      }
    }

    public var revenueGrowthFwd: float8? {
      get {
        return resultMap["revenue_growth_fwd"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "revenue_growth_fwd")
      }
    }

    public var ebitdaGrowthYoy: float8? {
      get {
        return resultMap["ebitda_growth_yoy"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "ebitda_growth_yoy")
      }
    }

    public var epsGrowthYoy: float8? {
      get {
        return resultMap["eps_growth_yoy"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "eps_growth_yoy")
      }
    }

    public var epsGrowthFwd: float8? {
      get {
        return resultMap["eps_growth_fwd"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "eps_growth_fwd")
      }
    }

    public var addressCity: String? {
      get {
        return resultMap["address_city"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "address_city")
      }
    }

    public var addressState: String? {
      get {
        return resultMap["address_state"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "address_state")
      }
    }

    public var addressCounty: String? {
      get {
        return resultMap["address_county"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "address_county")
      }
    }

    public var addressFull: String? {
      get {
        return resultMap["address_full"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "address_full")
      }
    }

    public var exchangeName: String? {
      get {
        return resultMap["exchange_name"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "exchange_name")
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

    public var enterpriseValueToSales: float8? {
      get {
        return resultMap["enterprise_value_to_sales"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "enterprise_value_to_sales")
      }
    }

    public var priceToEarningsTtm: float8? {
      get {
        return resultMap["price_to_earnings_ttm"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "price_to_earnings_ttm")
      }
    }

    public var priceToSalesTtm: float8? {
      get {
        return resultMap["price_to_sales_ttm"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "price_to_sales_ttm")
      }
    }

    public var priceToBookValue: float8? {
      get {
        return resultMap["price_to_book_value"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "price_to_book_value")
      }
    }

    public var enterpriseValueToEbitda: float8? {
      get {
        return resultMap["enterprise_value_to_ebitda"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "enterprise_value_to_ebitda")
      }
    }

    public var priceChange_1m: float8? {
      get {
        return resultMap["price_change_1m"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "price_change_1m")
      }
    }

    public var priceChange_3m: float8? {
      get {
        return resultMap["price_change_3m"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "price_change_3m")
      }
    }

    public var priceChange_1y: float8? {
      get {
        return resultMap["price_change_1y"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "price_change_1y")
      }
    }

    public var dividendYield: float8? {
      get {
        return resultMap["dividend_yield"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "dividend_yield")
      }
    }

    public var dividendsPerShare: float8? {
      get {
        return resultMap["dividends_per_share"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "dividends_per_share")
      }
    }

    public var dividendPayoutRatio: float8? {
      get {
        return resultMap["dividend_payout_ratio"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "dividend_payout_ratio")
      }
    }

    public var yearsOfConsecutiveDividendGrowth: Int? {
      get {
        return resultMap["years_of_consecutive_dividend_growth"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "years_of_consecutive_dividend_growth")
      }
    }

    public var dividendFrequency: String? {
      get {
        return resultMap["dividend_frequency"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "dividend_frequency")
      }
    }

    public var epsActual: float8? {
      get {
        return resultMap["eps_actual"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "eps_actual")
      }
    }

    public var epsEstimate: float8? {
      get {
        return resultMap["eps_estimate"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "eps_estimate")
      }
    }

    public var beatenQuarterlyEpsEstimationCountTtm: Int? {
      get {
        return resultMap["beaten_quarterly_eps_estimation_count_ttm"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "beaten_quarterly_eps_estimation_count_ttm")
      }
    }

    public var epsSurprise: float8? {
      get {
        return resultMap["eps_surprise"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "eps_surprise")
      }
    }

    public var revenueEstimateAvg_0y: float8? {
      get {
        return resultMap["revenue_estimate_avg_0y"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "revenue_estimate_avg_0y")
      }
    }

    public var revenueActual: float8? {
      get {
        return resultMap["revenue_actual"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "revenue_actual")
      }
    }

    public var revenueTtm: float8? {
      get {
        return resultMap["revenue_ttm"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "revenue_ttm")
      }
    }

    public var revenuePerShareTtm: float8? {
      get {
        return resultMap["revenue_per_share_ttm"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "revenue_per_share_ttm")
      }
    }

    public var netIncome: float8? {
      get {
        return resultMap["net_income"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "net_income")
      }
    }

    public var roi: float8? {
      get {
        return resultMap["roi"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "roi")
      }
    }

    public var assetCashAndEquivalents: float8? {
      get {
        return resultMap["asset_cash_and_equivalents"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "asset_cash_and_equivalents")
      }
    }

    public var roa: float8? {
      get {
        return resultMap["roa"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "roa")
      }
    }

    public var totalAssets: float8? {
      get {
        return resultMap["total_assets"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "total_assets")
      }
    }

    public var ebitda: float8? {
      get {
        return resultMap["ebitda"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "ebitda")
      }
    }

    public var netDebt: float8? {
      get {
        return resultMap["net_debt"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "net_debt")
      }
    }

    public var priceChange_1w: float8? {
      get {
        return resultMap["price_change_1w"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "price_change_1w")
      }
    }

    public var priceChange_5y: float8? {
      get {
        return resultMap["price_change_5y"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "price_change_5y")
      }
    }

    public var priceChangeAll: float8? {
      get {
        return resultMap["price_change_all"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "price_change_all")
      }
    }
  }

  public struct RealtimeMetric: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_realtime_metrics"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("actual_price", type: .scalar(float8.self)),
        GraphQLField("relative_daily_change", type: .scalar(float8.self)),
        GraphQLField("time", type: .scalar(timestamp.self)),
        GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
        GraphQLField("last_known_price", type: .scalar(float8.self)),
        GraphQLField("last_known_price_datetime", type: .scalar(timestamp.self)),
        GraphQLField("previous_day_close_price", type: .scalar(float8.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(actualPrice: float8? = nil, relativeDailyChange: float8? = nil, time: timestamp? = nil, symbol: String, lastKnownPrice: float8? = nil, lastKnownPriceDatetime: timestamp? = nil, previousDayClosePrice: float8? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_realtime_metrics", "actual_price": actualPrice, "relative_daily_change": relativeDailyChange, "time": time, "symbol": symbol, "last_known_price": lastKnownPrice, "last_known_price_datetime": lastKnownPriceDatetime, "previous_day_close_price": previousDayClosePrice])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
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

    public var relativeDailyChange: float8? {
      get {
        return resultMap["relative_daily_change"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "relative_daily_change")
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

    public var symbol: String {
      get {
        return resultMap["symbol"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "symbol")
      }
    }

    public var lastKnownPrice: float8? {
      get {
        return resultMap["last_known_price"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "last_known_price")
      }
    }

    public var lastKnownPriceDatetime: timestamp? {
      get {
        return resultMap["last_known_price_datetime"] as? timestamp
      }
      set {
        resultMap.updateValue(newValue, forKey: "last_known_price_datetime")
      }
    }

    public var previousDayClosePrice: float8? {
      get {
        return resultMap["previous_day_close_price"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "previous_day_close_price")
      }
    }
  }

  public struct MatchScore: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["app_profile_ticker_match_score"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("category_matches", type: .nonNull(.scalar(String.self))),
        GraphQLField("fits_categories", type: .nonNull(.scalar(Int.self))),
        GraphQLField("fits_interests", type: .nonNull(.scalar(Int.self))),
        GraphQLField("fits_risk", type: .nonNull(.scalar(Int.self))),
        GraphQLField("interest_matches", type: .nonNull(.scalar(String.self))),
        GraphQLField("match_score", type: .nonNull(.scalar(Int.self))),
        GraphQLField("risk_similarity", type: .nonNull(.scalar(float8.self))),
        GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(categoryMatches: String, fitsCategories: Int, fitsInterests: Int, fitsRisk: Int, interestMatches: String, matchScore: Int, riskSimilarity: float8, symbol: String) {
      self.init(unsafeResultMap: ["__typename": "app_profile_ticker_match_score", "category_matches": categoryMatches, "fits_categories": fitsCategories, "fits_interests": fitsInterests, "fits_risk": fitsRisk, "interest_matches": interestMatches, "match_score": matchScore, "risk_similarity": riskSimilarity, "symbol": symbol])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var categoryMatches: String {
      get {
        return resultMap["category_matches"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "category_matches")
      }
    }

    public var fitsCategories: Int {
      get {
        return resultMap["fits_categories"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "fits_categories")
      }
    }

    public var fitsInterests: Int {
      get {
        return resultMap["fits_interests"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "fits_interests")
      }
    }

    public var fitsRisk: Int {
      get {
        return resultMap["fits_risk"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "fits_risk")
      }
    }

    public var interestMatches: String {
      get {
        return resultMap["interest_matches"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "interest_matches")
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

    public var riskSimilarity: float8 {
      get {
        return resultMap["risk_similarity"]! as! float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "risk_similarity")
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
  }
}

public struct RemoteTickerDetailsFull: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RemoteTickerDetailsFull on tickers {
      __typename
      ...RemoteTickerDetails
      ticker_categories(where: {rank: {_lte: 3}}) {
        __typename
        categories {
          __typename
          id
          name
          collection_id
          icon_url
        }
      }
      ticker_interests(where: {rank: {_lte: 3}}) {
        __typename
        symbol
        interest_id
        interest {
          __typename
          icon_url
          id
          name
        }
      }
      ticker_industries {
        __typename
        industry_id
        industry_order
        gainy_industry {
          __typename
          id
          name
          collection_id
        }
      }
      ticker_events {
        __typename
        created_at
        description
        symbol
        type
        timestamp
      }
      ticker_analyst_ratings {
        __typename
        target_price
        strong_buy
        buy
        hold
        sell
        strong_sell
        rating
      }
    }
    """

  public static let possibleTypes: [String] = ["tickers"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLFragmentSpread(RemoteTickerDetails.self),
      GraphQLField("ticker_categories", arguments: ["where": ["rank": ["_lte": 3]]], type: .nonNull(.list(.nonNull(.object(TickerCategory.selections))))),
      GraphQLField("ticker_interests", arguments: ["where": ["rank": ["_lte": 3]]], type: .nonNull(.list(.nonNull(.object(TickerInterest.selections))))),
      GraphQLField("ticker_industries", type: .nonNull(.list(.nonNull(.object(TickerIndustry.selections))))),
      GraphQLField("ticker_events", type: .nonNull(.list(.nonNull(.object(TickerEvent.selections))))),
      GraphQLField("ticker_analyst_ratings", type: .object(TickerAnalystRating.selections)),
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

  /// An array relationship
  public var tickerCategories: [TickerCategory] {
    get {
      return (resultMap["ticker_categories"] as! [ResultMap]).map { (value: ResultMap) -> TickerCategory in TickerCategory(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: TickerCategory) -> ResultMap in value.resultMap }, forKey: "ticker_categories")
    }
  }

  /// An array relationship
  public var tickerInterests: [TickerInterest] {
    get {
      return (resultMap["ticker_interests"] as! [ResultMap]).map { (value: ResultMap) -> TickerInterest in TickerInterest(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: TickerInterest) -> ResultMap in value.resultMap }, forKey: "ticker_interests")
    }
  }

  /// An array relationship
  public var tickerIndustries: [TickerIndustry] {
    get {
      return (resultMap["ticker_industries"] as! [ResultMap]).map { (value: ResultMap) -> TickerIndustry in TickerIndustry(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: TickerIndustry) -> ResultMap in value.resultMap }, forKey: "ticker_industries")
    }
  }

  /// An array relationship
  public var tickerEvents: [TickerEvent] {
    get {
      return (resultMap["ticker_events"] as! [ResultMap]).map { (value: ResultMap) -> TickerEvent in TickerEvent(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: TickerEvent) -> ResultMap in value.resultMap }, forKey: "ticker_events")
    }
  }

  /// An object relationship
  public var tickerAnalystRatings: TickerAnalystRating? {
    get {
      return (resultMap["ticker_analyst_ratings"] as? ResultMap).flatMap { TickerAnalystRating(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "ticker_analyst_ratings")
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

    public var remoteTickerDetails: RemoteTickerDetails {
      get {
        return RemoteTickerDetails(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }
  }

  public struct TickerCategory: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_categories"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("categories", type: .object(Category.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(categories: Category? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_categories", "categories": categories.flatMap { (value: Category) -> ResultMap in value.resultMap }])
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
    public var categories: Category? {
      get {
        return (resultMap["categories"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "categories")
      }
    }

    public struct Category: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["categories"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("collection_id", type: .scalar(Int.self)),
          GraphQLField("icon_url", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String? = nil, collectionId: Int? = nil, iconUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "categories", "id": id, "name": name, "collection_id": collectionId, "icon_url": iconUrl])
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

      public var collectionId: Int? {
        get {
          return resultMap["collection_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "collection_id")
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
  }

  public struct TickerInterest: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_interests"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
        GraphQLField("interest_id", type: .nonNull(.scalar(Int.self))),
        GraphQLField("interest", type: .object(Interest.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(symbol: String, interestId: Int, interest: Interest? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_interests", "symbol": symbol, "interest_id": interestId, "interest": interest.flatMap { (value: Interest) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
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

    public var interestId: Int {
      get {
        return resultMap["interest_id"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "interest_id")
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
          GraphQLField("icon_url", type: .scalar(String.self)),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(iconUrl: String? = nil, id: Int, name: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "interests", "icon_url": iconUrl, "id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

  public struct TickerIndustry: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_industries"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("industry_id", type: .nonNull(.scalar(Int.self))),
        GraphQLField("industry_order", type: .scalar(Int.self)),
        GraphQLField("gainy_industry", type: .object(GainyIndustry.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(industryId: Int, industryOrder: Int? = nil, gainyIndustry: GainyIndustry? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_industries", "industry_id": industryId, "industry_order": industryOrder, "gainy_industry": gainyIndustry.flatMap { (value: GainyIndustry) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var industryId: Int {
      get {
        return resultMap["industry_id"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "industry_id")
      }
    }

    public var industryOrder: Int? {
      get {
        return resultMap["industry_order"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "industry_order")
      }
    }

    /// An object relationship
    public var gainyIndustry: GainyIndustry? {
      get {
        return (resultMap["gainy_industry"] as? ResultMap).flatMap { GainyIndustry(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "gainy_industry")
      }
    }

    public struct GainyIndustry: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["gainy_industries"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("collection_id", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String? = nil, collectionId: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "gainy_industries", "id": id, "name": name, "collection_id": collectionId])
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

  public struct TickerEvent: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_events"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("created_at", type: .scalar(timestamptz.self)),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
        GraphQLField("type", type: .scalar(String.self)),
        GraphQLField("timestamp", type: .scalar(timestamptz.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createdAt: timestamptz? = nil, description: String? = nil, symbol: String, type: String? = nil, timestamp: timestamptz? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_events", "created_at": createdAt, "description": description, "symbol": symbol, "type": type, "timestamp": timestamp])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var createdAt: timestamptz? {
      get {
        return resultMap["created_at"] as? timestamptz
      }
      set {
        resultMap.updateValue(newValue, forKey: "created_at")
      }
    }

    public var description: String? {
      get {
        return resultMap["description"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "description")
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

    public var type: String? {
      get {
        return resultMap["type"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "type")
      }
    }

    public var timestamp: timestamptz? {
      get {
        return resultMap["timestamp"] as? timestamptz
      }
      set {
        resultMap.updateValue(newValue, forKey: "timestamp")
      }
    }
  }

  public struct TickerAnalystRating: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["analyst_ratings"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("target_price", type: .scalar(float8.self)),
        GraphQLField("strong_buy", type: .scalar(Int.self)),
        GraphQLField("buy", type: .scalar(Int.self)),
        GraphQLField("hold", type: .scalar(Int.self)),
        GraphQLField("sell", type: .scalar(Int.self)),
        GraphQLField("strong_sell", type: .scalar(Int.self)),
        GraphQLField("rating", type: .scalar(float8.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(targetPrice: float8? = nil, strongBuy: Int? = nil, buy: Int? = nil, hold: Int? = nil, sell: Int? = nil, strongSell: Int? = nil, rating: float8? = nil) {
      self.init(unsafeResultMap: ["__typename": "analyst_ratings", "target_price": targetPrice, "strong_buy": strongBuy, "buy": buy, "hold": hold, "sell": sell, "strong_sell": strongSell, "rating": rating])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var targetPrice: float8? {
      get {
        return resultMap["target_price"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "target_price")
      }
    }

    public var strongBuy: Int? {
      get {
        return resultMap["strong_buy"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "strong_buy")
      }
    }

    public var buy: Int? {
      get {
        return resultMap["buy"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "buy")
      }
    }

    public var hold: Int? {
      get {
        return resultMap["hold"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "hold")
      }
    }

    public var sell: Int? {
      get {
        return resultMap["sell"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "sell")
      }
    }

    public var strongSell: Int? {
      get {
        return resultMap["strong_sell"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "strong_sell")
      }
    }

    public var rating: float8? {
      get {
        return resultMap["rating"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "rating")
      }
    }
  }
}

public struct RemoteTickerExtraDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RemoteTickerExtraDetails on tickers {
      __typename
      symbol
      ticker_categories(where: {rank: {_lte: 3}}) {
        __typename
        categories {
          __typename
          id
          name
          collection_id
          icon_url
        }
      }
      ticker_interests(where: {rank: {_lte: 3}}) {
        __typename
        symbol
        interest_id
        interest {
          __typename
          icon_url
          id
          name
        }
      }
      ticker_industries {
        __typename
        industry_id
        industry_order
        gainy_industry {
          __typename
          id
          name
          collection_id
        }
      }
      ticker_events {
        __typename
        created_at
        description
        symbol
        type
        timestamp
      }
      ticker_analyst_ratings {
        __typename
        target_price
        strong_buy
        buy
        hold
        sell
        strong_sell
        rating
      }
      ticker_collections {
        __typename
        collection_id
        collection {
          __typename
          ...RemoteCollectionDetails
        }
      }
    }
    """

  public static let possibleTypes: [String] = ["tickers"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
      GraphQLField("ticker_categories", arguments: ["where": ["rank": ["_lte": 3]]], type: .nonNull(.list(.nonNull(.object(TickerCategory.selections))))),
      GraphQLField("ticker_interests", arguments: ["where": ["rank": ["_lte": 3]]], type: .nonNull(.list(.nonNull(.object(TickerInterest.selections))))),
      GraphQLField("ticker_industries", type: .nonNull(.list(.nonNull(.object(TickerIndustry.selections))))),
      GraphQLField("ticker_events", type: .nonNull(.list(.nonNull(.object(TickerEvent.selections))))),
      GraphQLField("ticker_analyst_ratings", type: .object(TickerAnalystRating.selections)),
      GraphQLField("ticker_collections", type: .nonNull(.list(.nonNull(.object(TickerCollection.selections))))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(symbol: String, tickerCategories: [TickerCategory], tickerInterests: [TickerInterest], tickerIndustries: [TickerIndustry], tickerEvents: [TickerEvent], tickerAnalystRatings: TickerAnalystRating? = nil, tickerCollections: [TickerCollection]) {
    self.init(unsafeResultMap: ["__typename": "tickers", "symbol": symbol, "ticker_categories": tickerCategories.map { (value: TickerCategory) -> ResultMap in value.resultMap }, "ticker_interests": tickerInterests.map { (value: TickerInterest) -> ResultMap in value.resultMap }, "ticker_industries": tickerIndustries.map { (value: TickerIndustry) -> ResultMap in value.resultMap }, "ticker_events": tickerEvents.map { (value: TickerEvent) -> ResultMap in value.resultMap }, "ticker_analyst_ratings": tickerAnalystRatings.flatMap { (value: TickerAnalystRating) -> ResultMap in value.resultMap }, "ticker_collections": tickerCollections.map { (value: TickerCollection) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
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

  /// An array relationship
  public var tickerCategories: [TickerCategory] {
    get {
      return (resultMap["ticker_categories"] as! [ResultMap]).map { (value: ResultMap) -> TickerCategory in TickerCategory(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: TickerCategory) -> ResultMap in value.resultMap }, forKey: "ticker_categories")
    }
  }

  /// An array relationship
  public var tickerInterests: [TickerInterest] {
    get {
      return (resultMap["ticker_interests"] as! [ResultMap]).map { (value: ResultMap) -> TickerInterest in TickerInterest(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: TickerInterest) -> ResultMap in value.resultMap }, forKey: "ticker_interests")
    }
  }

  /// An array relationship
  public var tickerIndustries: [TickerIndustry] {
    get {
      return (resultMap["ticker_industries"] as! [ResultMap]).map { (value: ResultMap) -> TickerIndustry in TickerIndustry(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: TickerIndustry) -> ResultMap in value.resultMap }, forKey: "ticker_industries")
    }
  }

  /// An array relationship
  public var tickerEvents: [TickerEvent] {
    get {
      return (resultMap["ticker_events"] as! [ResultMap]).map { (value: ResultMap) -> TickerEvent in TickerEvent(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: TickerEvent) -> ResultMap in value.resultMap }, forKey: "ticker_events")
    }
  }

  /// An object relationship
  public var tickerAnalystRatings: TickerAnalystRating? {
    get {
      return (resultMap["ticker_analyst_ratings"] as? ResultMap).flatMap { TickerAnalystRating(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "ticker_analyst_ratings")
    }
  }

  /// An array relationship
  public var tickerCollections: [TickerCollection] {
    get {
      return (resultMap["ticker_collections"] as! [ResultMap]).map { (value: ResultMap) -> TickerCollection in TickerCollection(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: TickerCollection) -> ResultMap in value.resultMap }, forKey: "ticker_collections")
    }
  }

  public struct TickerCategory: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_categories"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("categories", type: .object(Category.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(categories: Category? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_categories", "categories": categories.flatMap { (value: Category) -> ResultMap in value.resultMap }])
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
    public var categories: Category? {
      get {
        return (resultMap["categories"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "categories")
      }
    }

    public struct Category: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["categories"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("collection_id", type: .scalar(Int.self)),
          GraphQLField("icon_url", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String? = nil, collectionId: Int? = nil, iconUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "categories", "id": id, "name": name, "collection_id": collectionId, "icon_url": iconUrl])
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

      public var collectionId: Int? {
        get {
          return resultMap["collection_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "collection_id")
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
  }

  public struct TickerInterest: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_interests"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
        GraphQLField("interest_id", type: .nonNull(.scalar(Int.self))),
        GraphQLField("interest", type: .object(Interest.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(symbol: String, interestId: Int, interest: Interest? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_interests", "symbol": symbol, "interest_id": interestId, "interest": interest.flatMap { (value: Interest) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
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

    public var interestId: Int {
      get {
        return resultMap["interest_id"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "interest_id")
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
          GraphQLField("icon_url", type: .scalar(String.self)),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(iconUrl: String? = nil, id: Int, name: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "interests", "icon_url": iconUrl, "id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

  public struct TickerIndustry: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_industries"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("industry_id", type: .nonNull(.scalar(Int.self))),
        GraphQLField("industry_order", type: .scalar(Int.self)),
        GraphQLField("gainy_industry", type: .object(GainyIndustry.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(industryId: Int, industryOrder: Int? = nil, gainyIndustry: GainyIndustry? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_industries", "industry_id": industryId, "industry_order": industryOrder, "gainy_industry": gainyIndustry.flatMap { (value: GainyIndustry) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var industryId: Int {
      get {
        return resultMap["industry_id"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "industry_id")
      }
    }

    public var industryOrder: Int? {
      get {
        return resultMap["industry_order"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "industry_order")
      }
    }

    /// An object relationship
    public var gainyIndustry: GainyIndustry? {
      get {
        return (resultMap["gainy_industry"] as? ResultMap).flatMap { GainyIndustry(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "gainy_industry")
      }
    }

    public struct GainyIndustry: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["gainy_industries"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("collection_id", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String? = nil, collectionId: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "gainy_industries", "id": id, "name": name, "collection_id": collectionId])
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

  public struct TickerEvent: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_events"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("created_at", type: .scalar(timestamptz.self)),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
        GraphQLField("type", type: .scalar(String.self)),
        GraphQLField("timestamp", type: .scalar(timestamptz.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createdAt: timestamptz? = nil, description: String? = nil, symbol: String, type: String? = nil, timestamp: timestamptz? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_events", "created_at": createdAt, "description": description, "symbol": symbol, "type": type, "timestamp": timestamp])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var createdAt: timestamptz? {
      get {
        return resultMap["created_at"] as? timestamptz
      }
      set {
        resultMap.updateValue(newValue, forKey: "created_at")
      }
    }

    public var description: String? {
      get {
        return resultMap["description"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "description")
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

    public var type: String? {
      get {
        return resultMap["type"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "type")
      }
    }

    public var timestamp: timestamptz? {
      get {
        return resultMap["timestamp"] as? timestamptz
      }
      set {
        resultMap.updateValue(newValue, forKey: "timestamp")
      }
    }
  }

  public struct TickerAnalystRating: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["analyst_ratings"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("target_price", type: .scalar(float8.self)),
        GraphQLField("strong_buy", type: .scalar(Int.self)),
        GraphQLField("buy", type: .scalar(Int.self)),
        GraphQLField("hold", type: .scalar(Int.self)),
        GraphQLField("sell", type: .scalar(Int.self)),
        GraphQLField("strong_sell", type: .scalar(Int.self)),
        GraphQLField("rating", type: .scalar(float8.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(targetPrice: float8? = nil, strongBuy: Int? = nil, buy: Int? = nil, hold: Int? = nil, sell: Int? = nil, strongSell: Int? = nil, rating: float8? = nil) {
      self.init(unsafeResultMap: ["__typename": "analyst_ratings", "target_price": targetPrice, "strong_buy": strongBuy, "buy": buy, "hold": hold, "sell": sell, "strong_sell": strongSell, "rating": rating])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var targetPrice: float8? {
      get {
        return resultMap["target_price"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "target_price")
      }
    }

    public var strongBuy: Int? {
      get {
        return resultMap["strong_buy"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "strong_buy")
      }
    }

    public var buy: Int? {
      get {
        return resultMap["buy"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "buy")
      }
    }

    public var hold: Int? {
      get {
        return resultMap["hold"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "hold")
      }
    }

    public var sell: Int? {
      get {
        return resultMap["sell"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "sell")
      }
    }

    public var strongSell: Int? {
      get {
        return resultMap["strong_sell"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "strong_sell")
      }
    }

    public var rating: float8? {
      get {
        return resultMap["rating"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "rating")
      }
    }
  }

  public struct TickerCollection: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_collections"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("collection_id", type: .scalar(Int.self)),
        GraphQLField("collection", type: .object(Collection.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collectionId: Int? = nil, collection: Collection? = nil) {
      self.init(unsafeResultMap: ["__typename": "ticker_collections", "collection_id": collectionId, "collection": collection.flatMap { (value: Collection) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
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

    /// An object relationship
    public var collection: Collection? {
      get {
        return (resultMap["collection"] as? ResultMap).flatMap { Collection(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "collection")
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collections"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(RemoteCollectionDetails.self),
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

        public var remoteCollectionDetails: RemoteCollectionDetails {
          get {
            return RemoteCollectionDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
