import { createNewUser } from "./controllers/users/createNewUser";
import { getAllUsers } from "./controllers/users/getAllUsers";
import { getUserById } from "./controllers/users/getUserById";
import { loginUser } from "./controllers/users/loginUser";

export const resolvers = {
  Query: {
    getAllUsers,
    getUserById,
    loginUser,
  },
  Mutation: {
    createNewUser,
  },
};
