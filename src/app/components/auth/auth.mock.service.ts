// todos los mock son simulaciones, aliminar una vez funcionen
// src/app/components/auth/auth.mock.service.ts
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { delay } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class AuthMockService {
  private validCredentials = {
    usuario: 'admin',
    pass: 'password123'
  };

  constructor() {}

  login(usuario: string, pass: string): Observable<{ token?: string, error?: string }> {
    if (usuario === this.validCredentials.usuario && pass === this.validCredentials.pass) {
      const token = 'fake-jwt-token'; // Simulando un token JWT
      return of({ token }).pipe(delay(1000)); // Simula una respuesta de servidor con un retraso
    } else {
      return of({ error: 'Invalid credentials' }).pipe(delay(1000));
    }
  }
}
