import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/recipe_generation_mode_screen.dart';

class MealPlanningScreen extends StatefulWidget {
  const MealPlanningScreen({super.key});

  @override
  State<MealPlanningScreen> createState() => _MealPlanningScreenState();
}

class _MealPlanningScreenState extends State<MealPlanningScreen> {
  int _selectedMeals = 3;

  final Map<String, double> _dailyNutrientLimits = {
    'Sugar (g/day)': 25,
    'Sodium (mg/day)': 2000,
    'Potassium (mg/day)': 3000,
    'Calcium (mg/day)': 1000,
    'Zinc (mg/day)': 8,
    'Vitamin B12 (mcg/day)': 50,
  };

  @override
  Widget build(BuildContext context) {
    final perMealLimits = _calculatePerMealLimits();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF), // Light blue-ish background
      body: Column(
        children: [
          // Header Section
          _buildHeader(),

          // Main Content Section
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Meal per day selector
                    _buildMealSelector(),
                    const SizedBox(height: 30),

                    // Per meals limits
                    _buildPerMealLimits(perMealLimits),
                    const Spacer(),

                    // Continue Button
                    _buildContinueButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF0073E6), // Bright blue
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Text
          Positioned(
            top: 20,
            child: Image.asset(
              'assets/images/meal_planning_background.png',
              color: Colors.white.withOpacity(0.1),
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
          // Mascot
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset(
              'assets/images/bear_mascot.png',
              height: 180,
            ),
          ),
          // Back Button
          Positioned(
            top: 20,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meal per day',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [2, 3, 4, 5].map((meals) {
            final isSelected = _selectedMeals == meals;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMeals = meals;
                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: const Color(0xFFFF7043), width: 2)
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFFFF7043).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    meals.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? const Color(0xFFFF7043) : Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPerMealLimits(Map<String, String> perMealLimits) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Per meals limits (for $_selectedMeals meals):',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView( // Changed to ListView for scrollability if needed
              padding: EdgeInsets.zero,
              children: perMealLimits.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        entry.value,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A65), Color(0xFFFF7043)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecipeGenerationModeScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          'Continue',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Map<String, String> _calculatePerMealLimits() {
    return _dailyNutrientLimits.map((key, value) {
      final perMealValue = value / _selectedMeals;
      // Format to one decimal place
      final formattedValue = perMealValue.toStringAsFixed(1);
      // Add units back (g, mg, mcg)
      final unit = key.split('(').last.split('/').first;
      return MapEntry(key, '$formattedValue$unit');
    });
  }
}
