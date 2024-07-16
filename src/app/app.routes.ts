import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {AuthGuard} from '../app/components/auth/auth.guard';
import { LoginComponent } from '../app/components/auth/login/login.component';
import { ProtectedComponent } from '../app/components/auth/protected.component';




const APP_ROUTES: Routes = [
  { path: 'protected', component: ProtectedComponent, canActivate: [AuthGuard] },
  { path: 'login', component: LoginComponent },
  { path: '', redirectTo: '/login', pathMatch: 'full' }
];

NgModule({
  imports: [RouterModule.forRoot(APP_ROUTES)],
  exports: [RouterModule]
})

export const APP_ROUTING = RouterModule.forRoot(APP_ROUTES, {useHash:true});


