import GraphQLUpload from "graphql-upload/GraphQLUpload";
import { createNewTicket } from "./controllers/users/createNewTicket";
import { createNewUser } from "./controllers/users/createNewUser";
import { getAllUsers } from "./controllers/users/getAllUsers";
import { getUserById } from "./controllers/users/getUserById";
import { loginUser } from "./controllers/users/loginUser";
import { uploadPhotos } from "./controllers/users/uploadPhotos";

export const resolvers = {
  Upload: GraphQLUpload,
  Query: {
    getAllUsers,
    getUserById,
    loginUser,
  },
  Mutation: {
    createNewUser,
    createNewTicket,
    uploadPhotos,
  },
};
