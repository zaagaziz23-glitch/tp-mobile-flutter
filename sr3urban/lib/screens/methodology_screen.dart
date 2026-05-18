import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MethodologyScreen extends StatelessWidget {
  const MethodologyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fafc),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF6c3483),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Méthodologie & Architecture',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold)),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6c3483), Color(0xFF4a235a)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(children: [
                  Positioned(
                    right: -10,
                    top: 10,
                    child: Icon(Icons.hub_outlined,
                        size: 160, color: Colors.white.withOpacity(0.06)),
                  ),
                  Positioned(
                    left: 24,
                    bottom: 60,
                    child: Text('Architecture SR3 + 4 améliorations',
                        style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 13)),
                  ),
                ]),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── SR3 — Architecture de base ────────────────────
                _SectionTitle('Architecture de Base : SR3'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: const Color(0xFF6c3483).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.auto_awesome,
                              color: Color(0xFF6c3483), size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('SR3 — Super-Resolution via Repeated Refinement',
                                  style: GoogleFonts.inter(
                                      color: const Color(0xFF1e293b),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              Text('Modèle de diffusion débruitage conditionné',
                                  style: GoogleFonts.inter(
                                      color: const Color(0xFF64748b),
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                      ]),
                      const SizedBox(height: 16),
                      Text(
                        'SR3 est un modèle de diffusion qui apprend à reconstruire '
                            'une image haute résolution (HR) à partir d\'une image basse '
                            'résolution (LR) interpolée. Le processus de débruitage est '
                            'guidé par la concaténation de l\'image LR avec le bruit '
                            'gaussien, permettant au modèle de générer des détails réalistes '
                            'par itérations successives (T=2000 pas).',
                        style: GoogleFonts.inter(
                            color: const Color(0xFF64748b), fontSize: 14, height: 1.65),
                      ),
                      const SizedBox(height: 16),
                      _Sr3DetailRow('UNet conditionnel', 'Réseau débruiteur principal avec skip connections'),
                      _Sr3DetailRow('Embedding temporel', 'Encodage sinusoïdal du pas de diffusion t'),
                      _Sr3DetailRow('Facteur de super-résolution', '×4 (LR 16×16 → HR 64×64)'),
                      _Sr3DetailRow('Pas de diffusion (T)', '2000 pas — processus Markovien'),
                      _Sr3DetailRow('Conditionnement', 'Concaténation LR interpolée + bruit'),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── Améliorations ─────────────────────────────────
                _SectionTitle('Les 4 Améliorations Successives'),
                const SizedBox(height: 16),
                _ImprovementCard(
                  number: '01',
                  title: 'Edge Loss',
                  subtitle: 'Préservation des contours',
                  color: const Color(0xFF2980b9),
                  icon: Icons.border_style_rounded,
                  description:
                  'Ajout d\'une fonction de perte sur les contours des images, '
                      'calculée via un filtre Sobel. L\'objectif est de forcer le '
                      'modèle à mieux reconstruire les détails fins (arêtes de '
                      'bâtiments, routes, contours urbains) souvent flous dans SR3 de base.',
                  details: [
                    'Filtre Sobel appliqué sur HR prédit et HR réelle',
                    'Perte totale = L1 Loss + λ × Edge Loss (λ=0.1)',
                    'Amélioration de la netteté des contours reconstruits',
                  ],
                ),
                _ImprovementCard(
                  number: '02',
                  title: 'Transformer Block',
                  subtitle: 'Attention globale dans l\'UNet',
                  color: const Color(0xFF8e44ad),
                  icon: Icons.hub_rounded,
                  description:
                  'Intégration d\'un bloc Transformer (Self-Attention) dans '
                      'le bottleneck de l\'UNet. Cela permet au modèle de capturer '
                      'les dépendances à longue distance dans l\'image, cruciales '
                      'pour reconstruire des structures urbaines cohérentes globalement.',
                  details: [
                    'Multi-Head Self-Attention dans le bottleneck de l\'UNet',
                    'Capture des structures répétitives urbaines (grilles, blocs)',
                    'Couche Feed-Forward + normalisation LayerNorm',
                  ],
                ),
                _ImprovementCard(
                  number: '03',
                  title: 'SSIM Loss',
                  subtitle: 'Perte de similarité structurelle',
                  color: const Color(0xFF16a085),
                  icon: Icons.compare_rounded,
                  description:
                  'Remplacement partiel de la L1 Loss par la SSIM Loss '
                      '(Structural Similarity Index Measure). La SSIM évalue '
                      'la similarité perceptuelle en termes de luminance, contraste '
                      'et structure — plus alignée avec la perception humaine que la '
                      'différence pixel à pixel.',
                  details: [
                    'SSIM calculé sur fenêtres 11×11 en niveaux de gris',
                    'Perte = α × L1 + β × (1 - SSIM) avec α=0.85, β=0.15',
                    'Meilleure cohérence perceptuelle des textures urbaines',
                  ],
                ),
                _ImprovementCard(
                  number: '04',
                  title: 'Cosine Annealing',
                  subtitle: 'Planificateur de taux d\'apprentissage',
                  color: const Color(0xFFd35400),
                  icon: Icons.show_chart_rounded,
                  description:
                  'Remplacement du learning rate fixe par un planificateur '
                      'Cosine Annealing with Warm Restarts (CosineAnnealingWarmRestarts). '
                      'Le taux d\'apprentissage varie selon une courbe cosinus avec '
                      'redémarrages périodiques pour éviter les minima locaux.',
                  details: [
                    'T_0 = 10 000 itérations, T_mult = 2 (doublement période)',
                    'LR varie entre η_min=1e-6 et η_max=1e-4',
                    'Convergence plus stable sur 60 000 itérations',
                  ],
                ),
                const SizedBox(height: 28),

                // ── Dataset ───────────────────────────────────────
                _SectionTitle('Dataset & Prétraitement'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DatasetRow('Type d\'images', 'Images satellitaires urbaines'),
                      _DatasetRow('Résolution HR cible', '64×64 pixels'),
                      _DatasetRow('Résolution LR entrée', '16×16 pixels (facteur ×4)'),
                      _DatasetRow('Prétraitement LR', 'Interpolation bicubique vers 64×64'),
                      _DatasetRow('Correction dataset', 'Problème LR détecté et corrigé en cours de PFA'),
                      _DatasetRow('Normalisation', '[-1, 1] pour le processus de diffusion'),
                      _DatasetRow('Batch size', '4 (contrainte GPU 6 GB)'),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── Environnement ─────────────────────────────────
                _SectionTitle('Environnement d\'Entraînement'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2c3e50), Color(0xFF1a252f)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _TechBadge('PyTorch', const Color(0xFFee4c2c)),
                      _TechBadge('NVIDIA RTX 4050', const Color(0xFF76b900)),
                      _TechBadge('6 GB VRAM', const Color(0xFF76b900)),
                      _TechBadge('Python 3.10+', const Color(0xFF3572a5)),
                      _TechBadge('CUDA', const Color(0xFF76b900)),
                      _TechBadge('60K itérations', const Color(0xFF5dade2)),
                      _TechBadge('Optimizer : Adam', const Color(0xFFf39c12)),
                      _TechBadge('LR : 1e-4', const Color(0xFFe74c3c)),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Widgets ─────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: GoogleFonts.inter(
          color: const Color(0xFF1e293b),
          fontSize: 20,
          fontWeight: FontWeight.bold));
}

class _Sr3DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _Sr3DetailRow(this.label, this.value);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        margin: const EdgeInsets.only(top: 5),
        width: 6,
        height: 6,
        decoration: const BoxDecoration(
            color: Color(0xFF6c3483), shape: BoxShape.circle),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '$label : ',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF1e293b),
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
              TextSpan(
                  text: value,
                  style: GoogleFonts.inter(
                      color: const Color(0xFF64748b), fontSize: 13)),
            ],
          ),
        ),
      ),
    ]),
  );
}

