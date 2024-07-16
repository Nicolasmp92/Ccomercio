

// src/app/components/auth/login/login.component.ts
import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../auth.service';
import { AuthMockService } from '../auth.mock.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  usuario: string = '';
  pass: string = '';

  constructor(private authService: AuthService, private authMockService: AuthMockService, private router: Router) {}

  onSubmit() {
    this.authMockService.login(this.usuario, this.pass).subscribe(
      (response) => {
        if (response.token) {
          this.authService.setToken(response.token); // Asume que la respuesta contiene un token
          this.router.navigate(['/protected']); // Redirige al componente protegido
        } else {
          console.error('Login failed', response.error);
        }
      },
      (error) => {
        console.error('Login failed', error);
      }
    );
  }
}





// 08-07-2024 16:42
// src/app/components/auth/login/login.component.ts
// import { Component } from '@angular/core';
// import { Router } from '@angular/router';
// import { AuthService } from '../auth.service';

// @Component({
//   selector: 'app-login',
//   templateUrl: './login.component.html',
// })
// export class LoginComponent {
//   usuario: string = 'niko';
//   pass: string = 'admin123';

//   constructor(private authService: AuthService, private router: Router) {}

//   onSubmit() {
//     this.authService.login(this.usuario, this.pass).subscribe(
//       (response) => {
//         if (response.token) {
//           this.authService.setToken(response.token); // Asume que la respuesta contiene un token
//           this.router.navigate(['/protected']); // Redirige al componente protegido
//         } else {
//           console.error('Login fallido', response.error);
//         }
//       },
//       (error) => {
//         console.error('Login fallido', error);
//       }
//     );
//   }
// }
