import 'package:flutter/material.dart';
import 'dart:convert';
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
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/kampus_uim.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.93),
            ),
          ),
          
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image Section
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/kampus_uim.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(color: AppColors.primary.withOpacity(0.1));
                          },
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
                                ],
                              ),
                              child: Column(
                                children: [
                                  const Icon(Icons.school, color: AppColors.primary, size: 50),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Smart UIM',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  title.split(' ').take(2).join(' '),
                                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1),
                                  textAlign: TextAlign.center,
                                ),
                                if (title.split(' ').length > 2)
                                  Text(
                                    title.split(' ').skip(2).join(' '),
                                    style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1),
                                    textAlign: TextAlign.center,
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

                // Dynamic Content based on Title
                if (title.contains('Guidelines') || title.contains('Principles'))
                  _buildGuidelinesContent()
                else if (title.contains('Profile'))
                  _buildProfileConceptContent()
                else if (title.contains('Prinsip'))
                  _buildPrinsipContent()
                else
                  _buildIntroContent(user),
                  
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(String text) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 5, // Increased from 3 to 5 for better visibility
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildIntroContent(UserModel? user) {
    return Column(
      children: [
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
                    Container(
                      width: 94,
                      height: 94,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: ClipOval(
                        child: user?.photoPath != null && user!.photoPath!.isNotEmpty
                            ? (user!.photoPath!.startsWith('http') 
                                ? Image.network(user.photoPath!, fit: BoxFit.cover, errorBuilder: (c,e,s) => _buildPlaceholder()) 
                                : (user!.photoPath!.startsWith('data:')
                                    ? Image.memory(base64Decode(user.photoPath!.split(',')[1]), fit: BoxFit.cover, errorBuilder: (c,e,s) => _buildPlaceholder())
                                    : Image.asset(user.photoPath!, fit: BoxFit.cover, errorBuilder: (c,e,s) => _buildPlaceholder())))
                            : _buildPlaceholder(),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoText(user?.nama ?? 'MOH. SYAIFUL ANAM', isBold: true, size: 12),
                          const SizedBox(height: 6),
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
                          _buildInfoText('• No. HP: ${user?.phone ?? '6285334159328'}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),
        const Divider(indent: 32, endIndent: 32, color: Color(0xFFEEEEEE)),
        const SizedBox(height: 32),
        
        // User Interface Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              _buildSectionHeading('User Interface'),
              const SizedBox(height: 24),
              _buildContentText(
                'Antarmuka User Interface (UI) merupakan bagian dari komputer dan perangkat lunaknya yang dapat dilihat, didengar, disentuh, dan diajak bicara, baik secara langsung maupun dengan proses pemahaman tertentu.',
              ),
              const SizedBox(height: 16),
              _buildContentText(
                'UI yang baik adalah UI yang tidak disadari, dan UI yang membuat akan pengguna fokus pada informasi dan data tanpa perlu mengutak-atik mekanisme untuk menampilkan informasi dan melakukan hal tersebut.',
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Komponen utamanya:',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      SizedBox(height: 8),
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
        
        // Importance Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              _buildSectionHeading('Pentingnya Desain UI yang Baik'),
              const SizedBox(height: 24),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuidelinesContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: _buildSectionHeading('UID Guidelines & Principles'),
          ),
          const SizedBox(height: 24),
          _buildContentText(
            'Guidelines dan prinsip desain antarmuka pengguna adalah kumpulan aturan dan rekomendasi untuk menciptakan antarmuka yang efektif, efisien, dan memuaskan bagi pengguna.',
          ),
          const SizedBox(height: 32),
          const Text(
            '8 Golden Rules of Interface Design:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          _buildGuidelineItem('1. Strive for consistency', 'Konsistensi dalam penggunaan ikon, warna, dan tata letak.'),
          _buildGuidelineItem('2. Enable frequent users to use shortcuts', 'Menyediakan tombol cepat untuk pengguna mahir.'),
          _buildGuidelineItem('3. Offer informative feedback', 'Memberikan umpan balik untuk setiap aksi pengguna.'),
          _buildGuidelineItem('4. Design dialog to yield closure', 'Menyampaikan pesan ketika sebuah proses selesai.'),
          _buildGuidelineItem('5. Offer simple error handling', 'Memberikan informasi yang jelas saat terjadi kesalahan.'),
        ],
      ),
    );
  }

  Widget _buildProfileConceptContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: _buildSectionHeading('User Profile Concept'),
          ),
          const SizedBox(height: 24),
          _buildContentText(
            'User Profile atau Persona adalah representasi dari target pengguna aplikasi yang membantu desainer memahami kebutuhan, tujuan, dan perilaku pengguna.',
          ),
          const SizedBox(height: 32),
          const Text(
            'Elemen Penting User Profile:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          _buildGuidelineItem('Demografi', 'Nama, umur, pekerjaan, lokasi, status.'),
          _buildGuidelineItem('Psikografi', 'Minat, gaya hidup, nilai-nilai yang dianut.'),
          _buildGuidelineItem('Tujuan (Goals)', 'Apa yang ingin dicapai pengguna dengan aplikasi ini.'),
          _buildGuidelineItem('Keresahan (Pain Points)', 'Masalah yang dihadapi pengguna saat ini.'),
        ],
      ),
    );
  }

  Widget _buildPrinsipContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: _buildSectionHeading('Prinsip Perancangan UI'),
          ),
          const SizedBox(height: 24),
          _buildContentText(
            'Prinsip perancangan antarmuka pengguna fokus pada bagaimana membuat interaksi manusia-komputer menjadi lebih manusiawi dan intuitif.',
          ),
          const SizedBox(height: 32),
          const Text(
            'Prinsip-prinsip Utama:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          _buildGuidelineItem('Visibilitas', 'Status sistem harus selalu terlihat jelas bagi pengguna.'),
          _buildGuidelineItem('Affordance', 'Elemen UI harus terlihat seperti fungsinya (misal: tombol terlihat menonjol).'),
          _buildGuidelineItem('Mapping', 'Hubungan antara kontrol dan efeknya harus logis.'),
          _buildGuidelineItem('Feedback', 'Setiap tindakan harus mendapatkan respon yang cepat.'),
        ],
      ),
    );
  }

  Widget _buildGuidelineItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade100,
      child: Icon(Icons.person, size: 50, color: Colors.grey.shade400),
    );
  }

  Widget _buildInfoText(String text, {bool isBold = false, double size = 10}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          height: 1.3,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildContentText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.7,
      ),
    );
  }
}
