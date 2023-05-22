// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class EmailCheckQuery: GraphQLQuery {
  public static let operationName: String = "EmailCheck"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query EmailCheck($email: String!) {
        emailCheck(email: $email) {
          __typename
          status
          statusCode
          message
          exist
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
      .field("emailCheck", EmailCheck.self, arguments: ["email": .variable("email")]),
    ] }

    public var emailCheck: EmailCheck { __data["emailCheck"] }

    /// EmailCheck
    ///
    /// Parent Type: `EmailCheckResponse`
    public struct EmailCheck: GraphQLAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.EmailCheckResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("status", String.self),
        .field("statusCode", Int.self),
        .field("message", String.self),
        .field("exist", Bool.self),
      ] }

      public var status: String { __data["status"] }
      public var statusCode: Int { __data["statusCode"] }
      public var message: String { __data["message"] }
      public var exist: Bool { __data["exist"] }
    }
  }
}
