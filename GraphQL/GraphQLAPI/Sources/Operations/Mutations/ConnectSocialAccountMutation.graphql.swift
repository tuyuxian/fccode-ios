// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ConnectSocialAccountMutation: GraphQLMutation {
  public static let operationName: String = "ConnectSocialAccount"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation ConnectSocialAccount($userId: ID!, $input: CreateSocialAccountInput!) {
        connectSocialAccount(userId: $userId, input: $input) {
          __typename
          status
          statusCode
          message
          user {
            __typename
            appleConnect
            facebookConnect
            googleConnect
          }
        }
      }
      """#
    ))

  public var userId: ID
  public var input: CreateSocialAccountInput

  public init(
    userId: ID,
    input: CreateSocialAccountInput
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
      .field("connectSocialAccount", ConnectSocialAccount.self, arguments: [
        "userId": .variable("userId"),
        "input": .variable("input")
      ]),
    ] }

    public var connectSocialAccount: ConnectSocialAccount { __data["connectSocialAccount"] }

    /// ConnectSocialAccount
    ///
    /// Parent Type: `CRUDResponse`
    public struct ConnectSocialAccount: GraphQLAPI.SelectionSet {
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

      /// ConnectSocialAccount.User
      ///
      /// Parent Type: `User`
      public struct User: GraphQLAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("appleConnect", Bool.self),
          .field("facebookConnect", Bool.self),
          .field("googleConnect", Bool.self),
        ] }

        public var appleConnect: Bool { __data["appleConnect"] }
        public var facebookConnect: Bool { __data["facebookConnect"] }
        public var googleConnect: Bool { __data["googleConnect"] }
      }
    }
  }
}
