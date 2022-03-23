// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class HomeFetchArticlesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query HomeFetchArticles {
      website_blog_articles(order_by: {published_on: desc}) {
        __typename
        id
        category_name
        main_image
        post_summary
        published_on
        rate_rating
        rate_votes
        title
        updated_on
        url
      }
    }
    """

  public let operationName: String = "HomeFetchArticles"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("website_blog_articles", arguments: ["order_by": ["published_on": "desc"]], type: .nonNull(.list(.nonNull(.object(WebsiteBlogArticle.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(websiteBlogArticles: [WebsiteBlogArticle]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "website_blog_articles": websiteBlogArticles.map { (value: WebsiteBlogArticle) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220319155133.website_blog_articles"
    public var websiteBlogArticles: [WebsiteBlogArticle] {
      get {
        return (resultMap["website_blog_articles"] as! [ResultMap]).map { (value: ResultMap) -> WebsiteBlogArticle in WebsiteBlogArticle(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: WebsiteBlogArticle) -> ResultMap in value.resultMap }, forKey: "website_blog_articles")
      }
    }

    public struct WebsiteBlogArticle: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["website_blog_articles"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(String.self)),
          GraphQLField("category_name", type: .scalar(String.self)),
          GraphQLField("main_image", type: .scalar(String.self)),
          GraphQLField("post_summary", type: .scalar(String.self)),
          GraphQLField("published_on", type: .scalar(timestamp.self)),
          GraphQLField("rate_rating", type: .scalar(float8.self)),
          GraphQLField("rate_votes", type: .scalar(Int.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("updated_on", type: .scalar(timestamp.self)),
          GraphQLField("url", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String? = nil, categoryName: String? = nil, mainImage: String? = nil, postSummary: String? = nil, publishedOn: timestamp? = nil, rateRating: float8? = nil, rateVotes: Int? = nil, title: String? = nil, updatedOn: timestamp? = nil, url: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "website_blog_articles", "id": id, "category_name": categoryName, "main_image": mainImage, "post_summary": postSummary, "published_on": publishedOn, "rate_rating": rateRating, "rate_votes": rateVotes, "title": title, "updated_on": updatedOn, "url": url])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String? {
        get {
          return resultMap["id"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var categoryName: String? {
        get {
          return resultMap["category_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "category_name")
        }
      }

      public var mainImage: String? {
        get {
          return resultMap["main_image"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "main_image")
        }
      }

      public var postSummary: String? {
        get {
          return resultMap["post_summary"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "post_summary")
        }
      }

      public var publishedOn: timestamp? {
        get {
          return resultMap["published_on"] as? timestamp
        }
        set {
          resultMap.updateValue(newValue, forKey: "published_on")
        }
      }

      public var rateRating: float8? {
        get {
          return resultMap["rate_rating"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "rate_rating")
        }
      }

      public var rateVotes: Int? {
        get {
          return resultMap["rate_votes"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "rate_votes")
        }
      }

      public var title: String? {
        get {
          return resultMap["title"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var updatedOn: timestamp? {
        get {
          return resultMap["updated_on"] as? timestamp
        }
        set {
          resultMap.updateValue(newValue, forKey: "updated_on")
        }
      }

      public var url: String? {
        get {
          return resultMap["url"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }
    }
  }
}
