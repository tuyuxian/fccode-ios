// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SocialSignInQuery: GraphQLQuery {
  public static let operationName: String = "SocialSignIn"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query SocialSignIn($email: String!, $platform: SocialAccountPlatform!) {
        socialSignIn(email: $email, platform: $platform) {
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

  public var email: String
  public var platform: GraphQLEnum<SocialAccountPlatform>

  public init(
    email: String,
    platform: GraphQLEnum<SocialAccountPlatform>
  ) {
    self.email = email
    self.platform = platform
  }

  public var __variables: Variables? { [
    "email": email,
    "platform": platform
  ] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("socialSignIn", SocialSignIn.self, arguments: [
        "email": .variable("email"),
        "platform": .variable("platform")
      ]),
    ] }

    public var socialSignIn: SocialSignIn { __data["socialSignIn"] }

    /// SocialSignIn
    ///
    /// Parent Type: `SignInResponse`
    public struct SocialSignIn: GraphQLAPI.SelectionSet {
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
