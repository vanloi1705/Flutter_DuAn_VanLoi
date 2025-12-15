import 'package:flutter/material.dart';

class Baitap6Classroom extends StatelessWidget {
  const Baitap6Classroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ClassroomCard(
            title: 'Lập trình ứng dụng cho các thiết bị di động',  // ← Sửa lại tiêu đề đúng
            code: '2025-2026.1.TIN4583.001',
            students: '56 học viên',
            gradientColors: [Color(0xFF263238), Color(0xFF37474F)],
            iconData: Icons.nightlight_round,
            imageUrl: 'assets/images/anhclassroom1.jpg',
            isAsset: true,
          ),
          SizedBox(height: 16),
          ClassroomCard(
            title: 'Lập trình ứng dụng cho các thiết bị di động',
            code: '2025-2026.1.TIN4403.006',
            students: '55 học viên',
            gradientColors: [Color(0xFFBF360C), Color(0xFFD84315)],
            iconData: Icons.account_balance,
            imageUrl: 'assets/images/anhclassroom2.jpg',
            isAsset: true,
          ),
          SizedBox(height: 16),
          ClassroomCard(
            title: 'Lập trình ứng dụng cho các thiết bị di động',
            code: '2025-2026.1.TIN4403.005',
            students: '52 học viên',
            gradientColors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
            iconData: Icons.auto_stories,
            imageUrl: 'assets/images/anhclassroom3.jpg',
            isAsset: true,
          ),
          SizedBox(height: 16),
          ClassroomCard(
            title: 'Lập trình ứng dụng cho các thiết bị di động',
            code: '2025-2026.1.TIN4403.004',
            students: '50 học viên',
            gradientColors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
            iconData: Icons.palette,
            imageUrl: 'assets/images/anhclassroom4.jpg',
            isAsset: true,
          ),
          SizedBox(height: 16),
          ClassroomCard(
            title: 'Lập trình ứng dụng cho các thiết bị di động',
            code: '2025-2026.1.TIN4403.003',
            students: '53 học viên',
            gradientColors: [Color(0xFF263238), Color(0xFF37474F)],
            iconData: Icons.psychology,
            imageUrl: 'assets/images/anhclassroom1.jpg',
            isAsset: true,
          ),
        ],
      ),
    );
  }
}

class ClassroomCard extends StatelessWidget {
  final String title;
  final String code;
  final String students;
  final List<Color> gradientColors;
  final IconData iconData;
  final String imageUrl;
  final bool isAsset;

  const ClassroomCard({
    super.key,
    required this.title,
    required this.code,
    required this.students,
    required this.gradientColors,
    required this.iconData,
    required this.imageUrl,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: isAsset
                  ? Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        );
                      },
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            
            // Dark overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            
            // Icon circle
            Positioned(
              right: 16,
              top: 16,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
            
            // Menu button
            Positioned(
              right: 4,
              top: 4,
              child: IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
            
            // Content
            Positioned(
              left: 16,
              right: 80,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    code,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                      letterSpacing: 0.25,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    students,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
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
}