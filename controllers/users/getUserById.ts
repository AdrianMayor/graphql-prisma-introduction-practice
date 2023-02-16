const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

export const getUserById = async (_: unknown, { id }: { id: string }) => {
  const idUser = parseInt(id);

  const user = await prisma.users.findUnique({
    where: {
      id: idUser,
    },
    select: {
      id: true,
      username: true,
      email: true,
      role: true,
      createdAt: true,
    },
  });

  return user;
};
