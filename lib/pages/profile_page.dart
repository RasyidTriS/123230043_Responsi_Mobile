import 'package:flutter/material.dart';
import 'package:latihan_responsi/services/auth_service.dart';
import 'package:latihan_responsi/widgets/custom_widgets.dart';

/// Halaman Profile
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _username;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  /// Load username dari SharedPreferences
  void _loadUsername() async {
    final username = await AuthService.getUsername();
    if (!mounted) return;

    setState(() {
      _username = username;
      _isLoading = false;
    });
  }

  /// Handle logout
  void _handleLogout() async {
    await AuthService.logout();
    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      body: SafeArea(
        child: _isLoading
            ? const LoadingIndicator()
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 18, 16, 14),
                    child: Center(
                      child: Text(
                        'Profil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(26, 12, 26, 28),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 118,
                                height: 118,
                                decoration: const BoxDecoration(
                                  color: appCard,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: appSecondaryText,
                                  size: 72,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                _username ?? 'User',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 28),
                              const Text(
                                'Kesan: Praktikum mobile fix GOAT',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Pesan: Kirim salam sama yang namanya...',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '(sebagian teks hilang)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: appSecondaryText,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 34),
                              SizedBox(
                                width: double.infinity,
                                child: NontonButton(
                                  label: 'Logout',
                                  onPressed: _handleLogout,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
