const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

export const getAllUsers = async () => {
  const users = await prisma.users.findAll({
    select: {
      id: true,
      username: true,
      email: true,
      role: true,
      createdAt: true,
    },
  });

  return users;
};
