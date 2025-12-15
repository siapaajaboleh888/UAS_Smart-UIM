import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Telkom University Green Theme
  static const Color primary = Color(0xFF009247); // Telkom Green
  static const Color primaryDark = Color(0xFF006B33);
  static const Color primaryLight = Color(0xFF33A669);
  
  // Accent Colors
  static const Color accent = Color(0xFFFDB515); // Gold accent
  static const Color accentLight = Color(0xFFFFD966);
  
  // Background Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF718096);
  static const Color textLight = Color(0xFFA0AEC0);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  // Status Colors
  static const Color success = Color(0xFF48BB78);
  static const Color warning = Color(0xFFF6AD55);
  static const Color error = Color(0xFFF56565);
  static const Color info = Color(0xFF4299E1);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF009247), Color(0xFF00B359)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF7FAFC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);
}
