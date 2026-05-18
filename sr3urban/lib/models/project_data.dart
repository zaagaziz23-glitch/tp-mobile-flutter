class ProjectInfo {
  final String title;
  final String subtitle;
  final String description;
  final String student;
  final String supervisor;
  final String school;
  final String year;
  final String email;
  final List<String> technologies;
  final List<String> features;

  const ProjectInfo({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.student,
    required this.supervisor,
    required this.school,
    required this.year,
    required this.email,
    required this.technologies,
    required this.features,
  });
}

class UserCardInfo {
  final String name;
  final String role;
  final String team;
  final String avatar;
  final List<String> metadata;

  const UserCardInfo({
    required this.name,
    required this.role,
    required this.team,
    required this.avatar,
    required this.metadata,
  });
}

class TaskItem {
  final String name;
  final String startDate;
  final String? finishDate;
  final double progress;
  final String status;

  const TaskItem({
    required this.name,
    required this.startDate,
    this.finishDate,
    required this.progress,
    required this.status,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      name: json['title'] ?? '',
      startDate: json['start_date'] ?? 'Sept 2025',
      finishDate: json['finish_date'],
      progress: json['status'] == 'completed' ? 100.0 : 40.0,
      status: json['status'] ?? 'todo',
    );
  }
}

class MilestoneItem {
  final String title;
  final String date;
  final String description;
  final bool isCompleted;

  const MilestoneItem({
    required this.title,
    required this.date,
    required this.description,
    required this.isCompleted,
  });

  factory MilestoneItem.fromJson(Map<String, dynamic> json) {
    return MilestoneItem(
      title: json['title'] ?? '',
      date: json['date_range'] ?? '',
      description: json['achievement_details'] ?? '',
      isCompleted: json['progress_percentage'] == 100,
    );
  }
}

class ArchitectureStep {
  final String title;
  final String description;
  final String icon;
  final List<String> details;

  const ArchitectureStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.details,
  });
}

class TimelineEvent {
  final String date;
  final String title;
  final String description;
  final bool isCompleted;
  final double progress;

  const TimelineEvent({
    required this.date,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.progress,
  });
}

class BibliographyEntry {
  final String title;
  final String authors;
  final String year;
  final String source;
  final String? url;
  final String type;

  const BibliographyEntry({
    required this.title,
    required this.authors,
    required this.year,
    required this.source,
    this.url,
    required this.type,
  });

  factory BibliographyEntry.fromJson(Map<String, dynamic> json) {
    return BibliographyEntry(
      title: json['title'] ?? '',
      authors: json['authors'] ?? '',
      year: json['year'] ?? '2026',
      source: json['source_info'] ?? '',
      url: json['url'],
      type: json['ref_type'] ?? 'article',
    );
  }
}

// ==================== DONNÉES DU PROJET SR3Urban ====================

final projectInfo = const ProjectInfo(
  title: 'SR3Urban',
  subtitle: 'Super-Résolution d\'Images Satellitaires Urbaines',
  description:
  'SR3Urban améliore la résolution spatiale d\'images satellitaires '
      'urbaines à basse résolution par un facteur ×4, en exploitant '
      'l\'architecture SR3 basée sur les modèles de diffusion débruitage. '
      'Quatre améliorations successives (Edge Loss, Transformer Block, '
      'SSIM Loss, Cosine Annealing) ont permis de faire progresser le '
      'PSNR de 14.18 dB (baseline) à 19.49 dB en entraînement '
      'et 17.74 dB en évaluation finale.',
  student: 'Mohamed Aziz Zaag',
  supervisor: 'Ben Khalifa Aymen',
  school: 'EABA — Géomatique',
  year: '2025–2026',
  email: '',
  technologies: [
    'PyTorch',
    'Python 3.10',
    'CUDA',
    'SR3',
    'U-Net conditionnel',
    'Transformer Block',
    'SSIM Loss',
    'Edge Loss',
    'Cosine Annealing',
    'Flutter',
    'Django REST',
  ],
  features: [
    'Super-résolution ×4 (LR 16×16 → HR 64×64)',
    'Modèle de diffusion SR3 conditionné',
    'Edge Loss pour préservation des contours',
    'Transformer Block dans le bottleneck U-Net',
    'SSIM Loss pour cohérence perceptuelle',
    'Cosine Annealing avec Warm Restarts',
    'Entraînement sur RTX 4050 (6 GB VRAM)',
    'Évaluation PSNR à chaque amélioration',
  ],
);

final userCardInfo = const UserCardInfo(
  name: 'Mohamed Aziz Zaag',
  role: 'Étudiant en Géomatique',
  team: 'EABA — 2ème Année',
  avatar: '👤',
  metadata: [
    'PFA 2025–2026',
    '2ème Année Géomatique',
    'Encadrant : Ben Khalifa Aymen',
    'EABA',
  ],
);

