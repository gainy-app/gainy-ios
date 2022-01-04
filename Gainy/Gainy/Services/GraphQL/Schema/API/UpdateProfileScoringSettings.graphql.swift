// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class UpdateAppProfileScoringSettingsMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateAppProfileScoringSettings($profileID: Int!, $averageMarketReturn: Int!, $damageOfFailure: Float!, $marketLoss20: Float!, $marketLoss40: Float!, $investemtHorizon: Float!, $riskLevel: Float!, $stockMarketRiskLevel: String!, $tradingExperience: String!, $unexpectedPurchaseSource: String!) {
      update_app_profile_scoring_settings_by_pk(
        pk_columns: {profile_id: $profileID}
        _set: {average_market_return: $averageMarketReturn, damage_of_failure: $damageOfFailure, if_market_drops_20_i_will_buy: $marketLoss20, if_market_drops_40_i_will_buy: $marketLoss40, investment_horizon: $investemtHorizon, risk_level: $riskLevel, stock_market_risk_level: $stockMarketRiskLevel, trading_experience: $tradingExperience, unexpected_purchases_source: $unexpectedPurchaseSource}
      ) {
        __typename
        profile_id
      }
    }
    """

  public let operationName: String = "UpdateAppProfileScoringSettings"

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

  public init(profileID: Int, averageMarketReturn: Int, damageOfFailure: Double, marketLoss20: Double, marketLoss40: Double, investemtHorizon: Double, riskLevel: Double, stockMarketRiskLevel: String, tradingExperience: String, unexpectedPurchaseSource: String) {
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
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "averageMarketReturn": averageMarketReturn, "damageOfFailure": damageOfFailure, "marketLoss20": marketLoss20, "marketLoss40": marketLoss40, "investemtHorizon": investemtHorizon, "riskLevel": riskLevel, "stockMarketRiskLevel": stockMarketRiskLevel, "tradingExperience": tradingExperience, "unexpectedPurchaseSource": unexpectedPurchaseSource]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("update_app_profile_scoring_settings_by_pk", arguments: ["pk_columns": ["profile_id": GraphQLVariable("profileID")], "_set": ["average_market_return": GraphQLVariable("averageMarketReturn"), "damage_of_failure": GraphQLVariable("damageOfFailure"), "if_market_drops_20_i_will_buy": GraphQLVariable("marketLoss20"), "if_market_drops_40_i_will_buy": GraphQLVariable("marketLoss40"), "investment_horizon": GraphQLVariable("investemtHorizon"), "risk_level": GraphQLVariable("riskLevel"), "stock_market_risk_level": GraphQLVariable("stockMarketRiskLevel"), "trading_experience": GraphQLVariable("tradingExperience"), "unexpected_purchases_source": GraphQLVariable("unexpectedPurchaseSource")]], type: .object(UpdateAppProfileScoringSettingsByPk.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateAppProfileScoringSettingsByPk: UpdateAppProfileScoringSettingsByPk? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "update_app_profile_scoring_settings_by_pk": updateAppProfileScoringSettingsByPk.flatMap { (value: UpdateAppProfileScoringSettingsByPk) -> ResultMap in value.resultMap }])
    }

    /// update single row of the table: "app.profile_scoring_settings"
    public var updateAppProfileScoringSettingsByPk: UpdateAppProfileScoringSettingsByPk? {
      get {
        return (resultMap["update_app_profile_scoring_settings_by_pk"] as? ResultMap).flatMap { UpdateAppProfileScoringSettingsByPk(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "update_app_profile_scoring_settings_by_pk")
      }
    }

    public struct UpdateAppProfileScoringSettingsByPk: GraphQLSelectionSet {
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
