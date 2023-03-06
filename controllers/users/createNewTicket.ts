import { PrismaClient } from "@prisma/client";

import { newTicketInput } from "../../interfaces/newTicketInput.model";

const prisma = new PrismaClient();

export const createNewTicket = async (
  _: unknown,
  { ticket }: { ticket: newTicketInput }
) => {
  console.log(ticket);
};
