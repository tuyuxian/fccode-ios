// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetS3PresignedDeleteUrlQuery: GraphQLQuery {
  public static let operationName: String = "GetS3PresignedDeleteUrl"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query GetS3PresignedDeleteUrl($sourceType: MediaSourceType!, $fileName: String!) {
        getS3PresignedDeleteUrl(sourceType: $sourceType, fileName: $fileName) {
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
  public var fileName: String

  public init(
    sourceType: GraphQLEnum<MediaSourceType>,
    fileName: String
  ) {
    self.sourceType = sourceType
    self.fileName = fileName
  }

  public var __variables: Variables? { [
    "sourceType": sourceType,
    "fileName": fileName
  ] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getS3PresignedDeleteUrl", GetS3PresignedDeleteUrl.self, arguments: [
        "sourceType": .variable("sourceType"),
        "fileName": .variable("fileName")
      ]),
    ] }

    public var getS3PresignedDeleteUrl: GetS3PresignedDeleteUrl { __data["getS3PresignedDeleteUrl"] }

    /// GetS3PresignedDeleteUrl
    ///
    /// Parent Type: `MediaCRUDResponse`
    public struct GetS3PresignedDeleteUrl: GraphQLAPI.SelectionSet {
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
