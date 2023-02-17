import { PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt";
import { v4 as uuidv4 } from "uuid";
import { generateError, validateSchema } from "../../helpers";
import { userInput } from "../../interfaces/userInput.model";
import { createNewUserSchema } from "../../schemas/createNewUserSchema";

const prisma = new PrismaClient();

export const createNewUser = async (
  _: unknown,
  { user }: { user: userInput }
) => {
  // Si falta algun campo, lanamos error
  if (!user.username || !user.password || !user.email)
    generateError({
      msg: "Missing Fields",
      statusCode: 400,
      customCode: "BAD_USER_INPUT",
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
      customCode: "DATA_CONFLICT",
    });

  // Generamos un código de verificación
  const registrationValidationCode = await bcrypt.hash(uuidv4(), 10);

  // Enviamos un email de verificación
  /* await verifyEmail(email, registrationCode); */

  // Encriptamos la contraseña
  const hashedPassword = await bcrypt.hash(user.password, 10);

  // Insertamos el usuario en la base de datos.
  await prisma.users.create({
    data: {
      username: user.username,
      email: user.email,
      password: hashedPassword,
      registrationCode: registrationValidationCode,
    },
  });

  return "User created";
};
