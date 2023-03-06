import { GraphQLError } from "graphql";
import { newUserInput } from "./interfaces/newUserInput.model";

/**
 * ####################
 * ## Generate Error ##
 * ####################
 */

interface customErrorArgs {
  msg: string;
  statusCode: number;
  customCode: string;
}

export const generateError = ({
  msg,
  statusCode,
  customCode,
}: customErrorArgs) => {
  throw new GraphQLError(msg, {
    extensions: {
      customCode: customCode,
      statusCode: statusCode,
    },
  });
};

/**
 * #####################
 * ## VALIDATE SCHEMA ##
 * #####################
 */

export const validateSchema = async (schema: any, data: newUserInput) => {
  const validation = schema.validate(data);
  if (validation.error)
    generateError({
      msg: validation.error.message,
      statusCode: 400,
      customCode: "BAD_USER_INPUT",
    });
};
