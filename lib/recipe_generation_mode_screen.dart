import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/setup_complete_screen.dart';

enum RecipeMode {
  hybrid,
  medical,
}

class RecipeGenerationModeScreen extends StatefulWidget {
  const RecipeGenerationModeScreen({super.key});

  @override
  State<RecipeGenerationModeScreen> createState() =>
      _RecipeGenerationModeScreenState();
}

class _RecipeGenerationModeScreenState
    extends State<RecipeGenerationModeScreen> {
  RecipeMode _selectedMode = RecipeMode.hybrid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1), // Mint green background
      body: Column(
        children: [
          // Header
          _buildHeader(),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildModeCard(
                    mode: RecipeMode.hybrid,
                    label: 'Recommended',
                    title: 'Hybrid Mode',
                    subtitle:
                        'Get both AI-generated recipes and doctor-verified recipes for variety and flexibility.',
                    benefits: [
                      'More recipe options.',
                      'AI adapts to ingredients.',
                      'Includes verified recipes.',
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildModeCard(
                    mode: RecipeMode.medical,
                    label: 'Strict Compliance',
                    title: 'Medical Mode',
                    subtitle:
                        'Only doctor-verified recipes for strict medical compliance.',
                    benefits: [
                      '100% doctor-approved',
                      'Maximum safety',
                      'Limited variety',
                    ],
                  ),
                  const Spacer(),
                  _buildCompleteButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 50, 24, 30),
      decoration: const BoxDecoration(
        color: Color(0xFFFCE4EC), // Soft pink
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.1),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Recipe Generation Mode',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose how you want recipes to be generated',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeCard({
    required RecipeMode mode,
    required String label,
    required String title,
    required String subtitle,
    required List<String> benefits,
  }) {
    final isSelected = _selectedMode == mode;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = mode;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF7043) : Colors.grey[200]!,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFE0B2) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? const Color(0xFFE65100) : Colors.black54,
                    ),
                  ),
                ),
                Radio<RecipeMode>(
                  value: mode,
                  groupValue: _selectedMode,
                  onChanged: (RecipeMode? value) {
                    setState(() {
                      _selectedMode = value!;
                    });
                  },
                  activeColor: const Color(0xFFFF7043),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            ...benefits.map(
              (benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Colors.green, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      benefit,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompleteButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SetupCompleteScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          backgroundColor: const Color(0xFF212121), // Dark button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Complete the Setup',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
