// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CheckEmailQuery: GraphQLQuery {
  public static let operationName: String = "CheckEmail"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query CheckEmail($email: String!) {
        checkEmail(email: $email) {
          __typename
          status
          statusCode
          message
          user {
            __typename
            password
            username
            profilePictureURL
            appleConnect
            facebookConnect
            googleConnect
            socialAccount {
              __typename
              email
              platform
            }
          }
        }
      }
      """#
    ))

  public var email: String

  public init(email: String) {
    self.email = email
  }

  public var __variables: Variables? { ["email": email] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("checkEmail", CheckEmail.self, arguments: ["email": .variable("email")]),
    ] }

    public var checkEmail: CheckEmail { __data["checkEmail"] }

    /// CheckEmail
    ///
    /// Parent Type: `CRUDResponse`
    public struct CheckEmail: GraphQLAPI.SelectionSet {
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

      /// CheckEmail.User
      ///
      /// Parent Type: `User`
      public struct User: GraphQLAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("password", String?.self),
          .field("username", String.self),
          .field("profilePictureURL", String?.self),
          .field("appleConnect", Bool.self),
          .field("facebookConnect", Bool.self),
          .field("googleConnect", Bool.self),
          .field("socialAccount", [SocialAccount]?.self),
        ] }

        public var password: String? { __data["password"] }
        public var username: String { __data["username"] }
        public var profilePictureURL: String? { __data["profilePictureURL"] }
        public var appleConnect: Bool { __data["appleConnect"] }
        public var facebookConnect: Bool { __data["facebookConnect"] }
        public var googleConnect: Bool { __data["googleConnect"] }
        public var socialAccount: [SocialAccount]? { __data["socialAccount"] }

        /// CheckEmail.User.SocialAccount
        ///
        /// Parent Type: `SocialAccount`
        public struct SocialAccount: GraphQLAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.SocialAccount }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("email", String.self),
            .field("platform", GraphQLEnum<GraphQLAPI.SocialAccountPlatform>.self),
          ] }

          public var email: String { __data["email"] }
          public var platform: GraphQLEnum<GraphQLAPI.SocialAccountPlatform> { __data["platform"] }
        }
      }
    }
  }
}
