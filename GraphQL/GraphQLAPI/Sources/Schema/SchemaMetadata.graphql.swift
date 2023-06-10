// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == GraphQLAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == GraphQLAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == GraphQLAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == GraphQLAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Mutation": return GraphQLAPI.Objects.Mutation
    case "CRUDResponse": return GraphQLAPI.Objects.CRUDResponse
    case "SignInResponse": return GraphQLAPI.Objects.SignInResponse
    case "OTPResponse": return GraphQLAPI.Objects.OTPResponse
    case "MediaCRUDResponse": return GraphQLAPI.Objects.MediaCRUDResponse
    case "MatchResponse": return GraphQLAPI.Objects.MatchResponse
    case "User": return GraphQLAPI.Objects.User
    case "Citizen": return GraphQLAPI.Objects.Citizen
    case "Ethnicity": return GraphQLAPI.Objects.Ethnicity
    case "Goal": return GraphQLAPI.Objects.Goal
    case "LifePhoto": return GraphQLAPI.Objects.LifePhoto
    case "SocialAccount": return GraphQLAPI.Objects.SocialAccount
    case "Query": return GraphQLAPI.Objects.Query
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
