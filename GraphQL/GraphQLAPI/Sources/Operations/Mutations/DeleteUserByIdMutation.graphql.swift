// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteUserByIdMutation: GraphQLMutation {
  public static let operationName: String = "DeleteUserById"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation DeleteUserById($userId: ID!) {
        deleteUserById(userId: $userId) {
          __typename
          status
          statusCode
          message
        }
      }
      """#
    ))

  public var userId: ID

  public init(userId: ID) {
    self.userId = userId
  }

  public var __variables: Variables? { ["userId": userId] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteUserById", DeleteUserById.self, arguments: ["userId": .variable("userId")]),
    ] }

    public var deleteUserById: DeleteUserById { __data["deleteUserById"] }

    /// DeleteUserById
    ///
    /// Parent Type: `CRUDResponse`
    public struct DeleteUserById: GraphQLAPI.SelectionSet {
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
