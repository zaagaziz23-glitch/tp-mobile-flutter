# SR3Urban — PFA 2025-2026

Application Flutter de présentation du projet **SR3Urban** — Super-Résolution d'Images Satellitaires Urbaines par Modèles de Diffusion.

---

## 👤 Informations

| Champ | Détail |
|---|---|
| **Étudiant** | Mohamed Aziz Zaag |
| **Encadrant** | Ben Khalifa Aymen |
| **École** | EABA — Géomatique 2ème Année |
| **Année** | 2025–2026 |
| **GPU** | NVIDIA RTX 4050 — 6 GB VRAM |

---

## 📱 Application Flutter

Application de présentation du PFA avec 4 écrans :

| Écran | Description |
|---|---|
| 🏠 **Accueil** | Présentation générale du projet |
| 📋 **Contexte** | Problématique, objectifs, fiche projet |
| 🧠 **Méthodologie** | Architecture SR3 + 4 améliorations |
| 📊 **Résultats** | PSNR, progression, analyse |
| 📈 **Dashboard** | Tâches, chronologie, bibliographie |

---

## 🏗️ Architecture SR3

Modèle de diffusion débruitage conditionné sur l'image basse résolution.

### 4 Améliorations Successives

| # | Amélioration | PSNR | Gain |
|---|---|---|---|
| Baseline | SR3 de base | 14.18 dB | — |
| 01 | + Edge Loss | 15.83 dB | +1.65 dB |
| 02 | + Transformer Block | 17.21 dB | +1.38 dB |
| 03 | + SSIM Loss | 18.64 dB | +1.43 dB |
| 04 | + Cosine Annealing | 19.49 dB | +0.85 dB |
| **Final** | **Évaluation** | **17.74 dB** | **+5.31 dB** |

---

## 🌍 Internationalisation (i18n)

L'application supporte **2 langues** avec support RTL :

| Langue | Code | Écriture |
|---|---|---|
| 🇫🇷 Français | `fr` | LTR |
| 🇸🇦 Arabe | `ar` | RTL |

---

## 🛠️ Stack Technique

**Mobile**
- Flutter — Framework UI
- Google Fonts — Typographie
- Percent Indicator — Barres de progression
- Flutter Staggered Animations — Animations
- HTTP — Appels API

**Backend**
- Django REST Framework
- SQLite
- Python 3.10

---

## 📁 Structure du Projet
tp-mobile-flutter/
├── sr3urban/                  ← Application Flutter
│   ├── lib/
│   │   ├── main.dart
│   │   ├── screens/
│   │   │   ├── welcome_screen.dart
│   │   │   ├── context_screen.dart
│   │   │   ├── methodology_screen.dart
│   │   │   ├── results_screen.dart
│   │   │   └── dashboard_screen.dart
│   │   ├── widgets/
│   │   │   ├── bottom_nav_bar.dart
│   │   │   └── language_selector.dart
│   │   ├── models/
│   │   │   └── project_data.dart
│   │   ├── services/
│   │   │   └── api_service.dart
│   │   └── l10n/
│   │       └── app_localizations.dart
│   └── pubspec.yaml
└── SR3Urban_backend/          ← Backend Django
├── pipeline_api/
├── manage.py
└── seed_data.py

---

## 🚀 Lancement

**Flutter :**
```bash
cd sr3urban
flutter pub get
flutter run
```

**Backend Django :**
```bash
cd SR3Urban_backend
python manage.py runserver
```

---

*SR3Urban © 2026 — EABA Géomatique — Mohamed Aziz Zaag*
