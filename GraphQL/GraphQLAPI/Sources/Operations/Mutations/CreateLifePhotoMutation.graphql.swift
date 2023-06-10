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
      ] }

      public var status: String { __data["status"] }
      public var statusCode: Int { __data["statusCode"] }
      public var message: String { __data["message"] }
    }
  }
}
