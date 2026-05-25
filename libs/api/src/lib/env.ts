import { Type } from '@sinclair/typebox';
import { Value } from '@sinclair/typebox/value';

export const env = Value.Parse(
  Type.Object({
    PORT: Type.Optional(Type.String()),
  }),
  Bun.env,
);
