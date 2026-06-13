import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class ProfileConstants {
  static const int initialFollowers = 269;
  static const int posts = 15;
  static const int following = 123;
  static const int projects = 8;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey.shade100,
        cardColor: Colors.white,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
      ),
      home: ProfileScreen(
        isDarkMode: isDarkMode,
        onToggleTheme: toggleTheme,
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isFollowing = false;
  int followers = ProfileConstants.initialFollowers;

  void followUser() {
    setState(() {
      isFollowing = !isFollowing;
      followers += isFollowing ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ProfileAppBar(
        color: color,
        isDarkMode: widget.isDarkMode,
        onToggleTheme: widget.onToggleTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(color: color),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const ProfileNameSection(),
                  const SizedBox(height: 24),
                  ProfileStats(followers: followers),
                  const SizedBox(height: 20),
                  ProfileActions(
                    isFollowing: isFollowing,
                    onFollow: followUser,
                    color: color,
                  ),
                  const SizedBox(height: 32),
                  const SectionTitle(title: "About Me"),
                  const SizedBox(height: 12),
                  const AboutCard(),
                  const SizedBox(height: 32),
                  const SectionTitle(title: "Profile Details"),
                  const SizedBox(height: 12),
                  StudentInfoCard(color: color),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ColorScheme color;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const ProfileAppBar({
    super.key,
    required this.color,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isDarkMode ? Colors.white : Colors.black;

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: iconColor),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Profile",
        style: TextStyle(color: iconColor, fontSize: 16),
      ),
      actions: [
        Icon(Icons.search, color: iconColor),
        IconButton(
          icon: Icon(
            isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: iconColor,
          ),
          onPressed: onToggleTheme,
        ),
        Icon(Icons.menu, color: iconColor),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ProfileHeader extends StatelessWidget {
  final ColorScheme color;

  const ProfileHeader({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.primary,
                color.secondary,
                color.tertiary,
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -30,
                left: -30,
                child: _softBubble(
                    color.primaryContainer.withValues(alpha: 0.25), 120),
              ),
              Positioned(
                bottom: -40,
                right: -30,
                child: _softBubble(
                    color.secondaryContainer.withValues(alpha: 0.25), 160),
              ),
              Positioned(
                top: 30,
                right: 40,
                child: _softBubble(
                    color.tertiaryContainer.withValues(alpha: 0.18), 80),
              ),
            ],
          ),
        ),
        Positioned(
          top: 130,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 14,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 56,
                backgroundColor: color.primaryContainer,
                child: Text(
                  "SM",
                  style: TextStyle(
                    color: color.onPrimaryContainer,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _softBubble(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class ProfileNameSection extends StatelessWidget {
  const ProfileNameSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      children: [
        const Text(
          "Sadia Mabsurah",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        Text(
          "Software Engineering Student",
          style: TextStyle(
            color: color.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on_outlined,
                size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              "Sylhet, Bangladesh",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileStats extends StatelessWidget {
  final int followers;

  const ProfileStats({super.key, required this.followers});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          _item("${ProfileConstants.posts}", "Posts"),
          _item("$followers", "Followers"),
          _item("${ProfileConstants.following}", "Following"),
          _item("${ProfileConstants.projects}", "Projects"),
        ],
      ),
    );
  }

  Widget _item(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class ProfileActions extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onFollow;
  final ColorScheme color;

  const ProfileActions({
    super.key,
    required this.isFollowing,
    required this.onFollow,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final followDarkColor = color.primary.withValues(alpha: 0.75);

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52,
            child: isFollowing
                ? ElevatedButton.icon(
              onPressed: onFollow,
              icon: const Icon(Icons.check, size: 18),
              label: const Text("Following"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: isDark
                    ? color.primary.withValues(alpha: 0.18)
                    : color.primary.withValues(alpha: 0.12),
                foregroundColor: color.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            )
                : FilledButton.icon(
              onPressed: onFollow,
              icon: const Icon(Icons.person_add),
              label: const Text("Follow"),
              style: FilledButton.styleFrom(
                backgroundColor:
                isDark ? followDarkColor : color.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 52,
            child: FilledButton.tonalIcon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text("Message"),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          height: 52,
          width: 52,
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? followDarkColor : color.primary,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                      alpha: isDark ? 0.25 : 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.call_rounded, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Text(
        "I am a Software Engineering student passionate about UI/UX design and mobile app development. I enjoy creating clean, simple, and user-friendly interfaces that improve user experience.",
        style: TextStyle(height: 1.6),
      ),
    );
  }
}

class StudentInfoCard extends StatelessWidget {
  final ColorScheme color;

  const StudentInfoCard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _row(context, Icons.email_outlined, "Email",
              "mabsurahsadia@gmail.com"),
          _row(context, Icons.school_outlined, "Institute",
              "Metropolitan University"),
          _row(context, Icons.book_outlined, "Department",
              "Software Engineering"),
          _row(context, Icons.badge_outlined, "Student ID", "232-134-002"),
          _row(context, Icons.groups_outlined, "Batch", "5th"),
        ],
      ),
    );
  }

  Widget _row(
      BuildContext context,
      IconData icon,
      String label,
      String value,
      ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color.primary),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 85,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}