// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateLifePhotoMutation: GraphQLMutation {
  public static let operationName: String = "UpdateLifePhoto"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation UpdateLifePhoto($userId: ID!, $lifePhotoId: ID!, $input: UpdateLifePhotoInput!) {
        updateLifePhoto(userId: $userId, lifePhotoId: $lifePhotoId, input: $input) {
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
  public var input: UpdateLifePhotoInput

  public init(
    userId: ID,
    lifePhotoId: ID,
    input: UpdateLifePhotoInput
  ) {
    self.userId = userId
    self.lifePhotoId = lifePhotoId
    self.input = input
  }

  public var __variables: Variables? { [
    "userId": userId,
    "lifePhotoId": lifePhotoId,
    "input": input
  ] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updateLifePhoto", UpdateLifePhoto.self, arguments: [
        "userId": .variable("userId"),
        "lifePhotoId": .variable("lifePhotoId"),
        "input": .variable("input")
      ]),
    ] }

    public var updateLifePhoto: UpdateLifePhoto { __data["updateLifePhoto"] }

    /// UpdateLifePhoto
    ///
    /// Parent Type: `CRUDResponse`
    public struct UpdateLifePhoto: GraphQLAPI.SelectionSet {
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
