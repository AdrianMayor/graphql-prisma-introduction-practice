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

  type Ticket {
    id: ID!
    idUserOpener: String!
    idUserReported: String!
    idSocial: String!
    category: String!
    nestedTo: String!
    title: String!
    description: String
    createdAt: DateTime
  }

  type Query {
    getAllUsers: [User]!
    getUserById(id: ID!): User
    loginUser(email: String!, password: String!): String
  }

  input newUserInput {
    username: String!
    password: String!
    email: String!
  }

  type Mutation {
    createNewUser(user: newUserInput!): String
  }
`;
