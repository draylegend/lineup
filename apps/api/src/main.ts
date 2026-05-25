import { Type } from '@sinclair/typebox';
import { Value } from '@sinclair/typebox/value';
import { Elysia } from 'elysia';

const env = Value.Parse(
  Type.Object({
    PORT: Type.Optional(Type.String()),
  }),
  Bun.env,
);

new Elysia()
  .get('/health', () => ({ ok: true }))
  .listen({ port: env.PORT || 3000 }, s => console.log(`🦊 ${s.url.href}`));
