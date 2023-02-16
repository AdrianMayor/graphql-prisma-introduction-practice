import { GraphQLError } from "graphql";
import { userInput } from "./interfaces/userInput.model";

/**
 * ####################
 * ## Generate Error ##
 * ####################
 */

interface customErrorArgs {
  msg: string;
  statusCode: number;
  code: string;
}

export const generateError = ({ msg, statusCode, code }: customErrorArgs) => {
  throw new GraphQLError(msg, {
    extensions: {
      code: code,
      statusCode: statusCode,
    },
  });
};

/**
 * #####################
 * ## VALIDATE SCHEMA ##
 * #####################
 */

export const validateSchema = async (schema: any, data: userInput) => {
  const validation = schema.validate(data);
  if (validation.error)
    generateError({
      msg: validation.error.message,
      statusCode: 400,
      code: "BAD_USER_INPUT",
    });
};
