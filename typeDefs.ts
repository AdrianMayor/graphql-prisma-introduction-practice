const { gql } = require("apollo-server-express");

export const typeDefs = gql`
  scalar DateTime

  type User {
    id: ID!
    username: String!
    email: String
    password: String
    role: String!
    karma: Int
    ranking: Int
    registrationCode: String
    active: Boolean
    activeCode: String
    activationDate: DateTime
    createdAt: DateTime
    modifiedAt: DateTime
  }

  type Query {
    getAllUsers: [User]!
    getUserById(id: ID!): User
  }

  input UserInput {
    username: String!
    password: String!
    email: String!
  }

  type Mutation {
    createNewUser(user: UserInput!): User
  }
`;
