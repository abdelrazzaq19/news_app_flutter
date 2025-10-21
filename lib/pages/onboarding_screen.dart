import 'package:flutter/material.dart';
import 'package:news_app/pages/landing_page.dart';
import 'article_view.dart'; // Import halaman utama Anda

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Welcome',
      description: 'Welcome to our news app!',
      icon: Icons.newspaper,
      color: Colors.green,
    ),
    OnboardingData(
      title: 'Berita dari Seluruh Dunia',
      description: 'Akses berita terkini dari berbagai sumber terpercaya di seluruh dunia',
      icon: Icons.public,
      color: Colors.blue,
    ),
    OnboardingData(
      title: 'Stay Updated',
      description: 'Get the latest news from around the world',
      icon: Icons.update,
      color: Colors.cyan,
    ),
    OnboardingData(
      title: 'Notifikasi Real-time',
      description: 'Dapatkan pemberitahuan instan untuk berita terpenting',
      icon: Icons.notifications_active,
      color: Colors.amber,
    ),
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Method untuk navigasi ke landing page
  void _navigateToLandingPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LandingPage()),
    );
  }

  // Method untuk skip onboarding
  void _skipOnboarding() {
    _navigateToLandingPage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _skipOnboarding, // Panggil method skip
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            // Tambahkan PageView dan logic navigasi di sini
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_pages[index]);
                },
              ),
            ),

            // Tambahkan indicator dan next button
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index 
                              ? Colors.blue 
                              : Colors.grey.withOpacity(0.4),
                        ),
                      );
                    }),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Next/Mulai button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) {
                        // Jika di halaman terakhir, navigasi ke landing page
                        _navigateToLandingPage();
                      } else {
                        // Jika bukan halaman terakhir, lanjut ke halaman berikutnya
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == _pages.length - 1 ? "Start" : "Next",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method _buildOnboardingPage yang sudah ada
  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              data.icon,
              size: 100,
              color: data.color,
            ),
          ),
          SizedBox(height: 48),
          Text(
            data.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            data.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}