final tasksList = [
  const TaskItem(
    name: 'Étude bibliographique SR3 & Diffusion',
    startDate: 'Sept 2025',
    finishDate: 'Oct 2025',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Implémentation Baseline SR3',
    startDate: 'Oct 2025',
    finishDate: 'Nov 2025',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Préparation & correction du dataset',
    startDate: 'Nov 2025',
    finishDate: 'Nov 2025',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Amélioration 1 : Edge Loss',
    startDate: 'Déc 2025',
    finishDate: 'Déc 2025',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Amélioration 2 : Transformer Block',
    startDate: 'Jan 2026',
    finishDate: 'Jan 2026',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Amélioration 3 : SSIM Loss',
    startDate: 'Fév 2026',
    finishDate: 'Fév 2026',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Amélioration 4 : Cosine Annealing',
    startDate: 'Mars 2026',
    finishDate: 'Mars 2026',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Rédaction du rapport final',
    startDate: 'Avr 2026',
    finishDate: 'Mai 2026',
    progress: 75.0,
    status: 'in_progress',
  ),
];

final milestonesList = [
  const MilestoneItem(
    title: 'Lancement du projet',
    date: 'Sept 2025',
    description: 'Définition du sujet, étude des modèles de diffusion et SR3',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Baseline SR3 opérationnel',
    date: 'Nov 2025',
    description: 'PSNR baseline = 14.18 dB — modèle de référence établi',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Edge Loss intégrée',
    date: 'Déc 2025',
    description: 'PSNR 14.18 → 15.83 dB (+1.65 dB)',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Transformer Block intégré',
    date: 'Jan 2026',
    description: 'PSNR 15.83 → 17.21 dB (+1.38 dB)',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'SSIM Loss intégrée',
    date: 'Fév 2026',
    description: 'PSNR 17.21 → 18.64 dB (+1.43 dB)',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Cosine Annealing intégré',
    date: 'Mars 2026',
    description: 'PSNR 18.64 → 19.49 dB à 60K itérations (+0.85 dB)',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Évaluation finale',
    date: 'Avr 2026',
    description: 'PSNR évaluation = 17.74 dB — modèle validé',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Soutenance PFA',
    date: 'Mai 2026',
    description: 'Présentation finale et livraison du mémoire',
    isCompleted: false,
  ),
];

final architectureSteps = [
  const ArchitectureStep(
    title: 'Acquisition du Dataset',
    description: 'Préparation des paires d\'images LR/HR',
    icon: '📥',
    details: [
      'Images satellitaires urbaines haute résolution (HR 64×64)',
      'Dégradation bicubique pour générer les LR (16×16)',
      'Correction du problème de résolution LR détecté en cours de PFA',
      'Normalisation dans l\'intervalle [-1, 1]',
    ],
  ),
  const ArchitectureStep(
    title: 'Modèle SR3 — Baseline',
    description: 'Architecture de diffusion débruitage conditionnée',
    icon: '🧠',
    details: [
      'U-Net conditionnel avec embedding temporel sinusoïdal',
      'Conditionnement : concaténation LR interpolée + bruit gaussien',
      'Processus de diffusion Markovien en T=2000 pas',
      'PSNR baseline = 14.18 dB',
    ],
  ),
  const ArchitectureStep(
    title: 'Amélioration 1 — Edge Loss',
    description: 'Perte sur les contours via filtre Sobel',
    icon: '✏️',
    details: [
      'Filtre Sobel appliqué sur HR prédit et HR réelle',
      'Perte totale = L1 Loss + λ × Edge Loss (λ=0.1)',
      'Meilleure netteté des contours urbains reconstruits',
      'PSNR = 15.83 dB (+1.65 dB)',
    ],
  ),
  const ArchitectureStep(
    title: 'Amélioration 2 — Transformer Block',
    description: 'Self-Attention dans le bottleneck de l\'U-Net',
    icon: '🔀',
    details: [
      'Multi-Head Self-Attention dans le bottleneck',
      'Capture des dépendances à longue distance',
      'Feed-Forward + LayerNorm',
      'PSNR = 17.21 dB (+1.38 dB)',
    ],
  ),
  const ArchitectureStep(
    title: 'Amélioration 3 — SSIM Loss',
    description: 'Perte de similarité structurelle perceptuelle',
    icon: '👁️',
    details: [
      'SSIM calculé sur fenêtres 11×11',
      'Perte = 0.85 × L1 + 0.15 × (1 - SSIM)',
      'Cohérence perceptuelle améliorée',
      'PSNR = 18.64 dB (+1.43 dB)',
    ],
  ),
  const ArchitectureStep(
    title: 'Amélioration 4 — Cosine Annealing',
    description: 'Planificateur LR avec Warm Restarts',
    icon: '📉',
    details: [
      'CosineAnnealingWarmRestarts : T_0=10K, T_mult=2',
      'LR entre η_min=1e-6 et η_max=1e-4',
      'Convergence stable sur 60 000 itérations',
      'PSNR = 19.49 dB (+0.85 dB) — meilleur résultat',
    ],
  ),
];

