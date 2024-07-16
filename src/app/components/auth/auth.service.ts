// src/app/components/auth/auth.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { tap, catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})

export class AuthService {
  private tokenKey = 'authToken';
  private loginUrl = 'https://example.com/api/login'; // URL simulada para la autenticación

  constructor(private http: HttpClient) {}

  setToken(token: string): void {
    localStorage.setItem(this.tokenKey, token);
  }

  getToken(): string | null {
    return localStorage.getItem(this.tokenKey);
  }

  removeToken(): void {
    localStorage.removeItem(this.tokenKey);
  }

  login(username: string, password: string): Observable<any> {
    // Simula una llamada de autenticación
    if (username === 'user' && password === 'password') {
      return of({ token: 'fake-jwt-token' }).pipe(
        tap((response) => console.log('ingresingreso correctamente')),
        catchError((error) => {
          console.error('Login fallido', error);
          throw error;
        })
      );
    } else {
      return of({ error: 'Credenciales invalidas' }).pipe(
        tap((response) => console.log('Login fallido')),
        catchError((error) => {
          console.error('Login fallido', error);
          throw error;
        })
      );
    }
  }
}
