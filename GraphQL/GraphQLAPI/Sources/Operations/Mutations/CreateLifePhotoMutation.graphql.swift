// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateLifePhotoMutation: GraphQLMutation {
  public static let operationName: String = "CreateLifePhoto"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation CreateLifePhoto($userId: ID!, $input: CreateLifePhotoInput!) {
        createLifePhoto(userId: $userId, input: $input) {
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
              ratio
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
  public var input: CreateLifePhotoInput

  public init(
    userId: ID,
    input: CreateLifePhotoInput
  ) {
    self.userId = userId
    self.input = input
  }

  public var __variables: Variables? { [
    "userId": userId,
    "input": input
  ] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createLifePhoto", CreateLifePhoto.self, arguments: [
        "userId": .variable("userId"),
        "input": .variable("input")
      ]),
    ] }

    public var createLifePhoto: CreateLifePhoto { __data["createLifePhoto"] }

    /// CreateLifePhoto
    ///
    /// Parent Type: `CRUDResponse`
    public struct CreateLifePhoto: GraphQLAPI.SelectionSet {
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

      /// CreateLifePhoto.User
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

        /// CreateLifePhoto.User.LifePhoto
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
            .field("ratio", Int.self),
            .field("scale", Double.self),
            .field("offsetX", Double.self),
            .field("offsetY", Double.self),
          ] }

          public var id: GraphQLAPI.ID { __data["id"] }
          public var caption: String? { __data["caption"] }
          public var contentURL: String { __data["contentURL"] }
          public var position: Int { __data["position"] }
          public var ratio: Int { __data["ratio"] }
          public var scale: Double { __data["scale"] }
          public var offsetX: Double { __data["offsetX"] }
          public var offsetY: Double { __data["offsetY"] }
        }
      }
    }
  }
}
