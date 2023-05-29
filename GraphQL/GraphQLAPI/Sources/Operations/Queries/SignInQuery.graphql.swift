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
            citizen {
              __typename
              id
              countryName
            }
            ethnicity {
              __typename
              id
              ethnicityType
            }
            socialAccount {
              __typename
              email
              platform
            }
            goal {
              __typename
              id
              goalType
            }
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
          .field("citizen", [Citizen]?.self),
          .field("ethnicity", [Ethnicity]?.self),
          .field("socialAccount", [SocialAccount]?.self),
          .field("goal", [Goal]?.self),
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
        public var citizen: [Citizen]? { __data["citizen"] }
        public var ethnicity: [Ethnicity]? { __data["ethnicity"] }
        public var socialAccount: [SocialAccount]? { __data["socialAccount"] }
        public var goal: [Goal]? { __data["goal"] }

        /// SignIn.User.LifePhoto
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

        /// SignIn.User.Citizen
        ///
        /// Parent Type: `Citizen`
        public struct Citizen: GraphQLAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Citizen }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", GraphQLAPI.ID.self),
            .field("countryName", String.self),
          ] }

          public var id: GraphQLAPI.ID { __data["id"] }
          public var countryName: String { __data["countryName"] }
        }

        /// SignIn.User.Ethnicity
        ///
        /// Parent Type: `Ethnicity`
        public struct Ethnicity: GraphQLAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Ethnicity }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", GraphQLAPI.ID.self),
            .field("ethnicityType", GraphQLEnum<GraphQLAPI.EthnicityEthnicityType>.self),
          ] }

          public var id: GraphQLAPI.ID { __data["id"] }
          public var ethnicityType: GraphQLEnum<GraphQLAPI.EthnicityEthnicityType> { __data["ethnicityType"] }
        }

        /// SignIn.User.SocialAccount
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

        /// SignIn.User.Goal
        ///
        /// Parent Type: `Goal`
        public struct Goal: GraphQLAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { GraphQLAPI.Objects.Goal }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", GraphQLAPI.ID.self),
            .field("goalType", GraphQLEnum<GraphQLAPI.GoalGoalType>.self),
          ] }

          public var id: GraphQLAPI.ID { __data["id"] }
          public var goalType: GraphQLEnum<GraphQLAPI.GoalGoalType> { __data["goalType"] }
        }
      }
    }
  }
}
