const { gql } = require("apollo-server-express");

export const typeDefs = gql`
  scalar DateTime
  scalar Upload

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

  enum category {
    Harassment
    Bullying
    FraudScam
    BackseatSpoiler
    FakeRumor
    TauntProvocation
  }

  type Ticket {
    id: ID!
    idUserOpener: String!
    idUserReported: String!
    idSocial: String!
    category: category!
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

  type File {
    filename: String!
    mimetype: String!
    encoding: String!
  }

  input newUserInput {
    username: String!
    password: String!
    email: String!
  }

  input newTicketInput {
    idUserReported: String!
    idSocial: String!
    category: String!
    title: String!
    description: String
    tags: String
  }

  type Mutation {
    createNewUser(user: newUserInput!): String
    createNewTicket(ticket: newTicketInput!): String
    uploadPhotos(file: Upload!): File!
  }
`;
