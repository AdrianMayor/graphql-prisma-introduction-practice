const getAllUsers = require("./controllers/users/getAllUsers");

export const resolvers = {
  Query: {
    getAllUsers,
  },
};
