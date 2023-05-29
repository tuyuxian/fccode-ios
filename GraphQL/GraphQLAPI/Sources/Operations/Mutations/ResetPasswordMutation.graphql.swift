// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ResetPasswordMutation: GraphQLMutation {
  public static let operationName: String = "ResetPassword"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation ResetPassword($email: String!, $password: String!) {
        resetPassword(email: $email, password: $password) {
          __typename
          status
          statusCode
          message
          valid
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

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("resetPassword", ResetPassword.self, arguments: [
        "email": .variable("email"),
        "password": .variable("password")
      ]),
    ] }

    public var resetPassword: ResetPassword { __data["resetPassword"] }

    /// ResetPassword
    ///
    /// Parent Type: `OTPResponse`
    public struct ResetPassword: GraphQLAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.OTPResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("status", String.self),
        .field("statusCode", Int.self),
        .field("message", String.self),
        .field("valid", Bool.self),
      ] }

      public var status: String { __data["status"] }
      public var statusCode: Int { __data["statusCode"] }
      public var message: String { __data["message"] }
      public var valid: Bool { __data["valid"] }
    }
  }
}
