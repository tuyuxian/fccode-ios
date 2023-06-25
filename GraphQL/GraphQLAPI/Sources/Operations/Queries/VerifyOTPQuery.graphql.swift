// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class VerifyOTPQuery: GraphQLQuery {
  public static let operationName: String = "VerifyOTP"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query VerifyOTP($email: String!, $userOTP: String!) {
        verifyOTP(email: $email, userOTP: $userOTP) {
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
  public var userOTP: String

  public init(
    email: String,
    userOTP: String
  ) {
    self.email = email
    self.userOTP = userOTP
  }

  public var __variables: Variables? { [
    "email": email,
    "userOTP": userOTP
  ] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("verifyOTP", VerifyOTP.self, arguments: [
        "email": .variable("email"),
        "userOTP": .variable("userOTP")
      ]),
    ] }

    public var verifyOTP: VerifyOTP { __data["verifyOTP"] }

    /// VerifyOTP
    ///
    /// Parent Type: `OTPResponse`
    public struct VerifyOTP: GraphQLAPI.SelectionSet {
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
