// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetS3PresignedPutUrlQuery: GraphQLQuery {
  public static let operationName: String = "GetS3PresignedPutUrl"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query GetS3PresignedPutUrl($sourceType: MediaSourceType!) {
        getS3PresignedPutUrl(sourceType: $sourceType) {
          __typename
          status
          statusCode
          message
          url
        }
      }
      """#
    ))

  public var sourceType: GraphQLEnum<MediaSourceType>

  public init(sourceType: GraphQLEnum<MediaSourceType>) {
    self.sourceType = sourceType
  }

  public var __variables: Variables? { ["sourceType": sourceType] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getS3PresignedPutUrl", GetS3PresignedPutUrl.self, arguments: ["sourceType": .variable("sourceType")]),
    ] }

    public var getS3PresignedPutUrl: GetS3PresignedPutUrl { __data["getS3PresignedPutUrl"] }

    /// GetS3PresignedPutUrl
    ///
    /// Parent Type: `MediaCRUDResponse`
    public struct GetS3PresignedPutUrl: GraphQLAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.MediaCRUDResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("status", String.self),
        .field("statusCode", Int.self),
        .field("message", String.self),
        .field("url", String?.self),
      ] }

      public var status: String { __data["status"] }
      public var statusCode: Int { __data["statusCode"] }
      public var message: String { __data["message"] }
      public var url: String? { __data["url"] }
    }
  }
}
