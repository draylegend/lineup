import { type Route } from '@angular/router';

const signIn: Route = {
  path: 'sign-in',
  loadComponent: () => import('./sign-in/sign-in'),
};

export const auth: Route = {
  path: 'auth',
  loadComponent: () => import('./auth'),
  children: [
    signIn,
    { path: 'sign-up', loadComponent: () => import('./sign-up/sign-up') },
    { path: '**', redirectTo: signIn.path ?? '' },
  ],
};