final timelineEvents = [
  const TimelineEvent(
    date: 'Septembre 2025',
    title: 'Lancement du projet',
    description:
    'Définition du sujet PFA, revue des modèles de diffusion '
        '(DDPM, SR3, DDIM), choix de l\'architecture et du framework PyTorch.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Octobre – Novembre 2025',
    title: 'Baseline SR3',
    description:
    'Implémentation de l\'architecture SR3 de base. '
        'Préparation du dataset satellitaire urbain. '
        'PSNR baseline établi à 14.18 dB.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Décembre 2025',
    title: 'Edge Loss',
    description:
    'Intégration du filtre Sobel dans la fonction de perte. '
        'PSNR : 14.18 → 15.83 dB. Gain : +1.65 dB.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Janvier 2026',
    title: 'Transformer Block',
    description:
    'Ajout du bloc Self-Attention dans le bottleneck U-Net. '
        'PSNR : 15.83 → 17.21 dB. Gain : +1.38 dB.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Février 2026',
    title: 'SSIM Loss',
    description:
    'Remplacement partiel de L1 par SSIM Loss. '
        'PSNR : 17.21 → 18.64 dB. Gain : +1.43 dB.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Mars 2026',
    title: 'Cosine Annealing',
    description:
    'Planificateur CosineAnnealingWarmRestarts sur 60K itérations. '
        'PSNR train : 18.64 → 19.49 dB. Gain : +0.85 dB.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Avril 2026',
    title: 'Évaluation & Analyse',
    description:
    'Évaluation finale : PSNR = 17.74 dB. '
        'Analyse de l\'écart train/eval (correction dataset + overfitting).',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Avril – Mai 2026',
    title: 'Rédaction du rapport',
    description:
    'Rédaction du mémoire PFA en cours. '
        'Chapitre 2 (État de l\'art) finalisé. Soutenance prévue en Mai 2026.',
    isCompleted: false,
    progress: 0.75,
  ),
];

final bibliographyEntries = [
  const BibliographyEntry(
    title: 'Image Super-Resolution via Iterative Refinement (SR3)',
    authors: 'Saharia C., Ho J., Chan W., Salimans T., Fleet D., Norouzi M.',
    year: '2022',
    source: 'IEEE TPAMI — arXiv:2104.07636',
    url: 'https://arxiv.org/abs/2104.07636',
    type: 'Article',
  ),
  const BibliographyEntry(
    title: 'Denoising Diffusion Probabilistic Models (DDPM)',
    authors: 'Ho J., Jain A., Abbeel P.',
    year: '2020',
    source: 'NeurIPS 2020 — arXiv:2006.11239',
    url: 'https://arxiv.org/abs/2006.11239',
    type: 'Article',
  ),
  const BibliographyEntry(
    title: 'Attention Is All You Need (Transformer)',
    authors: 'Vaswani A., Shazeer N., Parmar N., et al.',
    year: '2017',
    source: 'NeurIPS 2017 — arXiv:1706.03762',
    url: 'https://arxiv.org/abs/1706.03762',
    type: 'Article',
  ),
  const BibliographyEntry(
    title: 'Image Quality Assessment: From Error Visibility to Structural Similarity (SSIM)',
    authors: 'Wang Z., Bovik A., Sheikh H., Simoncelli E.',
    year: '2004',
    source: 'IEEE Transactions on Image Processing',
    url: 'https://ieeexplore.ieee.org/document/1284395',
    type: 'Article',
  ),
  const BibliographyEntry(
    title: 'U-Net: Convolutional Networks for Biomedical Image Segmentation',
    authors: 'Ronneberger O., Fischer P., Brox T.',
    year: '2015',
    source: 'MICCAI 2015 — arXiv:1505.04597',
    url: 'https://arxiv.org/abs/1505.04597',
    type: 'Article',
  ),
  const BibliographyEntry(
    title: 'SGDR: Stochastic Gradient Descent with Warm Restarts',
    authors: 'Loshchilov I., Hutter F.',
    year: '2017',
    source: 'ICLR 2017 — arXiv:1608.03983',
    url: 'https://arxiv.org/abs/1608.03983',
    type: 'Article',
  ),
  const BibliographyEntry(
    title: 'PyTorch: An Imperative Style Deep Learning Library',
    authors: 'Paszke A., Gross S., Massa F., et al.',
    year: '2019',
    source: 'NeurIPS 2019',
    url: 'https://pytorch.org/',
    type: 'Library',
  ),
  const BibliographyEntry(
    title: 'Perceptual Losses for Real-Time Style Transfer and Super-Resolution',
    authors: 'Johnson J., Alahi A., Fei-Fei L.',
    year: '2016',
    source: 'ECCV 2016 — arXiv:1603.08155',
    url: 'https://arxiv.org/abs/1603.08155',
    type: 'Article',
  ),
];