import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'cartovec_backend.settings')
django.setup()

from pipeline_api.models import UserProfile, ProjectTask, TimelineMilestone, BibliographyReference

def seed_database():
    print("🚀 Début du remplissage de la base de données SR3Urban...")

    # ── 1. PROFIL UTILISATEUR ─────────────────────────────────────
    print("👤 Initialisation du profil...")
    profile_data = {
        "full_name": "Mohamed Aziz Zaag",
        "email": "",
        "supervisor": "Ben Khalifa Aymen",
        "institution": "EABA — Géomatique",
        "project_title": "SR3Urban",
        "project_description": (
            "SR3Urban améliore la résolution spatiale d'images satellitaires "
            "urbaines à basse résolution par un facteur ×4, en exploitant "
            "l'architecture SR3 basée sur les modèles de diffusion débruitage. "
            "Quatre améliorations successives (Edge Loss, Transformer Block, "
            "SSIM Loss, Cosine Annealing) ont permis de faire progresser le "
            "PSNR de 14.18 dB (baseline) à 19.49 dB en entraînement "
            "et 17.74 dB en évaluation finale."
        )
    }

    UserProfile.objects.get_or_create(
        full_name=profile_data["full_name"],
        defaults=profile_data
    )
    print("✅ Profil inséré ou déjà existant.")

    # ── 2. TÂCHES ─────────────────────────────────────────────────
    print("📋 Insertion des tâches...")
    tasks = [
        {
            "title": "Étude bibliographique SR3 & Diffusion",
            "description": "Revue des modèles de diffusion : DDPM, SR3, DDIM. "
                           "Choix de l'architecture et du framework PyTorch.",
            "status": "completed"
        },
        {
            "title": "Implémentation Baseline SR3",
            "description": "Implémentation de l'architecture SR3 de base. "
                           "PSNR baseline établi à 14.18 dB.",
            "status": "completed"
        },
        {
            "title": "Préparation & correction du dataset",
            "description": "Détection et correction du problème de résolution "
                           "des images LR. Normalisation dans [-1, 1].",
            "status": "completed"
        },
        {
            "title": "Amélioration 1 : Edge Loss",
            "description": "Intégration du filtre Sobel dans la fonction de perte. "
                           "PSNR : 14.18 → 15.83 dB (+1.65 dB).",
            "status": "completed"
        },
        {
            "title": "Amélioration 2 : Transformer Block",
            "description": "Ajout du bloc Multi-Head Self-Attention dans le "
                           "bottleneck U-Net. PSNR : 15.83 → 17.21 dB (+1.38 dB).",
            "status": "completed"
        },
        {
            "title": "Amélioration 3 : SSIM Loss",
            "description": "Remplacement partiel de L1 par SSIM Loss. "
                           "PSNR : 17.21 → 18.64 dB (+1.43 dB).",
            "status": "completed"
        },
        {
            "title": "Amélioration 4 : Cosine Annealing",
            "description": "CosineAnnealingWarmRestarts sur 60K itérations. "
                           "PSNR train : 18.64 → 19.49 dB (+0.85 dB).",
            "status": "completed"
        },
        {
            "title": "Rédaction du rapport final",
            "description": "Rédaction du mémoire PFA. Chapitre 2 (État de l'art) "
                           "finalisé. Soutenance prévue en Mai 2026.",
            "status": "in_progress"
        },
    ]

    for t in tasks:
        ProjectTask.objects.get_or_create(title=t["title"], defaults=t)
    print("✅ Tâches insérées.")

    # ── 3. JALONS (TIMELINE) ──────────────────────────────────────
    print("📅 Insertion de la chronologie...")
    milestones = [
        {
            "date_range": "Sept 2025",
            "title": "Lancement du projet",
            "achievement_details": "Définition du sujet PFA, étude des modèles "
                                   "de diffusion et choix de l'architecture SR3.",
            "progress_percentage": 100
        },
        {
            "date_range": "Oct – Nov 2025",
            "title": "Baseline SR3 opérationnel",
            "achievement_details": "Implémentation SR3 de base. "
                                   "PSNR baseline = 14.18 dB établi.",
            "progress_percentage": 100
        },
        {
            "date_range": "Déc 2025",
            "title": "Edge Loss intégrée",
            "achievement_details": "Filtre Sobel ajouté à la fonction de perte. "
                                   "PSNR 14.18 → 15.83 dB (+1.65 dB).",
            "progress_percentage": 100
        },
        {
            "date_range": "Jan 2026",
            "title": "Transformer Block intégré",
            "achievement_details": "Self-Attention dans le bottleneck U-Net. "
                                   "PSNR 15.83 → 17.21 dB (+1.38 dB).",
            "progress_percentage": 100
        },
        {
            "date_range": "Fév 2026",
            "title": "SSIM Loss intégrée",
            "achievement_details": "Perte perceptuelle SSIM combinée à L1. "
                                   "PSNR 17.21 → 18.64 dB (+1.43 dB).",
            "progress_percentage": 100
        },
        {
            "date_range": "Mars 2026",
            "title": "Cosine Annealing intégré",
            "achievement_details": "CosineAnnealingWarmRestarts sur 60K itérations. "
                                   "PSNR train = 19.49 dB (+0.85 dB).",
            "progress_percentage": 100
        },
        {
            "date_range": "Avr 2026",
            "title": "Évaluation finale",
            "achievement_details": "PSNR évaluation finale = 17.74 dB. "
                                   "Analyse de l'écart train/eval.",
            "progress_percentage": 100
        },
        {
            "date_range": "Mai 2026",
            "title": "Soutenance PFA",
            "achievement_details": "Présentation finale et livraison du mémoire SR3Urban.",
            "progress_percentage": 75
        },
    ]

    for m in milestones:
        TimelineMilestone.objects.get_or_create(title=m["title"], defaults=m)
    print("✅ Chronologie insérée.")

    # ── 4. BIBLIOGRAPHIE ──────────────────────────────────────────
    print("📚 Insertion de la bibliographie...")
    bibliography = [
        {
            "title": "Image Super-Resolution via Iterative Refinement (SR3)",
            "authors": "Saharia C., Ho J., Chan W., Salimans T., Fleet D., Norouzi M.",
            "source_info": "IEEE TPAMI — arXiv:2104.07636",
            "ref_type": "article",
            "url": "https://arxiv.org/abs/2104.07636"
        },
        {
            "title": "Denoising Diffusion Probabilistic Models (DDPM)",
            "authors": "Ho J., Jain A., Abbeel P.",
            "source_info": "NeurIPS 2020 — arXiv:2006.11239",
            "ref_type": "article",
            "url": "https://arxiv.org/abs/2006.11239"
        },
        {
            "title": "Attention Is All You Need (Transformer)",
            "authors": "Vaswani A., Shazeer N., Parmar N., et al.",
            "source_info": "NeurIPS 2017 — arXiv:1706.03762",
            "ref_type": "article",
            "url": "https://arxiv.org/abs/1706.03762"
        },
        {
            "title": "Image Quality Assessment: SSIM",
            "authors": "Wang Z., Bovik A., Sheikh H., Simoncelli E.",
            "source_info": "IEEE Transactions on Image Processing, 2004",
            "ref_type": "article",
            "url": "https://ieeexplore.ieee.org/document/1284395"
        },
        {
            "title": "U-Net: Convolutional Networks for Biomedical Image Segmentation",
            "authors": "Ronneberger O., Fischer P., Brox T.",
            "source_info": "MICCAI 2015 — arXiv:1505.04597",
            "ref_type": "article",
            "url": "https://arxiv.org/abs/1505.04597"
        },
        {
            "title": "SGDR: Stochastic Gradient Descent with Warm Restarts",
            "authors": "Loshchilov I., Hutter F.",
            "source_info": "ICLR 2017 — arXiv:1608.03983",
            "ref_type": "article",
            "url": "https://arxiv.org/abs/1608.03983"
        },
        {
            "title": "Perceptual Losses for Real-Time Style Transfer and Super-Resolution",
            "authors": "Johnson J., Alahi A., Fei-Fei L.",
            "source_info": "ECCV 2016 — arXiv:1603.08155",
            "ref_type": "article",
            "url": "https://arxiv.org/abs/1603.08155"
        },
        {
            "title": "PyTorch: An Imperative Style Deep Learning Library",
            "authors": "Paszke A., Gross S., Massa F., et al.",
            "source_info": "NeurIPS 2019",
            "ref_type": "framework",
            "url": "https://pytorch.org/"
        },
    ]

    for b in bibliography:
        BibliographyReference.objects.get_or_create(title=b["title"], defaults=b)
    print("✅ Bibliographie insérée.")

    print("\n🎉 Base de données SR3Urban initialisée avec succès !")
    print("─" * 50)
    print(f"  Étudiant  : Mohamed Aziz Zaag")
    print(f"  Encadrant : Ben Khalifa Aymen")
    print(f"  Projet    : SR3Urban — PFA 2025–2026")
    print("─" * 50)


if __name__ == '__main__':
    seed_database()