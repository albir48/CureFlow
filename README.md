# CureFlow: System Features & Overview

> **A Comprehensive Web-Based Hospital Management System with AI-Assisted Healthcare Support, Real-Time Queue Management, and Multilingual Accessibility**
> 

---

## 1. Core Feature Highlights

* **Role-Based AI Chatbot System:** Context-aware assistant providing differentiated capabilities by user role: symptom assessment and appointment guidance for patients, clinical decision support and drug interaction lookups for doctors, and administrative analytics support for admins. Includes persistent conversation history tracking.


* **Real-Time Queue & Token Management:** Automated digital token generation, live waitlist queue tracking, estimated wait-time calculations, and integrated SMS status updates.


* **Medical Report & EMR Management:** Secure PDF upload, download, and sharing capabilities with role-based access control, paired with centralized diagnostic history records.


* **Integrated Payment Processing:** In-app payment gateway supporting consultation fee settlements, real-time transaction history tracking, and automated receipt generation.


* **Multilingual UI Support:** Instant language switching between **English** and **Bengali** without requiring a page reload.


* **Accessible Dark/Light Theming:** WCAG-compliant dual-mode theme system (minimum 4.5:1 contrast ratio) designed to minimize eye strain and improve readability.


* **Role-Based Portals:** Specialized workflows tailored for Patients, Doctors, and Administrators.


* **Interactive Health Analytics:** Visual data dashboards powered by Recharts covering doctor performance metrics, patient visit volume, appointment trends, and hospital revenue.



---

## 2. Role-Based Module Breakdown

### Patient Portal

* **Account & Profile Management:** Registration, secure login, and personal medical profile maintenance.


* **Appointment Scheduling:** Book, filter, and track upcoming appointments with preferred specialists.


* **Live Queue Status:** Automated token generation with real-time queue position tracking and estimated waiting time.


* **Health Record Access:** View clinical diagnoses and securely upload/download medical report PDFs.


* **AI Symptom Assistant:** Patient-centric chatbot for initial symptom guidance, wellness inquiries, and triage assistance.


* **Payment & Receipts:** Pay consultation fees via the payment gateway and download automated transaction receipts.



### Doctor Dashboard

* **Patient Records Review:** Access assigned patient lists, comprehensive case histories, and prior reports.


* **Prescription & Diagnosis Upload:** Record consultation outcomes, diagnostic notes, and treatment recommendations.


* **Queue Controller:** Track and call patient tokens in real time throughout daily clinical schedules.


* **Clinical Decision Support:** Doctor-specific AI assistance for medical reference checks and drug interaction verifications.


* **Performance Analytics:** View personal patient consultation trends and performance KPIs.



### Administrator Panel

* **Doctor & Staff Management:** Provision, edit, and manage doctor credentials, schedules, and specializations.


* **Patient Record Oversight:** Department-wide record monitoring and administrative management.


* **Appointment & Operations Monitoring:** Centralized monitoring of active queues and hospital bookings.


* **System-Wide Analytics:** High-level dashboard displaying revenue streams, operational efficiency, and patient throughput.


* **Notification Dispatcher:** Broadcast system notifications and automated SMS alerts.



---

## 3. Technology Stack

| Layer | Technology | Purpose |
| --- | --- | --- |
| **Frontend Framework** | React 18 + TypeScript | Component-based UI and static type safety

 |
| **Styling & Components** | Tailwind CSS + shadcn/ui (Radix UI primitives) | Accessible, fully responsive UI design system

 |
| **Animations & Visuals** | Framer Motion & Recharts | Micro-interactions and real-time analytical charts

 |
| **Build Tool** | Vite | Frontend bundling and development server

 |
| **Backend API** | PHP REST API (JSON payloads) | Business logic and service layer

 |
| **Authentication** | JWT (JSON Web Tokens) with RBAC | Secure session handling and role enforcement

 |
| **Database** | MySQL / MariaDB | Relational data persistence

 |
| **Development Environment** | XAMPP & phpMyAdmin | Local stack orchestration

 |

---

## 4. Database Schema Overview

The relational database architecture is structured across ten interconnected tables:

1. `users` — Authentication credentials, roles, and profile data.


2. `patients` — Demographic profiles and medical background data.


3. `doctors` — Department specializations, consultation schedules, and performance tracking.


4. `admins` — Administrative accounts and permission levels.


5. `tokens` — Live queue tracking, token numbers, and appointment status.


6. `payments` — Transaction history, payment status, and receipt references.


7. `medical_history` — Clinical diagnosis logs and consultation notes.


8. `medical_reports` — File metadata, document storage paths, and role-based access rules.


9. `notifications` — System-generated alerts and external SMS communication logs.


10. `ai_chatbot_logs` — Contextual AI conversation histories and session logs.



---

## 5. Performance Benchmarks

* **Average API Response Time:** ~145 ms


* **Average Database Query Execution:** ~32 ms


* **Average Page Load Speed:** < 1.5 seconds


* **Payment Gateway Success Rate:** 98.5%


* **System Testing Uptime:** 99.2%
