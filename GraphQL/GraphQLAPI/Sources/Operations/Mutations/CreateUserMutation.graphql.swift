// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateUserMutation: GraphQLMutation {
  public static let operationName: String = "CreateUser"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation CreateUser($input: CreateUserInput!) {
        createUser(input: $input) {
          __typename
          status
          statusCode
          message
          userId
          token
        }
      }
      """#
    ))

  public var input: CreateUserInput

  public init(input: CreateUserInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createUser", CreateUser.self, arguments: ["input": .variable("input")]),
    ] }

    public var createUser: CreateUser { __data["createUser"] }

    /// CreateUser
    ///
    /// Parent Type: `SignInResponse`
    public struct CreateUser: GraphQLAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.SignInResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("status", String.self),
        .field("statusCode", Int.self),
        .field("message", String.self),
        .field("userId", GraphQLAPI.ID?.self),
        .field("token", String?.self),
      ] }

      public var status: String { __data["status"] }
      public var statusCode: Int { __data["statusCode"] }
      public var message: String { __data["message"] }
      public var userId: GraphQLAPI.ID? { __data["userId"] }
      public var token: String? { __data["token"] }
    }
  }
}
