// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class RedeemInvitationMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation RedeemInvitation($fromId: Int!, $toId: Int!) {
      insert_app_invitations_one(
        object: {from_profile_id: $fromId, to_profile_id: $toId}
      ) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "RedeemInvitation"

  public var fromId: Int
  public var toId: Int

  public init(fromId: Int, toId: Int) {
    self.fromId = fromId
    self.toId = toId
  }

  public var variables: GraphQLMap? {
    return ["fromId": fromId, "toId": toId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_app_invitations_one", arguments: ["object": ["from_profile_id": GraphQLVariable("fromId"), "to_profile_id": GraphQLVariable("toId")]], type: .object(InsertAppInvitationsOne.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppInvitationsOne: InsertAppInvitationsOne? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_invitations_one": insertAppInvitationsOne.flatMap { (value: InsertAppInvitationsOne) -> ResultMap in value.resultMap }])
    }

    /// insert a single row into the table: "app.invitations"
    public var insertAppInvitationsOne: InsertAppInvitationsOne? {
      get {
        return (resultMap["insert_app_invitations_one"] as? ResultMap).flatMap { InsertAppInvitationsOne(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_invitations_one")
      }
    }

    public struct InsertAppInvitationsOne: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_invitations"]

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
        self.init(unsafeResultMap: ["__typename": "app_invitations", "id": id])
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
