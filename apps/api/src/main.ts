import { cors } from '@elysiajs/cors';
import { Elysia } from 'elysia';

import { env } from '@lineup/api';
import { auth } from '@lineup/auth/api';

new Elysia()
  .use(cors({ origin: env.CORS_ORIGIN, credentials: true }))
  .use(auth)
  .get('/health', () => ({ ok: true }))
  .listen({ port: env.PORT || 3000 }, s => console.log(`🦊 ${s.url.href}`));
