const { gql } = require("apollo-server-express");

const typeDefs = gql`
  type User {
    id: ID
    username: String
    password: String
    role: String
    createdAt: Int
  }

  type Query {
    getAllUsers: [User]!
    getUserById(id: ID): User
  }
`;

module.exports = typeDefs;
