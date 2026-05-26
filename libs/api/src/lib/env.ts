import { Type } from '@sinclair/typebox';
import { Value } from '@sinclair/typebox/value';

export const env = Value.Parse(
  Type.Object({
    PORT: Type.Optional(Type.String()),
    CORS_ORIGIN: Type.String(),
    SURREAL_HOST: Type.String(),
    SURREAL_NS: Type.String(),
    SURREAL_DB: Type.String(),
    COOKIE_SECRET: Type.String(),
  }),
  Bun.env,
);
