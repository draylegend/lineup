import { Elysia } from 'elysia';

import { env } from '@lineup/api';

new Elysia()
  .get('/health', () => ({ ok: true }))
  .listen({ port: env.PORT || 3000 }, s => console.log(`🦊 ${s.url.href}`));
