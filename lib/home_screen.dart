import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/number_utils.dart';
import 'theme/app_theme.dart';
import 'icon_demo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Team scores
  int teamOneScore = 0;
  int teamTwoScore = 0;
  
  // History of scores
  final List<int> teamOneHistory = [];
  final List<int> teamTwoHistory = [];
  
  // Current round scores
  final TextEditingController teamOneController = TextEditingController();
  final TextEditingController teamTwoController = TextEditingController();
  
  // Focus nodes for text fields
  final FocusNode teamOneFocus = FocusNode();
  final FocusNode teamTwoFocus = FocusNode();
  
  // Team names
  final String teamOneName = "لنا";
  final String teamTwoName = "لهم";
  
  // Round counters
  int roundOne = 0;
  int roundTwo = 0;
  
  // Maximum score to win
  final int maxScore = 152;

  @override
  void initState() {
    super.initState();
    
    // Add listeners to text controllers to handle auto-focus and auto-add
    teamOneController.addListener(_handleTeamOneInputChange);
    teamTwoController.addListener(_handleTeamTwoInputChange);
  }

  // Handle input changes for Team One
  void _handleTeamOneInputChange() {
    // If Team One field has 2 digits, move focus to Team Two
    if (teamOneController.text.length == 2) {
      teamTwoFocus.requestFocus();
    }
    
    // If both fields have values, add points automatically
    _checkAndAddPoints();
  }
  
  // Handle input changes for Team Two
  void _handleTeamTwoInputChange() {
    // If Team Two field has 2 digits, move focus to Team One
    if (teamTwoController.text.length == 2) {
      teamOneFocus.requestFocus();
    }
    
    // If both fields have values, add points automatically
    _checkAndAddPoints();
  }
  
  // Check if both fields have values and add points
  void _checkAndAddPoints() {
    if (teamOneController.text.length == 2 && teamTwoController.text.length == 2) {
      addScore();
    }
  }

  @override
  void dispose() {
    teamOneController.removeListener(_handleTeamOneInputChange);
    teamTwoController.removeListener(_handleTeamTwoInputChange);
    teamOneController.dispose();
    teamTwoController.dispose();
    teamOneFocus.dispose();
    teamTwoFocus.dispose();
    super.dispose();
  }

  // Add score to team
  void addScore() {
    // Get scores from controllers
    String teamOneText = teamOneController.text.isEmpty ? "0" : teamOneController.text;
    String teamTwoText = teamTwoController.text.isEmpty ? "0" : teamTwoController.text;
    
    // Convert Arabic numbers to English if needed
    teamOneText = NumberUtils.convertToEnglishNumbers(teamOneText);
    teamTwoText = NumberUtils.convertToEnglishNumbers(teamTwoText);
    
    final int? scoreOne = int.tryParse(teamOneText);
    final int? scoreTwo = int.tryParse(teamTwoText);
    
    if (scoreOne != null && scoreTwo != null) {
      setState(() {
        // Add to history
        teamOneHistory.add(scoreOne);
        teamTwoHistory.add(scoreTwo);
        
        // Update total scores
        teamOneScore += scoreOne;
        teamTwoScore += scoreTwo;
        
        // Update round counters
        if (scoreOne > 0) roundOne++;
        if (scoreTwo > 0) roundTwo++;
        
        // Clear controllers
        teamOneController.clear();
        teamTwoController.clear();
      });
      
      // Check for winner
      checkForWinner();
    }
  }
  
  // Check if any team has won
  void checkForWinner() {
    if (teamOneScore >= maxScore || teamTwoScore >= maxScore) {
      String winner;
      
      // If both teams passed 152, the winner is the one with higher points
      if (teamOneScore >= maxScore && teamTwoScore >= maxScore) {
        winner = teamOneScore > teamTwoScore ? teamOneName : teamTwoName;
      } 
      // Otherwise, the winner is the one who reached 152 first
      else if (teamOneScore >= maxScore) {
        winner = teamOneName;
      } else {
        winner = teamTwoName;
      }
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: AppTheme.surfaceA10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'انتهت اللعبة!',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansArabic(
              textStyle: const TextStyle(
                color: AppTheme.primaryA0,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceA20,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '$winner فاز باللعبة!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSansArabic(
                    textStyle: const TextStyle(
                      color: AppTheme.primaryA0,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$teamOneName: $teamOneScore',
                    style: GoogleFonts.notoSansArabic(
                      textStyle: const TextStyle(
                        color: AppTheme.primaryA20,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '$teamTwoName: $teamTwoScore',
                    style: GoogleFonts.notoSansArabic(
                      textStyle: const TextStyle(
                        color: AppTheme.primaryA20,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Return button - Keep the current game state for review
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.surfaceA30,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'مراجعة النتائج',
                    style: GoogleFonts.notoSansArabic(
                      textStyle: const TextStyle(
                        color: AppTheme.primaryA10,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                
                // New game button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryA0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    resetGame();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'لعبة جديدة',
                    style: GoogleFonts.notoSansArabic(
                      textStyle: const TextStyle(
                        color: AppTheme.surfaceA0,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    }
  }
  
  // Reset the game
  void resetGame() {
    setState(() {
      teamOneScore = 0;
      teamTwoScore = 0;
      teamOneHistory.clear();
      teamTwoHistory.clear();
      roundOne = 0;
      roundTwo = 0;
      teamOneController.clear();
      teamTwoController.clear();
    });
  }
  
  // Undo last move
  void undoLastMove() {
    if (teamOneHistory.isNotEmpty && teamTwoHistory.isNotEmpty) {
      setState(() {
        final int lastScoreOne = teamOneHistory.removeLast();
        final int lastScoreTwo = teamTwoHistory.removeLast();
        
        teamOneScore -= lastScoreOne;
        teamTwoScore -= lastScoreTwo;
        
        if (lastScoreOne > 0) roundOne--;
        if (lastScoreTwo > 0) roundTwo--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // Dismiss keyboard when tapping outside input fields
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        // Ensure the gesture detector doesn't block any child interactions
        behavior: HitTestBehavior.translucent,
        child: Container(
          color: AppTheme.surfaceA0,
          child: SafeArea(
            child: Column(
              children: [
                // Score header
                buildScoreHeader(),
                
                // Main content
                Expanded(
                  child: Row(
                    children: [
                      // Team Two Column (لهم)
                      Expanded(child: buildTeamColumn(false)),
                      
                      // Middle Column with buttons
                      buildMiddleColumn(),
                      
                      // Team One Column (لنا)
                      Expanded(child: buildTeamColumn(true)),
                    ],
                  ),
                ),
                
                // Bottom row with quick-add buttons for each team
                buildBottomRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Score header widget
  Widget buildScoreHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceA10,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Team Two Column (لهم) - Left side
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    teamTwoName,
                    style: GoogleFonts.notoSansArabic(
                      textStyle: const TextStyle(
                        color: AppTheme.primaryA0,
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    teamTwoScore.toString(),
                    style: AppTheme.scoreTextStyle,
                  ),
                ],
              ),
            ),
          ),
          
          // Middle space for buttons - same width as middle column
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
          ),
          
          // Team One Column (لنا) - Right side
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    teamOneName,
                    style: GoogleFonts.notoSansArabic(
                      textStyle: const TextStyle(
                        color: AppTheme.primaryA0,
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    teamOneScore.toString(),
                    style: AppTheme.scoreTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Team column widget
  Widget buildTeamColumn(bool isTeamOne) {
    final controller = isTeamOne ? teamOneController : teamTwoController;
    final focusNode = isTeamOne ? teamOneFocus : teamTwoFocus;
    final history = isTeamOne ? teamOneHistory : teamTwoHistory;
    final otherHistory = isTeamOne ? teamTwoHistory : teamOneHistory;
    final score = isTeamOne ? teamOneScore : teamTwoScore;
    
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.fieldBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Score input field
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.fieldBackground,
              border: Border.all(color: AppTheme.fieldBorder, width: 1.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 2, // Limit to 2 digits
              style: GoogleFonts.notoSansArabic(
                textStyle: const TextStyle(
                  fontSize: 24,
                  color: AppTheme.surfaceA0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩]')),
                LengthLimitingTextInputFormatter(2), // Another way to limit to 2 digits
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '0',
                hintStyle: TextStyle(color: AppTheme.surfaceA30),
                counterText: '', // Hide the character counter
              ),
            ),
          ),
          
          // Score history
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: history.length + 1,
                itemBuilder: (context, index) {
                  // Show current total at the bottom
                  if (index == history.length) {
                    return Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.scoreBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            score.toString(),
                            style: GoogleFonts.notoSansArabic(
                              textStyle: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.surfaceA0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }
                  
                  // Show history items
                  final historyIndex = history.length - 1 - index;
                  
                  // Determine if this score is higher than the other team's score for this round
                  bool isHigherScore = false;
                  if (historyIndex < history.length && historyIndex < otherHistory.length) {
                    isHigherScore = history[historyIndex] > otherHistory[historyIndex];
                  }
                  
                  return Column(
                    children: [
                      Container(
                        margin: isHigherScore ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0) : null,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: isHigherScore ? BoxDecoration(
                          color: AppTheme.scoreBackground,
                          borderRadius: BorderRadius.circular(8),
                        ) : null,
                        child: Text(
                          history[historyIndex].toString(),
                          style: GoogleFonts.notoSansArabic(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: isHigherScore ? FontWeight.bold : FontWeight.normal,
                              color: AppTheme.surfaceA0,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1, 
                        height: 16, 
                        color: AppTheme.fieldBorder.withOpacity(0.3),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Middle column with buttons
  Widget buildMiddleColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Undo button
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.surfaceA20,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Tooltip(
            message: 'تراجع',
            child: IconButton(
              icon: const Icon(Icons.replay, color: AppTheme.primaryA0),
              onPressed: undoLastMove,
              iconSize: 30,
            ),
          ),
        ),
        
        // Submit button
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryA0,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: addScore,
            child: Text(
              'سجل',
              style: GoogleFonts.notoSansArabic(
                textStyle: const TextStyle(
                  color: AppTheme.surfaceA0,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        
        // Settings button
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.surfaceA20,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.primaryA30),
            onPressed: () {
              // Show settings dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppTheme.surfaceA10,
                  title: Text(
                    'الإعدادات',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansArabic(
                      textStyle: const TextStyle(
                        color: AppTheme.primaryA0,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryA0,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          resetGame();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'لعبة جديدة',
                          style: GoogleFonts.notoSansArabic(
                            textStyle: const TextStyle(
                              color: AppTheme.surfaceA0,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.surfaceA30,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigate to the icon demo page
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => IconDemoPage(),
                            ),
                          );
                        },
                        child: Text(
                          'عرض أيقونة التطبيق',
                          style: GoogleFonts.notoSansArabic(
                            textStyle: const TextStyle(
                              color: AppTheme.primaryA10,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            iconSize: 30,
          ),
        ),
      ],
    );
  }
  
  // Bottom row with quick-add buttons for each team
  Widget buildBottomRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceA20,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Team Two (لهم) quick-add buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAddButton(2, false),
                _buildQuickAddButton(4, false),
                _buildQuickAddButton(16, false),
                _buildQuickAddButton(26, false),
              ],
            ),
          ),
          
          // Divider
          Container(
            height: 40,
            width: 1,
            color: AppTheme.surfaceA40,
            margin: const EdgeInsets.symmetric(horizontal: 4),
          ),
          
          // Team One (لنا) quick-add buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAddButton(2, true),
                _buildQuickAddButton(4, true),
                _buildQuickAddButton(16, true),
                _buildQuickAddButton(26, true),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to build quick-add buttons
  Widget _buildQuickAddButton(int points, bool isTeamOne) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isTeamOne) {
            // Add points to Team One
            teamOneScore += points;
            teamOneHistory.add(points);
            if (points > 0) roundOne++;
            
            // Add zero to Team Two
            teamTwoHistory.add(0);
          } else {
            // Add points to Team Two
            teamTwoScore += points;
            teamTwoHistory.add(points);
            if (points > 0) roundTwo++;
            
            // Add zero to Team One
            teamOneHistory.add(0);
          }
          // Check for winner after adding points
          checkForWinner();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isTeamOne ? AppTheme.primaryA0 : AppTheme.surfaceA30,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          "+$points",
          style: GoogleFonts.notoSansArabic(
            textStyle: TextStyle(
              color: isTeamOne ? AppTheme.surfaceA0 : AppTheme.primaryA0,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
} 