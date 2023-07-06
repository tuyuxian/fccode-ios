// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RequestOTPQuery: GraphQLQuery {
  public static let operationName: String = "RequestOTP"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query RequestOTP($email: String!) {
        requestOTP(email: $email) {
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

  public init(email: String) {
    self.email = email
  }

  public var __variables: Variables? { ["email": email] }

  public struct Data: GraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("requestOTP", RequestOTP.self, arguments: ["email": .variable("email")]),
    ] }

    public var requestOTP: RequestOTP { __data["requestOTP"] }

    /// RequestOTP
    ///
    /// Parent Type: `OTPResponse`
    public struct RequestOTP: GraphQLAPI.SelectionSet {
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
