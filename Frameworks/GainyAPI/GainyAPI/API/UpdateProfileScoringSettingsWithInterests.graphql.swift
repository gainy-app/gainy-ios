// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class UpdateProfileScoringSettingsWithInterestsMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateProfileScoringSettingsWithInterests($profileID: Int!, $averageMarketReturn: Int!, $damageOfFailure: Float!, $marketLoss20: Float!, $marketLoss40: Float!, $investemtHorizon: Float!, $riskLevel: Float!, $stockMarketRiskLevel: String!, $tradingExperience: String!, $unexpectedPurchaseSource: String!, $interests: [Int!]!) {
      set_recommendation_settings(profile_id: $profileID, interests: $interests) {
        __typename
        recommended_collections {
          __typename
          id
        }
      }
      insert_app_profile_scoring_settings_one(
        object: {profile_id: $profileID, average_market_return: $averageMarketReturn, damage_of_failure: $damageOfFailure, if_market_drops_20_i_will_buy: $marketLoss20, if_market_drops_40_i_will_buy: $marketLoss40, investment_horizon: $investemtHorizon, risk_level: $riskLevel, stock_market_risk_level: $stockMarketRiskLevel, trading_experience: $tradingExperience, unexpected_purchases_source: $unexpectedPurchaseSource}
        on_conflict: {constraint: profile_scoring_settings_pkey, update_columns: [average_market_return, damage_of_failure, if_market_drops_20_i_will_buy, if_market_drops_40_i_will_buy, investment_horizon, risk_level, stock_market_risk_level, trading_experience, unexpected_purchases_source]}
      ) {
        __typename
        profile_id
      }
    }
    """

  public let operationName: String = "UpdateProfileScoringSettingsWithInterests"

  public var profileID: Int
  public var averageMarketReturn: Int
  public var damageOfFailure: Double
  public var marketLoss20: Double
  public var marketLoss40: Double
  public var investemtHorizon: Double
  public var riskLevel: Double
  public var stockMarketRiskLevel: String
  public var tradingExperience: String
  public var unexpectedPurchaseSource: String
  public var interests: [Int]

  public init(profileID: Int, averageMarketReturn: Int, damageOfFailure: Double, marketLoss20: Double, marketLoss40: Double, investemtHorizon: Double, riskLevel: Double, stockMarketRiskLevel: String, tradingExperience: String, unexpectedPurchaseSource: String, interests: [Int]) {
    self.profileID = profileID
    self.averageMarketReturn = averageMarketReturn
    self.damageOfFailure = damageOfFailure
    self.marketLoss20 = marketLoss20
    self.marketLoss40 = marketLoss40
    self.investemtHorizon = investemtHorizon
    self.riskLevel = riskLevel
    self.stockMarketRiskLevel = stockMarketRiskLevel
    self.tradingExperience = tradingExperience
    self.unexpectedPurchaseSource = unexpectedPurchaseSource
    self.interests = interests
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "averageMarketReturn": averageMarketReturn, "damageOfFailure": damageOfFailure, "marketLoss20": marketLoss20, "marketLoss40": marketLoss40, "investemtHorizon": investemtHorizon, "riskLevel": riskLevel, "stockMarketRiskLevel": stockMarketRiskLevel, "tradingExperience": tradingExperience, "unexpectedPurchaseSource": unexpectedPurchaseSource, "interests": interests]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("set_recommendation_settings", arguments: ["profile_id": GraphQLVariable("profileID"), "interests": GraphQLVariable("interests")], type: .object(SetRecommendationSetting.selections)),
        GraphQLField("insert_app_profile_scoring_settings_one", arguments: ["object": ["profile_id": GraphQLVariable("profileID"), "average_market_return": GraphQLVariable("averageMarketReturn"), "damage_of_failure": GraphQLVariable("damageOfFailure"), "if_market_drops_20_i_will_buy": GraphQLVariable("marketLoss20"), "if_market_drops_40_i_will_buy": GraphQLVariable("marketLoss40"), "investment_horizon": GraphQLVariable("investemtHorizon"), "risk_level": GraphQLVariable("riskLevel"), "stock_market_risk_level": GraphQLVariable("stockMarketRiskLevel"), "trading_experience": GraphQLVariable("tradingExperience"), "unexpected_purchases_source": GraphQLVariable("unexpectedPurchaseSource")], "on_conflict": ["constraint": "profile_scoring_settings_pkey", "update_columns": ["average_market_return", "damage_of_failure", "if_market_drops_20_i_will_buy", "if_market_drops_40_i_will_buy", "investment_horizon", "risk_level", "stock_market_risk_level", "trading_experience", "unexpected_purchases_source"]]], type: .object(InsertAppProfileScoringSettingsOne.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(setRecommendationSettings: SetRecommendationSetting? = nil, insertAppProfileScoringSettingsOne: InsertAppProfileScoringSettingsOne? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "set_recommendation_settings": setRecommendationSettings.flatMap { (value: SetRecommendationSetting) -> ResultMap in value.resultMap }, "insert_app_profile_scoring_settings_one": insertAppProfileScoringSettingsOne.flatMap { (value: InsertAppProfileScoringSettingsOne) -> ResultMap in value.resultMap }])
    }

    public var setRecommendationSettings: SetRecommendationSetting? {
      get {
        return (resultMap["set_recommendation_settings"] as? ResultMap).flatMap { SetRecommendationSetting(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "set_recommendation_settings")
      }
    }

    /// insert a single row into the table: "app.profile_scoring_settings"
    public var insertAppProfileScoringSettingsOne: InsertAppProfileScoringSettingsOne? {
      get {
        return (resultMap["insert_app_profile_scoring_settings_one"] as? ResultMap).flatMap { InsertAppProfileScoringSettingsOne(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_profile_scoring_settings_one")
      }
    }

    public struct SetRecommendationSetting: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SetRecommendationSettingsOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("recommended_collections", type: .list(.object(RecommendedCollection.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(recommendedCollections: [RecommendedCollection?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "SetRecommendationSettingsOutput", "recommended_collections": recommendedCollections.flatMap { (value: [RecommendedCollection?]) -> [ResultMap?] in value.map { (value: RecommendedCollection?) -> ResultMap? in value.flatMap { (value: RecommendedCollection) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var recommendedCollections: [RecommendedCollection?]? {
        get {
          return (resultMap["recommended_collections"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [RecommendedCollection?] in value.map { (value: ResultMap?) -> RecommendedCollection? in value.flatMap { (value: ResultMap) -> RecommendedCollection in RecommendedCollection(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [RecommendedCollection?]) -> [ResultMap?] in value.map { (value: RecommendedCollection?) -> ResultMap? in value.flatMap { (value: RecommendedCollection) -> ResultMap in value.resultMap } } }, forKey: "recommended_collections")
        }
      }

      public struct RecommendedCollection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Collection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int) {
          self.init(unsafeResultMap: ["__typename": "Collection", "id": id])
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
      }
    }

    public struct InsertAppProfileScoringSettingsOne: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_scoring_settings"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(profileId: Int) {
        self.init(unsafeResultMap: ["__typename": "app_profile_scoring_settings", "profile_id": profileId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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
}
