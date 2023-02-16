import { createNewUser } from "./controllers/users/createNewUser";
import { getAllUsers } from "./controllers/users/getAllUsers";
import { getUserById } from "./controllers/users/getUserById";

export const resolvers = {
  Query: {
    getAllUsers,
    getUserById,
  },
  Mutation: {
    createNewUser,
  },
};
