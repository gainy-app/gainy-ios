// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetUrlForDocumentMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation GetUrlForDocument($profile_id: Int!, $upload_type: String!, $content_type: String!) {
      get_pre_signed_upload_form(
        profile_id: $profile_id
        upload_type: $upload_type
        content_type: $content_type
      ) {
        __typename
        id
        url
        method
      }
    }
    """

  public let operationName: String = "GetUrlForDocument"

  public var profile_id: Int
  public var upload_type: String
  public var content_type: String

  public init(profile_id: Int, upload_type: String, content_type: String) {
    self.profile_id = profile_id
    self.upload_type = upload_type
    self.content_type = content_type
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "upload_type": upload_type, "content_type": content_type]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_pre_signed_upload_form", arguments: ["profile_id": GraphQLVariable("profile_id"), "upload_type": GraphQLVariable("upload_type"), "content_type": GraphQLVariable("content_type")], type: .object(GetPreSignedUploadForm.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPreSignedUploadForm: GetPreSignedUploadForm? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "get_pre_signed_upload_form": getPreSignedUploadForm.flatMap { (value: GetPreSignedUploadForm) -> ResultMap in value.resultMap }])
    }

    public var getPreSignedUploadForm: GetPreSignedUploadForm? {
      get {
        return (resultMap["get_pre_signed_upload_form"] as? ResultMap).flatMap { GetPreSignedUploadForm(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "get_pre_signed_upload_form")
      }
    }

    public struct GetPreSignedUploadForm: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PreSignedUploadFormOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
          GraphQLField("method", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, url: String, method: String) {
        self.init(unsafeResultMap: ["__typename": "PreSignedUploadFormOutput", "id": id, "url": url, "method": method])
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

      public var url: String {
        get {
          return resultMap["url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }

      public var method: String {
        get {
          return resultMap["method"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "method")
        }
      }
    }
  }
}
