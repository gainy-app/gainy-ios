// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class CreateAppProfileMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateAppProfile($avatarURL: String!, $email: String!, $firstName: String!, $gender: Int!, $lastName: String!, $userID: String!, $legalAddress: String!, $interests: [app_profile_interests_insert_input!]!, $averageMarketReturn: Int!, $damageOfFailure: Float!, $marketLoss20: Float!, $marketLoss40: Float!, $investemtHorizon: Float!, $riskLevel: Float!, $stockMarketRiskLevel: String!, $tradingExperience: String!, $unexpectedPurchaseSource: String!) {
      insert_app_profiles(
        objects: {avatar_url: $avatarURL, email: $email, first_name: $firstName, gender: $gender, last_name: $lastName, user_id: $userID, legal_address: $legalAddress, profile_interests: {data: $interests}, profile_scoring_setting: {data: {average_market_return: $averageMarketReturn, damage_of_failure: $damageOfFailure, if_market_drops_20_i_will_buy: $marketLoss20, if_market_drops_40_i_will_buy: $marketLoss40, investment_horizon: $investemtHorizon, risk_level: $riskLevel, stock_market_risk_level: $stockMarketRiskLevel, trading_experience: $tradingExperience, unexpected_purchases_source: $unexpectedPurchaseSource}}}
      ) {
        __typename
        returning {
          __typename
          id
        }
      }
    }
    """

  public let operationName: String = "CreateAppProfile"

  public var avatarURL: String
  public var email: String
  public var firstName: String
  public var gender: Int
  public var lastName: String
  public var userID: String
  public var legalAddress: String
  public var interests: [app_profile_interests_insert_input]
  public var averageMarketReturn: Int
  public var damageOfFailure: Double
  public var marketLoss20: Double
  public var marketLoss40: Double
  public var investemtHorizon: Double
  public var riskLevel: Double
  public var stockMarketRiskLevel: String
  public var tradingExperience: String
  public var unexpectedPurchaseSource: String

  public init(avatarURL: String, email: String, firstName: String, gender: Int, lastName: String, userID: String, legalAddress: String, interests: [app_profile_interests_insert_input], averageMarketReturn: Int, damageOfFailure: Double, marketLoss20: Double, marketLoss40: Double, investemtHorizon: Double, riskLevel: Double, stockMarketRiskLevel: String, tradingExperience: String, unexpectedPurchaseSource: String) {
    self.avatarURL = avatarURL
    self.email = email
    self.firstName = firstName
    self.gender = gender
    self.lastName = lastName
    self.userID = userID
    self.legalAddress = legalAddress
    self.interests = interests
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
    return ["avatarURL": avatarURL, "email": email, "firstName": firstName, "gender": gender, "lastName": lastName, "userID": userID, "legalAddress": legalAddress, "interests": interests, "averageMarketReturn": averageMarketReturn, "damageOfFailure": damageOfFailure, "marketLoss20": marketLoss20, "marketLoss40": marketLoss40, "investemtHorizon": investemtHorizon, "riskLevel": riskLevel, "stockMarketRiskLevel": stockMarketRiskLevel, "tradingExperience": tradingExperience, "unexpectedPurchaseSource": unexpectedPurchaseSource]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_app_profiles", arguments: ["objects": ["avatar_url": GraphQLVariable("avatarURL"), "email": GraphQLVariable("email"), "first_name": GraphQLVariable("firstName"), "gender": GraphQLVariable("gender"), "last_name": GraphQLVariable("lastName"), "user_id": GraphQLVariable("userID"), "legal_address": GraphQLVariable("legalAddress"), "profile_interests": ["data": GraphQLVariable("interests")], "profile_scoring_setting": ["data": ["average_market_return": GraphQLVariable("averageMarketReturn"), "damage_of_failure": GraphQLVariable("damageOfFailure"), "if_market_drops_20_i_will_buy": GraphQLVariable("marketLoss20"), "if_market_drops_40_i_will_buy": GraphQLVariable("marketLoss40"), "investment_horizon": GraphQLVariable("investemtHorizon"), "risk_level": GraphQLVariable("riskLevel"), "stock_market_risk_level": GraphQLVariable("stockMarketRiskLevel"), "trading_experience": GraphQLVariable("tradingExperience"), "unexpected_purchases_source": GraphQLVariable("unexpectedPurchaseSource")]]]], type: .object(InsertAppProfile.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppProfiles: InsertAppProfile? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_profiles": insertAppProfiles.flatMap { (value: InsertAppProfile) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "app.profiles"
    public var insertAppProfiles: InsertAppProfile? {
      get {
        return (resultMap["insert_app_profiles"] as? ResultMap).flatMap { InsertAppProfile(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_profiles")
      }
    }

    public struct InsertAppProfile: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profiles_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("returning", type: .nonNull(.list(.nonNull(.object(Returning.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(returning: [Returning]) {
        self.init(unsafeResultMap: ["__typename": "app_profiles_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// data from the rows affected by the mutation
      public var returning: [Returning] {
        get {
          return (resultMap["returning"] as! [ResultMap]).map { (value: ResultMap) -> Returning in Returning(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Returning) -> ResultMap in value.resultMap }, forKey: "returning")
        }
      }

      public struct Returning: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profiles"]

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
          self.init(unsafeResultMap: ["__typename": "app_profiles", "id": id])
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
  }
}
