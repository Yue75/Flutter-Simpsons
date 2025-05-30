import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryYellow = Color(0xFFFDD835);
  static const Color primaryOrange = Color(0xFFFBC02D);
  static const Color backgroundYellow = Color(0xFFFFF9C4);
  static const Color cardYellow = Color(0xFFFFF176);
  static const Color borderOrange = Color(0xFFF57F17);
  static const Color textBrownDark = Color(0xFF4E342E);
  static const Color textBrownLight = Color(0xFF6D4C41);
}

class AppTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: 'Comic Sans MS',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 3,
        color: Colors.black45,
      ),
    ],
  );

  static const TextStyle sectionTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.borderOrange,
    shadows: [Shadow(offset: Offset(1, 1), blurRadius: 2, color: Colors.brown)],
  );
    color: AppColors.textBrownLight,
  );

  static const TextStyle bodyTextBold = TextStyle(
    fontFamily: 'Arial',
    fontWeight: FontWeight.w600,
    color: AppColors.textBrownDark,
  );
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryYellow,
  scaffoldBackgroundColor: AppColors.backgroundYellow,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryOrange,
    titleTextStyle: AppTextStyles.appBarTitle,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 4,
    centerTitle: true,
  ),
  textTheme: TextTheme(
    titleLarge: AppTextStyles.bodyTextBold,
    bodyMedium: AppTextStyles.bodyText,
    titleMedium: AppTextStyles.bodyTextBold,
  ),
  cardColor: AppColors.cardYellow,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryOrange,
      foregroundColor: Colors.white,
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Comic Sans MS',
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),


    ),
  ),
);
