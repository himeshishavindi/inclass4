import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MiniCricketApp());
}

class MiniCricketApp extends StatelessWidget {
  const MiniCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Cricket',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        scaffoldBackgroundColor: Colors.blue[600],
      ),
      home: const CricketScreen(),
    );
  }
}

class CricketScreen extends StatefulWidget {
  const CricketScreen({super.key});

  @override
  State<CricketScreen> createState() => _CricketScreenState();
}

class _CricketScreenState extends State<CricketScreen> {
  int runs = 0;
  int ballsLeft = 6;
  int? lastBallRuns;

  bool get isGameOver => ballsLeft == 0;

  void _playBall() {
    final result = Random().nextInt(7); // 0 to 6 runs
    setState(() {
      runs += result;
      ballsLeft -= 1;
      lastBallRuns = result;
    });
  }

  void _restart() {
    setState(() {
      runs = 0;
      ballsLeft = 6;
      lastBallRuns = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: const Text(
          "Mini Cricket",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Runs / Balls score row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ScoreCard(
                  icon: Icons.sports_cricket,
                  iconColor: Colors.brown,
                  label: "Runs",
                  value: runs,
                ),
                const SizedBox(width: 24),
                _ScoreCard(
                  icon: Icons.circle,
                  iconColor: Colors.red,
                  label: "Balls",
                  value: ballsLeft,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Result text for the last ball
            if (lastBallRuns != null)
              Text(
                lastBallRuns == 0 ? "No Runs" : "$lastBallRuns Runs",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

            const SizedBox(height: 20),

            // Bat button OR Restart button
            isGameOver
                ? ElevatedButton(
                    onPressed: _restart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Restart"),
                  )
                : ElevatedButton(
                    onPressed: _playBall,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Bat"),
                  ),
          ],
        ),
      ),
    );
  }
}

// Reusable score display: icon box + label + value
class _ScoreCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final int value;

  const _ScoreCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 40),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          "$value",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
