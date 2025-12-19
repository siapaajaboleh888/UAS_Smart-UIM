import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';

class MaterialContentScreen extends StatelessWidget {
  final String title;

  const MaterialContentScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final userService = UserService();
    final user = userService.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Halaman\n1 / 20',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 8),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image Section (Matches Image 2 layout)
            Container(
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
              ),
              child: Stack(
                children: [
                  // Abstract/Course Image background
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.1,
                      child: Image.network(
                        'https://img.freepik.com/free-vector/abstract-background-design-with-green-and-white-shades_1017-32115.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // Content Layout over header
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                              ],
                            ),
                            child: const Column(
                              children: [
                                Icon(Icons.school, color: AppColors.primary, size: 40),
                                Text(
                                  'Smart UIM',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        color: Colors.black.withOpacity(0.6),
                        child: const Column(
                          children: [
                            Text(
                              'Pengantar Desain',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Antarmuka Pengguna',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Perkenalan Section
            Center(
              child: Column(
                children: [
                  const Text(
                    'Perkenalan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Image with border like in Image 2
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: user?.photoPath != null
                                ? (user!.photoPath!.startsWith('http') 
                                    ? NetworkImage(user.photoPath!) 
                                    : AssetImage(user.photoPath!) as ImageProvider)
                                : null,
                            child: user?.photoPath == null
                                ? const Icon(Icons.person, size: 45, color: Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 24),
                        // User Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoText(user?.nama ?? 'MOH. SYAIFUL ANAM', isBold: true, size: 13),
                              const SizedBox(height: 4),
                              _buildInfoText('• E-mail: ${user?.email ?? 'syaifulanam@uim.ac.id'}'),
                              _buildInfoText('• NIM: ${user?.nim ?? '2022020100078'}'),
                              _buildInfoText('• Program Studi: ${user?.prodi ?? 'Teknik Informatika'}'),
                              _buildInfoText('• Bidang Keahlian:'),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoText('- Information System'),
                                    _buildInfoText('- Web Programming and Design'),
                                    _buildInfoText('- Mobile Development'),
                                  ],
                                ),
                              ),
                              _buildInfoText('• No. HP: ${user?.phone ?? '085727930642'}'),
                              _buildInfoText('  SMS/Telp/WhatsApp'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            const Divider(indent: 24, endIndent: 24),
            const SizedBox(height: 32),

            // User Interface Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'User Interface',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildContentText(
                    'Antarmuka User Interface (UI) merupakan bagian dari komputer dan perangkat lunaknya yang dapat dilihat, didengar, disentuh, dan diajak bicara, baik secara langsung maupun dengan proses pemahaman tertentu.',
                  ),
                  const SizedBox(height: 16),
                  _buildContentText(
                    'UI yang baik adalah UI yang tidak disadari, dan UI yang membuat akan pengguna fokus pada informasi dan data tanpa perlu mengutak-atik mekanisme untuk menampilkan informasi dan melakukan hal tersebut.',
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Komponen utamanya:',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• Input', style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
                          Text('• Output', style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // Pentingnya Desain Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Pentingnya Desain UI yang Baik',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildContentText(
                    'Banyak sistem dengan fungsionalitas yang baik tapi tidak efisien, membingungkan, dan tidak berguna karena desain UI yang buruk.',
                  ),
                  const SizedBox(height: 12),
                  _buildContentText(
                    'Antarmuka yang baik merupakan jendela untuk melihat kemampuan dalam serta jembatan bagi kemampuan perangkat lunak.',
                  ),
                  const SizedBox(height: 12),
                  _buildContentText(
                    'Desain yang buruk akan membingungkan, tidak efisien, bahkan menyebabkan frustasi.',
                  ),
                  const SizedBox(height: 32),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://img.freepik.com/free-vector/flat-uhd-ui-background_23-2148114441.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String text, {bool isBold = false, double size = 11}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildContentText(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
    );
  }
}
