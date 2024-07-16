// src/app/protected.component.ts
import { Component, OnInit } from '@angular/core';
import { DatabaseService } from '../../components/database.service';

@Component({
  selector: 'app-protected',
  template: `
    <h1>Protected Component</h1>
    <button (click)="fetchData()">Fetch Data</button>
    <div *ngIf="data">
      <pre>{{ data | json }}</pre>
    </div>
  `
})
export class ProtectedComponent implements OnInit {
  data: any;

  constructor(private databaseService: DatabaseService) {}

  ngOnInit(): void {}

  fetchData(): void {
    this.databaseService.getData().subscribe(response => {
      this.data = response;
    });
  }
}
