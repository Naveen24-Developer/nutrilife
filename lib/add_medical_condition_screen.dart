import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/daily_nutrient_limits_screen.dart';

class AddMedicalConditionScreen extends StatefulWidget {
  const AddMedicalConditionScreen({super.key});

  @override
  State<AddMedicalConditionScreen> createState() =>
      _AddMedicalConditionScreenState();
}

class _AddMedicalConditionScreenState
    extends State<AddMedicalConditionScreen> {
  String? _selectedCondition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Add Medical Condition',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Select your condition to get started with personalized nutrition tracking.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Condition Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8, // Adjusted for better card proportions
                  children: [
                    _buildConditionCard(
                      'Diabetes',
                      'Sugar & Carb monitoring',
                      'assets/images/diabetes.png',
                    ),
                    _buildConditionCard(
                      'Kidney Disease',
                      'Potassium & Sodium control',
                      'assets/images/kidney_disease.png',
                    ),
                    _buildConditionCard(
                      'PCOD/PCOS',
                      'Hormonal balance nutrition',
                      'assets/images/pcod_pcos.png',
                    ),
                    _buildConditionCard(
                      'Hypertension',
                      'Blood pressure management',
                      'assets/images/hypertension.png',
                    ),
                    _buildConditionCard(
                      'Heart Disease',
                      'Cardiovascular',
                      'assets/images/heart_disease.png',
                    ),
                    _buildConditionCard(
                      'Other',
                      'Custom condition',
                      null, // No image for "Other"
                    ),
                  ],
                ),
              ),
            ),
            // Continue Button
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8A65), Color(0xFFFF7043)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DailyNutrientLimitsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionCard(
      String title, String subtitle, String? imagePath) {
    final bool isSelected = _selectedCondition == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCondition = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 200, 185, 0.4),
                    Color.fromRGBO(255, 255, 255, 0)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.02, 0.96],
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF7043) : Colors.grey[200]!,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              child: Radio<String>(
                value: title,
                groupValue: _selectedCondition,
                onChanged: (String? value) {
                  setState(() {
                    _selectedCondition = value;
                  });
                },
                activeColor: const Color(0xFFFF7043),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const Spacer(),
            if (imagePath != null)
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  imagePath,
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
