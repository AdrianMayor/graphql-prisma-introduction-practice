import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const getAllUsers = async () => {
  const users = await prisma.users.findMany({
    select: {
      id: true,
      username: true,
      email: true,
      role: true,
      createdAt: true,
      active: true,
      activeCode: true,
      activationDate: true,
    },
  });

  return users;
};
