import { type CookieOptions, Elysia, t } from 'elysia';

import { env } from '@lineup/api';

import { surrealAuth, surrealRefresh } from './surreal-auth';

const cookieOptions: CookieOptions = {
  httpOnly: true,
  secure: true,
  sameSite: 'none',
  path: '/',
  secrets: env.COOKIE_SECRET,
};

const refreshCookie: CookieOptions = {
  ...cookieOptions,
  maxAge: 30 * 86_400,
};

async function handleAuth(
  path: 'signup' | 'signin',
  body: object,
  setRefreshCookie: (value: string) => void,
) {
  const { access, refresh } = await surrealAuth(path, body);
  setRefreshCookie(refresh);
  return { token: access };
}

export const auth = new Elysia({ prefix: '/auth' })
  .post(
    '/signup',
    ({ body, cookie: { refresh } }) =>
      handleAuth('signup', body, value =>
        refresh?.set({ ...refreshCookie, value }),
      ),
    {
      body: t.Object({
        email: t.String({ format: 'email' }),
        password: t.String({ minLength: 8 }),
        username: t.String(),
        firstName: t.String(),
        lastName: t.String(),
        timezone: t.Optional(t.String()),
        locale: t.Optional(t.String()),
      }),
    },
  )
  .post(
    '/signin',
    ({ body, cookie: { refresh } }) =>
      handleAuth('signin', body, v =>
        refresh?.set({ ...refreshCookie, value: v }),
      ),
    {
      body: t.Object({
        email: t.String({ format: 'email' }),
        password: t.String(),
      }),
    },
  )
  .post(
    '/refresh',
    async ({ cookie: { refresh }, status }) => {
      try {
        const { access, refresh: newRefresh } = await surrealRefresh(
          refresh.value,
        );
        refresh.set({ ...refreshCookie, value: newRefresh });
        return { token: access };
      } catch {
        refresh.remove();
        return status(401, 'invalid or expired refresh token');
      }
    },
    { cookie: t.Object({ refresh: t.String() }) },
  )
  .post('/signout', ({ cookie: { refresh } }) => {
    refresh?.remove();
    return { ok: true };
  });
