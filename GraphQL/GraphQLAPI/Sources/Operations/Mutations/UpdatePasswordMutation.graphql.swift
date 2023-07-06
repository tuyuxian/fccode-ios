// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdatePasswordMutation: GraphQLMutation {
  public static let operationName: String = "UpdatePassword"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation UpdatePassword($userId: ID!, $oldPassword: String, $newPassword: String!) {
        updatePassword(
          userId: $userId
          oldPassword: $oldPassword
          newPassword: $newPassword
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
  public var oldPassword: GraphQLNullable<String>
  public var newPassword: String

  public init(
    userId: ID,
    oldPassword: GraphQLNullable<String>,
    newPassword: String
  ) {
    self.userId = userId
    self.oldPassword = oldPassword
    self.newPassword = newPassword
  }

  public var __variables: Variables? { [
    "userId": userId,
    "oldPassword": oldPassword,
    "newPassword": newPassword
  ] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updatePassword", UpdatePassword.self, arguments: [
        "userId": .variable("userId"),
        "oldPassword": .variable("oldPassword"),
        "newPassword": .variable("newPassword")
      ]),
    ] }

    public var updatePassword: UpdatePassword { __data["updatePassword"] }

    /// UpdatePassword
    ///
    /// Parent Type: `CRUDResponse`
    public struct UpdatePassword: GraphQLAPI.SelectionSet {
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
