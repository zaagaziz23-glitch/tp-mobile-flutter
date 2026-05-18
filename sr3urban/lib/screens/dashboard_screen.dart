import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_data.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();

  late Future<List<dynamic>> _tasksFuture;
  late Future<List<dynamic>> _timelineFuture;
  late Future<List<dynamic>> _bibliographyFuture;
  late Future<List<dynamic>> _profilesFuture;

  @override
  void initState() {
    super.initState();
    _refreshAllData();
  }

  void _refreshAllData() {
    setState(() {
      _tasksFuture = _apiService.fetchTasks();
      _timelineFuture = _apiService.fetchTimeline();
      _bibliographyFuture = _apiService.fetchBibliography();
      _profilesFuture = _apiService.fetchProfiles();
    });
  }

  Future<void> _launchURL(String urlString) async {
    if (urlString.isEmpty) return;
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible d\'ouvrir le lien : $urlString')),
      );
    }
  }

  Color _getRefTypeColor(String? type) {
    switch (type) {
      case 'dataset':   return const Color(0xFF3498db);
      case 'article':   return const Color(0xFF9b59b6);
      case 'framework': return const Color(0xFF1abc9c);
      default:          return const Color(0xFF95a5a6);
    }
  }

  void _showAddDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a5276).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person_outline,
                    color: Color(0xFF1a5276)),
              ),
              title: Text('Gérer le profil',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              onTap: () async {
                Navigator.pop(context);
                final profiles = await _profilesFuture;
                if (profiles.isNotEmpty) {
                  _showEditProfileDialog(profiles.first);
                } else {
                  _showCreateProfileDialog();
                }
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF27ae60).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.task_alt, color: Color(0xFF27ae60)),
              ),
              title: Text('Ajouter une tâche',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                _showAddTaskDialog();
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFe67e22).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.timeline, color: Color(0xFFe67e22)),
              ),
              title: Text('Ajouter un jalon',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                _showAddTimelineDialog();
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF9b59b6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.menu_book, color: Color(0xFF9b59b6)),
              ),
              title: Text('Ajouter une référence',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                _showAddBibliographyDialog();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(children: [
          const Icon(Icons.task_alt, color: Color(0xFF1a5276), size: 20),
          const SizedBox(width: 8),
          Text('Nouvelle Tâche',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: _inputDecoration('Titre'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descController,
              decoration: _inputDecoration('Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler',
                style: GoogleFonts.inter(color: Colors.grey)),
          ),
          ElevatedButton(
            style: _btnStyle(),
            onPressed: () async {
              if (titleController.text.isNotEmpty) {
                final success = await _apiService.createNewTask(
                    titleController.text, descController.text);
                if (success) {
                  _refreshAllData();
                  Navigator.pop(context);
                }
              }
            },
            child: Text('Ajouter',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showAddTimelineDialog() {
    final titleController = TextEditingController();
    final dateRangeController = TextEditingController();
    final detailsController = TextEditingController();
    double progress = 0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(children: [
            const Icon(Icons.timeline, color: Color(0xFF1a5276), size: 20),
            const SizedBox(width: 8),
            Text('Nouveau Jalon',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
          ]),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: titleController,
                    decoration: _inputDecoration('Titre')),
                const SizedBox(height: 12),
                TextField(
                    controller: dateRangeController,
                    decoration: _inputDecoration('Période (ex: Oct 2025)')),
                const SizedBox(height: 12),
                TextField(
                    controller: detailsController,
                    decoration: _inputDecoration('Détails')),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Progression',
                        style: GoogleFonts.inter(
                            color: const Color(0xFF475569),
                            fontWeight: FontWeight.w500)),
                    Text('${progress.toInt()}%',
                        style: GoogleFonts.inter(
                            color: const Color(0xFF1a5276),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFF1a5276),
                    thumbColor: const Color(0xFF1a5276),
                    inactiveTrackColor:
                    const Color(0xFF1a5276).withOpacity(0.2),
                  ),
                  child: Slider(
                    value: progress,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    onChanged: (val) =>
                        setDialogState(() => progress = val),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler',
                  style: GoogleFonts.inter(color: Colors.grey)),
            ),
            ElevatedButton(
              style: _btnStyle(),
              onPressed: () async {
                if (titleController.text.isNotEmpty) {
                  final success =
                  await _apiService.createTimelineEvent({
                    "title": titleController.text,
                    "date_range": dateRangeController.text,
                    "achievement_details": detailsController.text,
                    "progress_percentage": progress.toInt(),
                  });
                  if (success) {
                    _refreshAllData();
                    Navigator.pop(context);
                  }
                }
              },
              child: Text('Ajouter',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddBibliographyDialog() {
    final titleController = TextEditingController();
    final authorsController = TextEditingController();
    final sourceController = TextEditingController();
    final urlController = TextEditingController();
    String refType = 'article';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(children: [
            const Icon(Icons.menu_book, color: Color(0xFF1a5276), size: 20),
            const SizedBox(width: 8),
            Text('Nouvelle Référence',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
          ]),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: refType,
                  decoration: _inputDecoration('Type'),
                  items: ['article', 'dataset', 'framework']
                      .map((t) => DropdownMenuItem(
                      value: t, child: Text(t.toUpperCase())))
                      .toList(),
                  onChanged: (val) =>
                      setDialogState(() => refType = val!),
                ),
                const SizedBox(height: 12),
                TextField(
                    controller: titleController,
                    decoration: _inputDecoration('Titre')),
                const SizedBox(height: 12),
                TextField(
                    controller: authorsController,
                    decoration: _inputDecoration('Auteurs')),
                const SizedBox(height: 12),
                TextField(
                    controller: sourceController,
                    decoration: _inputDecoration('Source')),
                const SizedBox(height: 12),
                TextField(
                    controller: urlController,
                    decoration: _inputDecoration('URL')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler',
                  style: GoogleFonts.inter(color: Colors.grey)),
            ),
            ElevatedButton(
              style: _btnStyle(),
              onPressed: () async {
                if (titleController.text.isNotEmpty) {
                  final success =
                  await _apiService.createBibliographyEntry({
                    "title": titleController.text,
                    "authors": authorsController.text,
                    "source_info": sourceController.text,
                    "url": urlController.text,
                    "ref_type": refType,
                  });
                  if (success) {
                    _refreshAllData();
                    Navigator.pop(context);
                  }
                }
              },
              child: Text('Ajouter',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateProfileDialog() {
    final nameController =
    TextEditingController(text: userCardInfo.name);
    final emailController =
    TextEditingController(text: projectInfo.email);
    final supervisorController =
    TextEditingController(text: projectInfo.supervisor);
    final descriptionController =
    TextEditingController(text: projectInfo.description);
    final roleController =
    TextEditingController(text: userCardInfo.role);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Créer un Profil',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController,        decoration: _inputDecoration('Nom complet')),
              const SizedBox(height: 12),
              TextField(controller: emailController,       decoration: _inputDecoration('Email')),
              const SizedBox(height: 12),
              TextField(controller: supervisorController,  decoration: _inputDecoration('Encadrant')),
              const SizedBox(height: 12),
              TextField(controller: descriptionController, decoration: _inputDecoration('Description du projet'), maxLines: 3),
              const SizedBox(height: 12),
              TextField(controller: roleController,        decoration: _inputDecoration('Rôle')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler',
                style: GoogleFonts.inter(color: Colors.grey)),
          ),
          ElevatedButton(
            style: _btnStyle(),
            onPressed: () async {
              final success = await _apiService.createProfile({
                "full_name": nameController.text,
                "email": emailController.text,
                "supervisor": supervisorController.text,
                "project_description": descriptionController.text,
                "role": roleController.text,
              });
              if (success) {
                _refreshAllData();
                Navigator.pop(context);
              }
            },
            child: Text('Créer',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(Map<String, dynamic> profile) {
    final nameController =
    TextEditingController(text: profile['full_name']);
    final emailController =
    TextEditingController(text: profile['email'] ?? '');
    final supervisorController =
    TextEditingController(text: profile['supervisor'] ?? '');
    final descriptionController =
    TextEditingController(text: profile['project_description'] ?? '');
    final roleController =
    TextEditingController(text: profile['role'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Modifier le Profil',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController,        decoration: _inputDecoration('Nom complet')),
              const SizedBox(height: 12),
              TextField(controller: emailController,       decoration: _inputDecoration('Email')),
              const SizedBox(height: 12),
              TextField(controller: supervisorController,  decoration: _inputDecoration('Encadrant')),
              const SizedBox(height: 12),
              TextField(controller: descriptionController, decoration: _inputDecoration('Description'), maxLines: 3),
              const SizedBox(height: 12),
              TextField(controller: roleController,        decoration: _inputDecoration('Rôle')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler',
                style: GoogleFonts.inter(color: Colors.grey)),
          ),
          ElevatedButton(
            style: _btnStyle(),
            onPressed: () async {
              final success = await _apiService.updateUserProfile(
                  profile['id'], {
                "full_name": nameController.text,
                "email": emailController.text,
                "supervisor": supervisorController.text,
                "project_description": descriptionController.text,
                "role": roleController.text,
              });
              if (success) {
                _refreshAllData();
                Navigator.pop(context);
              }
            },
            child: Text('Enregistrer',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ─── Helpers décorations ──────────────────────────────────────
  InputDecoration _inputDecoration(String label) => InputDecoration(
    labelText: label,
    labelStyle: GoogleFonts.inter(color: const Color(0xFF64748b)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF1a5276), width: 1.5),
    ),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  );

  ButtonStyle _btnStyle() => ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1a5276),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fafc),
      body: RefreshIndicator(
        color: const Color(0xFF1a5276),
        onRefresh: () async => _refreshAllData(),
        child: CustomScrollView(
          slivers: [
            // ── AppBar ─────────────────────────────────────────
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF1a5276),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  onPressed: _refreshAllData,
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Dashboard',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1a5276),
                        Color(0xFF0d2b47),
                      ],
                    ),
                  ),
                  child: Stack(children: [
                    Positioned(
                      right: -20,
                      top: 10,
                      child: Icon(Icons.dashboard,
                          size: 170,
                          color: Colors.white.withOpacity(0.06)),
                    ),
                    Positioned(
                      left: 24,
                      bottom: 60,
                      child: Text(
                        'SR3Urban — Vue globale du projet',
                        style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 13),
                      ),
                    ),
                  ]),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildDynamicUserCard(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Chronologie du Projet'),
                  const SizedBox(height: 16),
                  _buildDynamicTimelineBlock(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Gestion des Tâches'),
                  const SizedBox(height: 16),
                  _buildDynamicTasksTable(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Bibliographie & Références'),
                  const SizedBox(height: 16),
                  _buildDynamicBibliographyBlock(),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1a5276),
        onPressed: _showAddDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDynamicUserCard() {
    return FutureBuilder<List<dynamic>>(
      future: _profilesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(
                      color: Color(0xFF1a5276))));
        }
        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return _buildUserCard();
        }

        final profile = snapshot.data!.first;
        return GestureDetector(
          onTap: () => _showEditProfileDialog(profile),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1a5276), Color(0xFF0d2b47)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1a5276).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white.withOpacity(0.3), width: 2),
                ),
                child: const Center(
                    child: Text('👤',
                        style: TextStyle(fontSize: 30))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile['full_name'] ?? 'Utilisateur',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile['role'] ?? 'Étudiant en Géomatique',
                      style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile['email'] ?? '',
                      style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.70),
                          fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Encadrant : ${profile['supervisor'] ?? ''}',
                      style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 11),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.edit,
                  color: Colors.white38, size: 20),
            ]),
          ),
        );
      },
    );
  }

  Widget _buildUserCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1a5276), Color(0xFF0d2b47)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1a5276).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.white.withOpacity(0.3), width: 2),
          ),
          child: Center(
              child: Text(userCardInfo.avatar,
                  style: const TextStyle(fontSize: 30))),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userCardInfo.name,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(userCardInfo.role,
                  style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13)),
              const SizedBox(height: 8),
              ...userCardInfo.metadata.map((meta) => Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(meta,
                    style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.55),
                        fontSize: 11)),
              )),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(title,
        style: GoogleFonts.inter(
            color: const Color(0xFF1e293b),
            fontSize: 20,
            fontWeight: FontWeight.bold)),
  );

  // ─── Timeline ─────────────────────────────────────────────────
  Widget _buildDynamicTimelineBlock() {
    return FutureBuilder<List<dynamic>>(
      future: _timelineFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(
                      color: Color(0xFF1a5276))));
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return _emptyCard("Aucun jalon disponible.");
        }

        final timelineData = snapshot.data!;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: _cardDecoration(),
          child: Column(
            children: List.generate(timelineData.length, (index) {
              final milestone = timelineData[index];
              final isLast = index == timelineData.length - 1;
              final isCompleted =
                  milestone['progress_percentage'] == 100;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? const Color(0xFF27ae60)
                              : const Color(0xFFe2e8f0),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: isCompleted
                                  ? const Color(0xFF27ae60)
                                  : const Color(0xFFcbd5e1),
                              width: 2),
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2,
                            color: isCompleted
                                ? const Color(0xFF27ae60)
                                .withOpacity(0.3)
                                : const Color(0xFFe2e8f0),
                          ),
                        ),
                    ]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(milestone['date_range'],
                                    style: GoogleFonts.inter(
                                        color: const Color(0xFF94a3b8),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                                if (isCompleted)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                        color:
                                        const Color(0xFFdcfce7),
                                        borderRadius:
                                        BorderRadius.circular(4)),
                                    child: Text('✓',
                                        style: GoogleFonts.inter(
                                            color: const Color(
                                                0xFF166534),
                                            fontSize: 10)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(milestone['title'],
                                style: GoogleFonts.inter(
                                    color: const Color(0xFF1e293b),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(milestone['achievement_details'],
                                style: GoogleFonts.inter(
                                    color: const Color(0xFF64748b),
                                    fontSize: 12,
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  // ─── Tasks ────────────────────────────────────────────────────
  Widget _buildDynamicTasksTable() {
    return FutureBuilder<List<dynamic>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(
                      color: Color(0xFF1a5276))));
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return _emptyCard("Aucune tâche disponible.");
        }

        final tasksData = snapshot.data!;
        return Container(
          decoration: _cardDecoration(),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF1a5276),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
              child: Row(children: [
                Expanded(
                    flex: 4,
                    child: Text('Tâche',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Description',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 2,
                    child: Text('Statut',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
              ]),
            ),
            ...tasksData.map((task) {
              final isLast = task == tasksData.last;
              final bool isCompleted = task['status'] == 'completed';
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : Border(
                      bottom: BorderSide(
                          color: Colors.grey.shade100, width: 1)),
                ),
                child: Row(children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(task['title'],
                              style: GoogleFonts.inter(
                                  color: const Color(0xFF334155),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: isCompleted ? 1.0 : 0.4,
                              minHeight: 4,
                              backgroundColor:
                              const Color(0xFFe2e8f0),
                              valueColor:
                              AlwaysStoppedAnimation<Color>(
                                isCompleted
                                    ? const Color(0xFF27ae60)
                                    : const Color(0xFF5dade2),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0),
                      child: Text(task['description'] ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              color: const Color(0xFF64748b),
                              fontSize: 12)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? const Color(0xFFdcfce7)
                            : const Color(0xFFe8f4fd),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        task['status'].toString().toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: isCompleted
                              ? const Color(0xFF166534)
                              : const Color(0xFF1a5276),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            }).toList(),
          ]),
        );
      },
    );
  }

  // ─── Bibliography ─────────────────────────────────────────────
  Widget _buildDynamicBibliographyBlock() {
    return FutureBuilder<List<dynamic>>(
      future: _bibliographyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(
                      color: Color(0xFF1a5276))));
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return _emptyCard(
              "Aucune référence bibliographique disponible.");
        }

        final references = snapshot.data!;
        return Column(
          children: references.map((ref) {
            final typeColor = _getRefTypeColor(ref['ref_type']);
            return Card(
              color: Colors.white,
              elevation: 1,
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                title: Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      ref['ref_type'].toString().toUpperCase(),
                      style: TextStyle(
                          color: typeColor,
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(ref['source_info'] ?? '',
                        style: GoogleFonts.inter(
                            color: Colors.grey, fontSize: 11),
                        overflow: TextOverflow.ellipsis),
                  ),
                ]),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ref['title'] ?? '',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1e293b))),
                      if (ref['authors'] != null &&
                          ref['authors'].toString().isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(ref['authors'],
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic)),
                      ],
                    ],
                  ),
                ),
                trailing: (ref['url'] != null &&
                    ref['url'].toString().isNotEmpty)
                    ? IconButton(
                  icon: const Icon(Icons.open_in_new,
                      color: Color(0xFF1a5276), size: 20),
                  onPressed: () => _launchURL(ref['url']),
                )
                    : null,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // ─── Widgets utilitaires ──────────────────────────────────────
  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4))
    ],
  );

  Widget _emptyCard(String message) => Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    decoration: _cardDecoration(),
    child: Center(
      child: Text(message,
          style: GoogleFonts.inter(color: const Color(0xFF94a3b8))),
    ),
  );
}