class _ImprovementCard extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final String description;
  final List<String> details;

  const _ImprovementCard({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.description,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Text(number,
                style: GoogleFonts.inter(
                    color: color, fontSize: 16, fontWeight: FontWeight.w900)),
          ),
        ),
        title: Text(title,
            style: GoogleFonts.inter(
                color: const Color(0xFF1e293b),
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle,
            style: GoogleFonts.inter(
                color: const Color(0xFF94a3b8), fontSize: 12)),
        iconColor: color,
        collapsedIconColor: Colors.grey.shade400,
        children: [
          Text(description,
              style: GoogleFonts.inter(
                  color: const Color(0xFF64748b), fontSize: 14, height: 1.65)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.15)),
            ),
            child: Column(
              children: details
                  .map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                            color: color, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(d,
                            style: GoogleFonts.inter(
                                color: const Color(0xFF475569),
                                fontSize: 13,
                                height: 1.5)),
                      ),
                    ]),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DatasetRow extends StatelessWidget {
  final String label;
  final String value;
  const _DatasetRow(this.label, this.value);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: 160,
        child: Text(label,
            style: GoogleFonts.inter(
                color: const Color(0xFF94a3b8),
                fontSize: 13,
                fontWeight: FontWeight.w500)),
      ),
      Expanded(
        child: Text(value,
            style: GoogleFonts.inter(
                color: const Color(0xFF1e293b),
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ),
    ]),
  );
}

class _TechBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _TechBadge(this.label, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 7),
      Text(label,
          style: GoogleFonts.inter(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
    ]),
  );
}