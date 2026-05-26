import { type Static, Type } from '@sinclair/typebox';
import { Value } from '@sinclair/typebox/value';

import { env } from '@lineup/api';

const AuthTokensSchema = Type.Object({
  access: Type.String(),
  refresh: Type.String(),
});

const AuthResponse = Type.Object({ token: AuthTokensSchema });

export type AuthTokens = Static<typeof AuthTokensSchema>;

export async function surrealAuth(
  path: 'signup' | 'signin',
  body: object,
): Promise<AuthTokens> {
  const res = await fetch(`${env.SURREAL_HOST}/${path}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
    body: JSON.stringify({
      ns: env.SURREAL_NS,
      db: env.SURREAL_DB,
      ac: 'user',
      ...body,
    }),
  });
  if (!res.ok) throw new Error(await res.text());
  return Value.Parse(AuthResponse, await res.json()).token;
}

export const surrealRefresh = (refresh: string) =>
  surrealAuth('signin', { refresh });
