// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteLifePhotoMutation: GraphQLMutation {
  public static let operationName: String = "DeleteLifePhoto"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation DeleteLifePhoto($userId: ID!, $lifePhotoId: ID!, $position: Int!) {
        deleteLifePhoto(userId: $userId, lifePhotoId: $lifePhotoId, position: $position) {
          __typename
          status
          statusCode
          message
        }
      }
      """#
    ))

  public var userId: ID
  public var lifePhotoId: ID
  public var position: Int

  public init(
    userId: ID,
    lifePhotoId: ID,
    position: Int
  ) {
    self.userId = userId
    self.lifePhotoId = lifePhotoId
    self.position = position
  }

  public var __variables: Variables? { [
    "userId": userId,
    "lifePhotoId": lifePhotoId,
    "position": position
  ] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteLifePhoto", DeleteLifePhoto.self, arguments: [
        "userId": .variable("userId"),
        "lifePhotoId": .variable("lifePhotoId"),
        "position": .variable("position")
      ]),
    ] }

    public var deleteLifePhoto: DeleteLifePhoto { __data["deleteLifePhoto"] }

    /// DeleteLifePhoto
    ///
    /// Parent Type: `CRUDResponse`
    public struct DeleteLifePhoto: GraphQLAPI.SelectionSet {
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
