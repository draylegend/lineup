import { env } from '@lineup/api';
import { Elysia } from 'elysia';

new Elysia()
  .get('/health', () => ({ ok: true }))
  .listen({ port: env.PORT || 3000 }, s => console.log(`🦊 ${s.url.href}`));
