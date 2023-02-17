import { PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { generateError } from "../../helpers";

const prisma = new PrismaClient();

export const loginUser = async (
  _: unknown,
  { email, password }: { email: string; password: string }
) => {
  // Si falta algun campo lanzamos error
  if (!email || !password)
    generateError({
      msg: "Missing Fields",
      statusCode: 400,
      customCode: "BAD_USER_INPUT",
    });

  // Obtenemos el usuario con los datos del input
  const user = await prisma.users.findUnique({
    where: {
      email,
    },
  });

  // Si el usuario no existe lanzamos error, si existe comprobamos la contraseña
  if (!user) {
    generateError({
      msg: "User don't exist",
      statusCode: 404,
      customCode: "NOT_FOUND",
    });
  } else {
    const validPassword = await bcrypt.compare(password, user.password);

    if (!validPassword)
      generateError({
        msg: "Incorrect Password",
        statusCode: 401,
        customCode: "BAD_REQUEST",
      });
  }

  //Generamos un objeto con la información que queramos guardar en el token
  const userInfo = {
    id: user?.id,
    role: user?.role,
    isActive: user?.active,
  };

  // Generamos el token
  const token = jwt.sign(userInfo, process.env.SECRET as string, {
    expiresIn: "7d",
  });

  return token;
};
