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
          user {
            __typename
            id
            email
            password
            username
            dateOfBirth
            gender
            profilePictureURL
            voiceContentURL
            selfIntro
            longitude
            latitude
            country
            administrativeArea
            googleConnect
            facebookConnect
            appleConnect
            premium
            lifePhoto {
              __typename
              id
              caption
              contentURL
            }
          }
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
        .field("user", User?.self),
        .field("token", String?.self),
      ] }

      public var status: String { __data["status"] }
      public var statusCode: Int { __data["statusCode"] }
      public var message: String { __data["message"] }
      public var user: User? { __data["user"] }
      public var token: String? { __data["token"] }

      /// CreateUser.User
      ///
      /// Parent Type: `User`
      public struct User: GraphQLAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", GraphQLAPI.ID.self),
          .field("email", String.self),
          .field("password", String?.self),
          .field("username", String.self),
          .field("dateOfBirth", GraphQLAPI.Time.self),
          .field("gender", GraphQLEnum<GraphQLAPI.UserGender>.self),
          .field("profilePictureURL", String?.self),
          .field("voiceContentURL", String?.self),
          .field("selfIntro", String?.self),
          .field("longitude", Double.self),
          .field("latitude", Double.self),
          .field("country", String?.self),
          .field("administrativeArea", String?.self),
          .field("googleConnect", Bool.self),
          .field("facebookConnect", Bool.self),
          .field("appleConnect", Bool.self),
          .field("premium", Bool.self),
          .field("lifePhoto", [LifePhoto]?.self),
        ] }

        public var id: GraphQLAPI.ID { __data["id"] }
        public var email: String { __data["email"] }
        public var password: String? { __data["password"] }
        public var username: String { __data["username"] }
        public var dateOfBirth: GraphQLAPI.Time { __data["dateOfBirth"] }
        public var gender: GraphQLEnum<GraphQLAPI.UserGender> { __data["gender"] }
        public var profilePictureURL: String? { __data["profilePictureURL"] }
        public var voiceContentURL: String? { __data["voiceContentURL"] }
        public var selfIntro: String? { __data["selfIntro"] }
        public var longitude: Double { __data["longitude"] }
        public var latitude: Double { __data["latitude"] }
        public var country: String? { __data["country"] }
        public var administrativeArea: String? { __data["administrativeArea"] }
        public var googleConnect: Bool { __data["googleConnect"] }
        public var facebookConnect: Bool { __data["facebookConnect"] }
        public var appleConnect: Bool { __data["appleConnect"] }
        public var premium: Bool { __data["premium"] }
        public var lifePhoto: [LifePhoto]? { __data["lifePhoto"] }

        /// CreateUser.User.LifePhoto
        ///
        /// Parent Type: `LifePhoto`
        public struct LifePhoto: GraphQLAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.LifePhoto }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", GraphQLAPI.ID.self),
            .field("caption", String?.self),
            .field("contentURL", String.self),
          ] }

          public var id: GraphQLAPI.ID { __data["id"] }
          public var caption: String? { __data["caption"] }
          public var contentURL: String { __data["contentURL"] }
        }
      }
    }
  }
}
