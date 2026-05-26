import { type Routes } from '@angular/router';

import { auth } from '@lineup/auth/feature';

export const appRoutes: Routes = [
  auth,
  { path: '**', redirectTo: auth.path ?? '' },
];
