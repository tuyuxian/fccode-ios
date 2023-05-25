// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignInQuery: GraphQLQuery {
  public static let operationName: String = "SignIn"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query SignIn($email: String!, $password: String!) {
        signIn(email: $email, password: $password) {
          __typename
          status
          statusCode
          message
          user {
            __typename
            id
          }
          token
        }
      }
      """#
    ))

  public var email: String
  public var password: String

  public init(
    email: String,
    password: String
  ) {
    self.email = email
    self.password = password
  }

  public var __variables: Variables? { [
    "email": email,
    "password": password
  ] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("signIn", SignIn.self, arguments: [
        "email": .variable("email"),
        "password": .variable("password")
      ]),
    ] }

    public var signIn: SignIn { __data["signIn"] }

    /// SignIn
    ///
    /// Parent Type: `SignInResponse`
    public struct SignIn: GraphQLAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.SignInResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("status", String.self),
        .field("statusCode", Int.self),
        .field("message", String.self),
        .field("user", User?.self),
        .field("token", String?.self),
      ] }

      public var status: String { __data["status"] }
      public var statusCode: Int { __data["statusCode"] }
      public var message: String { __data["message"] }
      public var user: User? { __data["user"] }
      public var token: String? { __data["token"] }

      /// SignIn.User
      ///
      /// Parent Type: `User`
      public struct User: GraphQLAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", GraphQLAPI.ID.self),
        ] }

        public var id: GraphQLAPI.ID { __data["id"] }
      }
    }
  }
}
