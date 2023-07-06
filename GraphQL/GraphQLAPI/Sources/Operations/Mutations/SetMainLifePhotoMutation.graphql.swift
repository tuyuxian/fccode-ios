// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SetMainLifePhotoMutation: GraphQLMutation {
  public static let operationName: String = "setMainLifePhoto"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation setMainLifePhoto($userId: ID!, $sourceLifePhotoId: ID!, $targetLifePhotoId: ID!, $fromPosition: Int!) {
        setMainLifePhoto(
          userId: $userId
          sourceLifePhotoId: $sourceLifePhotoId
          targetLifePhotoId: $targetLifePhotoId
          fromPosition: $fromPosition
        ) {
          __typename
          status
          statusCode
          message
        }
      }
      """#
    ))

  public var userId: ID
  public var sourceLifePhotoId: ID
  public var targetLifePhotoId: ID
  public var fromPosition: Int

  public init(
    userId: ID,
    sourceLifePhotoId: ID,
    targetLifePhotoId: ID,
    fromPosition: Int
  ) {
    self.userId = userId
    self.sourceLifePhotoId = sourceLifePhotoId
    self.targetLifePhotoId = targetLifePhotoId
    self.fromPosition = fromPosition
  }

  public var __variables: Variables? { [
    "userId": userId,
    "sourceLifePhotoId": sourceLifePhotoId,
    "targetLifePhotoId": targetLifePhotoId,
    "fromPosition": fromPosition
  ] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("setMainLifePhoto", SetMainLifePhoto.self, arguments: [
        "userId": .variable("userId"),
        "sourceLifePhotoId": .variable("sourceLifePhotoId"),
        "targetLifePhotoId": .variable("targetLifePhotoId"),
        "fromPosition": .variable("fromPosition")
      ]),
    ] }

    public var setMainLifePhoto: SetMainLifePhoto { __data["setMainLifePhoto"] }

    /// SetMainLifePhoto
    ///
    /// Parent Type: `CRUDResponse`
    public struct SetMainLifePhoto: GraphQLAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.CRUDResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("status", String.self),
        .field("statusCode", Int.self),
        .field("message", String.self),
      ] }

      public var status: String { __data["status"] }
      public var statusCode: Int { __data["statusCode"] }
      public var message: String { __data["message"] }
    }
  }
}
