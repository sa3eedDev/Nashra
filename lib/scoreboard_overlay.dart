import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_theme.dart';

class ScoreboardOverlay extends StatelessWidget {
  final int teamOneScore;
  final int teamTwoScore;
  final String teamOneName;
  final String teamTwoName;
  final String gameTime;
  final VoidCallback onTap;

  const ScoreboardOverlay({
    Key? key,
    required this.teamOneScore,
    required this.teamTwoScore,
    required this.teamOneName,
    required this.teamTwoName,
    required this.gameTime,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size to calculate proper dimensions
    final screenSize = MediaQuery.of(context).size;
    
    // Ensure status bar is visible with light icons when overlay is shown
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Light icons for dark overlay
      statusBarBrightness: Brightness.dark, // Dark mode for iOS
    ));
    
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: AppTheme.scoreboardBackground,
        width: screenSize.width,
        height: screenSize.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SWAPPED: Now the rotated view is on top
              // Top half (mirrored for player on opposite side)
              Expanded(
                child: RotatedBox(
                  quarterTurns: 2, // This properly mirrors the content (180 degrees)
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      children: [
                        // Scores section
                        Expanded(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Team Two Score (on left for Arabic layout - matching header)
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        teamTwoName,
                                        style: GoogleFonts.notoSansArabic(
                                          textStyle: const TextStyle(
                                            color: AppTheme.primaryA0,
                                            fontSize: 42,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        teamTwoScore.toString(),
                                        style: GoogleFonts.notoSansArabic(
                                          textStyle: const TextStyle(
                                            color: AppTheme.primaryA0,
                                            fontSize: 72,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Middle section with game timer
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: AppTheme.surfaceA20.withOpacity(0.7),
                                        border: Border.all(color: AppTheme.primaryA0.withOpacity(0.5), width: 2),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Text(
                                        gameTime,
                                        style: GoogleFonts.notoSansArabic(
                                          textStyle: const TextStyle(
                                            color: AppTheme.primaryA0,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                
                                // Team One Score (on right for Arabic layout - matching header)
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        teamOneName,
                                        style: GoogleFonts.notoSansArabic(
                                          textStyle: const TextStyle(
                                            color: AppTheme.primaryA0,
                                            fontSize: 42,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        teamOneScore.toString(),
                                        style: GoogleFonts.notoSansArabic(
                                          textStyle: const TextStyle(
                                            color: AppTheme.primaryA0,
                                            fontSize: 72,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Tap instruction at the bottom
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            'اضغط للعودة',
                            style: GoogleFonts.notoSansArabic(
                              textStyle: TextStyle(
                                color: AppTheme.primaryA30.withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Center divider
              Container(
                height: 2,
                width: screenSize.width * 0.9,
                color: AppTheme.primaryA0.withOpacity(0.4),
              ),
              
              // SWAPPED: Now the normal view is on bottom
              // Bottom half (for player on this side)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      // Scores section
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Team Two Score (on left for Arabic layout - matching header)
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      teamTwoName,
                                      style: GoogleFonts.notoSansArabic(
                                        textStyle: const TextStyle(
                                          color: AppTheme.primaryA0,
                                          fontSize: 42,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      teamTwoScore.toString(),
                                      style: GoogleFonts.notoSansArabic(
                                        textStyle: const TextStyle(
                                          color: AppTheme.primaryA0,
                                          fontSize: 72,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Middle section with game timer
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: AppTheme.surfaceA20.withOpacity(0.7),
                                      border: Border.all(color: AppTheme.primaryA0.withOpacity(0.5), width: 2),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Text(
                                      gameTime,
                                      style: GoogleFonts.notoSansArabic(
                                        textStyle: const TextStyle(
                                          color: AppTheme.primaryA0,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Team One Score (on right for Arabic layout - matching header)
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      teamOneName,
                                      style: GoogleFonts.notoSansArabic(
                                        textStyle: const TextStyle(
                                          color: AppTheme.primaryA0,
                                          fontSize: 42,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      teamOneScore.toString(),
                                      style: GoogleFonts.notoSansArabic(
                                        textStyle: const TextStyle(
                                          color: AppTheme.primaryA0,
                                          fontSize: 72,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Tap instruction at the bottom
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          'اضغط للعودة',
                          style: GoogleFonts.notoSansArabic(
                            textStyle: TextStyle(
                              color: AppTheme.primaryA30.withOpacity(0.7),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 