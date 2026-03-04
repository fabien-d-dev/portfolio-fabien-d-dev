import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './widget/fixed_top_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  static const Color _backgroundColor = Color(0xFFE0E0E0);
  static const Color _tagColor = Color.fromARGB(203, 0, 0, 0);
  static const Color _descColor = Color.fromARGB(160, 0, 0, 0);
  static const Color _titleColor = Color.fromARGB(178, 0, 0, 0);

  final List<Map<String, String>> jobs = const [
    {
      'title': 'Beernotebook',
      'image':
          'https://fra.cloud.appwrite.io/v1/storage/buckets/beernotebook-storage-0369/files/69a57bec00184fc4e5b5/view?project=beernotebook-0369',
      'desc':
          "Projet phare en développement continu, Beernotebook est une plateforme complète dédiée aux amateurs de bières. Initialement conçue avec React Native, j'ai piloté sa refonte intégrale vers Flutter pour optimiser les performances et l'expérience utilisateur.",
      'desc2':
          "Architecture Fullstack : Node.js/Express (hébergé sur Heroku) et Firebase. Gestion d'une API maison enrichie par une API de référence externe, automatisation de tâches via des CRON jobs Node.js, et maîtrise du cycle de déploiement (Play Store).",
      'url': 'https://github.com/fabien-d-dev/beernotebook-frontend',
    },
    {
      'title': 'I\'m Looking For A Job',
      'image':
          'https://fra.cloud.appwrite.io/v1/storage/buckets/beernotebook-storage-0369/files/69a6b281003197240c11/view?project=beernotebook-0369',
      'desc':
          'Le contexte actuel du secteur IT impose d\'aller droit au but. J\'ai donc décidé d\'assumer une posture transparente avec un site au design épuré. Pas de superflu, juste l\'information nécessaire pour que vous puissiez évaluer mon profil en un clin d\'œil.',
      'desc2': 'Ce site web a été développé de façon intégrale en Dart / Flutter Web.',
      'url': '',
    },
    {
      'title': 'Unity Games',
      'image':
          'https://fra.cloud.appwrite.io/v1/storage/buckets/beernotebook-storage-0369/files/69a58e49001d1e6d9e6a/view?project=beernotebook-0369',
      'desc':
          'Issu d\'un parcours tourné vers d\'autres langages, ma curiosité m\'a poussé à explorer l\'écosystème Unity et le C#. À travers un cursus d\'apprentissage sur la plateforme officielle, j\'ai concrétisé cette exploration par trois projets. De l\'architecture du code métier à l\'aménagement de l\'univers via les outils d\'édition visuelle (No-Code), j\'ai acquis une vision transverse de la conception de jeux vidéo.',
      'desc2': '',
      'url':
          'https://play.unity.com/en/user/47e74129-f0f2-475f-afa1-83e50cd4043c',
    },
    {
      'title': 'Cote & Bois',
      'image':
          'https://fra.cloud.appwrite.io/v1/storage/buckets/beernotebook-storage-0369/files/69a598d500155e6c9e46/view?project=beernotebook-0369',
      'desc':
          'Réalisation d\'un site vitrine sur mesure pour un artisan menuisier, basé sur une personnalisation poussée d\'un template WordPress via PHP et SASS.',
      'desc2':
          'J\'ai pris en charge l\'intégralité du projet : de la gestion du nom de domaine à la mise en ligne, jusqu\'à la formation du client pour une gestion autonome de ses contenus. Une solution simple et efficace pour garantir une visibilité numérique professionnelle.',
      'url': 'https://coteetbois.net/',
    },
    {
      'title': 'Netablue',
      'image':
          'https://fra.cloud.appwrite.io/v1/storage/buckets/beernotebook-storage-0369/files/69a5962c001b2750fe5e/view?project=beernotebook-0369',
      'desc':
          'Plateforme éco-citoyenne dédiée aux porteurs de projets unifiant biodiversité et énergies renouvelables. L\'outil propose un gestionnaire de projets centralisé, une simulation de carte hydraulique des sols et un simulateur photovoltaïque. Une fonction de reconnaissance animale par IA pourra être incorporée pour enrichir l\'inventaire de la faune locale.',
      'desc2':
          'Une refonte est prévue en Dart/Flutter en 2026 pour le déploiement d\'un prototype d\'application mobile.',
      'url': '',
    },
    {
      'title': 'Tron Deep Learning',
      'image':
          'https://fra.cloud.appwrite.io/v1/storage/buckets/beernotebook-storage-0369/files/69a6b424001ae300e781/view?project=beernotebook-0369',
      'desc':
          'Un projet d\'expérimentation pour prendre le virage de l\'IA et maîtriser ses outils. J\'ai réalisé un prototype du jeu de moto Tron où l\'adversaire (en rouge) est piloté par une intelligence artificielle utilisant TensorFlow, capable d\'apprendre de chaque échec pour affiner sa stratégie en temps réel. React, TypeScript et Node.js ont été utilisés.',
      'desc2': 'Une refonte full stack en Dart est programmée pour 2026.',
      'url': 'https://github.com/fabien-d-dev/tron-dl',
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.home) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
      } else if (event.logicalKey == LogicalKeyboardKey.end) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: Stack(
          children: [
            Positioned.fill(
              child: Scrollbar(
                controller: _scrollController,
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    const SliverToBoxAdapter(child: SizedBox(height: 180)),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 40 : 160,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "FABIEN, DÉVELOPPEUR FULLSTACK DART / FLUTTER",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _tagColor,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Passionné par l'innovation et la conception d'applications, je conçois des solutions robustes, de l'API jusqu'au pixel final.",
                              style: TextStyle(
                                fontSize: 17,
                                height: 1.6,
                                color: _descColor,
                              ),
                            ),
                            Text(
                              "Depuis 5 ans maintenant, le mobile et le web sont mon terrain de jeu. Après avoir exploré différents langages comme le JavaScript (React) ou le PHP (Laravel, WordPress), je me suis spécialisé en Dart / Flutter, principalement pour la création d'applications mobiles et occasionnellement pour le web.",
                              style: TextStyle(
                                fontSize: 17,
                                height: 1.6,
                                color: _descColor,
                              ),
                            ),
                            const SizedBox(height: 10),

                            ElevatedButton.icon(
                              onPressed: () =>
                                  _launchURL('https://github.com/fabien-d-dev'),
                              icon: const Icon(Icons.language),
                              label: const Text("Voir le profil"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _backgroundColor,
                                foregroundColor: Colors.black,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 40 : 160,
                          vertical: 20,
                        ),
                        child: Text(
                          "MES PROJETS",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            color: _titleColor,
                          ),
                        ),
                      ),
                    ),
                    // THE GRID
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 30 : 150,
                      ),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 1 : 2,
                          crossAxisSpacing: 40,
                          mainAxisSpacing: isMobile ? 20 : 0,
                          childAspectRatio: isMobile ? 1.1 : 1.05,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          bool isOddColumn = !isMobile && (index % 2 != 0);

                          return RepaintBoundary(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: isOddColumn ? 60 : 20,
                                bottom: isOddColumn ? 20 : 60,
                              ),
                              child: MorphicJobCard(
                                job: jobs[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(
                                        milliseconds: 600,
                                      ),
                                      reverseTransitionDuration: const Duration(
                                        milliseconds: 400,
                                      ),
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => ProjectDetailPage(
                                            job: jobs[index],
                                          ),
                                      transitionsBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            child,
                                          ) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }, childCount: jobs.length),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              ),
            ),

            // FIXED BANNER
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: FixedTopBanner(backgroundColor: _backgroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CARD WIDGET
class MorphicJobCard extends StatefulWidget {
  final Map<String, String> job;
  final VoidCallback onTap;
  const MorphicJobCard({super.key, required this.job, required this.onTap});

  @override
  State<MorphicJobCard> createState() => _MorphicJobCardState();
}

class _MorphicJobCardState extends State<MorphicJobCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(24),
            boxShadow: isHovered
                ? [
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                    ),
                  ]
                : [
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-8, -8),
                      blurRadius: 12,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      offset: const Offset(8, 8),
                      blurRadius: 20,
                    ),
                  ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.job['image']!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      imageUrl: widget.job['image']!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey[300]),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.job['title']!.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Icon(Icons.arrow_outward_rounded, size: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// DETAIL PAGE
class ProjectDetailPage extends StatelessWidget {
  final Map<String, String> job;
  const ProjectDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900;
    double horizontalPadding = isMobile ? 20.0 : 200.0;

    final String? projectUrl = job['url'];
    final bool hasUrl = projectUrl != null && projectUrl.isNotEmpty;

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.escape): () {
          Navigator.of(context).pop();
        },
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          backgroundColor: const Color(0xFFE0E0E0),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 30,
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: job['image']!,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(job['image']!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  job['title']!,
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  job['desc']!,
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 10),
                if (job['desc2'] != null && job['desc2']!.isNotEmpty) ...[
                  const SizedBox(height: 15),
                  Text(
                    job['desc2']!,
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
                const SizedBox(height: 20),
                if (hasUrl) ...[
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () => _launchURL(projectUrl),
                    icon: const Icon(Icons.language),
                    label: const Text("Voir le projet en ligne"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE0E0E0),
                      foregroundColor: Colors.black,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw Exception('Impossible d\'ouvrir le lien : $urlString');
  }
}
