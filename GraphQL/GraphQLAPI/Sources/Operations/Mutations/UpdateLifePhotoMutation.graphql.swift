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
          user {
            __typename
            lifePhoto {
              __typename
              id
              caption
              contentURL
              position
              scale
              offsetX
              offsetY
            }
          }
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
        .field("user", User?.self),
      ] }

      public var status: String { __data["status"] }
      public var statusCode: Int { __data["statusCode"] }
      public var message: String { __data["message"] }
      public var user: User? { __data["user"] }

      /// UpdateLifePhoto.User
      ///
      /// Parent Type: `User`
      public struct User: GraphQLAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("lifePhoto", [LifePhoto]?.self),
        ] }

        public var lifePhoto: [LifePhoto]? { __data["lifePhoto"] }

        /// UpdateLifePhoto.User.LifePhoto
        ///
        /// Parent Type: `LifePhoto`
        public struct LifePhoto: GraphQLAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.LifePhoto }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", GraphQLAPI.ID.self),
            .field("caption", String?.self),
            .field("contentURL", String.self),
            .field("position", Int.self),
            .field("scale", Double.self),
            .field("offsetX", Double.self),
            .field("offsetY", Double.self),
          ] }

          public var id: GraphQLAPI.ID { __data["id"] }
          public var caption: String? { __data["caption"] }
          public var contentURL: String { __data["contentURL"] }
          public var position: Int { __data["position"] }
          public var scale: Double { __data["scale"] }
          public var offsetX: Double { __data["offsetX"] }
          public var offsetY: Double { __data["offsetY"] }
        }
      }
    }
  }
}
