const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
import { generateError, validateSchema } from "../../helpers";
import { userInput } from "../../interfaces/userInput.model";
import { createNewUserSchema } from "../../schemas/createNewUserSchema";

export const createNewUser = async (
  _: unknown,
  { user }: { user: userInput }
) => {
  // Si falta algun campo, lanamos error
  if (!user.username || !user.password || !user.email)
    generateError({
      msg: "Missing Fields",
      statusCode: 400,
      code: "BAD_USER_INPUT",
    });

  //Validamos los datos del input con joi
  await validateSchema(createNewUserSchema, user);

  // Comprobamos si existe un usuario con el mismo email

  const users = await prisma.users.findMany({
    where: {
      email: user.email,
    },
  });

  if (users.length >= 1)
    generateError({
      msg: "User already exists",
      statusCode: 403,
      code: "DATA_CONFLICT",
    });

  console.log(users);
};
