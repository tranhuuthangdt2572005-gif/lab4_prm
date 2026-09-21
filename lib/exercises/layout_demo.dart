import 'package:flutter/material.dart';

/// Exercise 3: Layout Basics (Column, Row, Padding, ListView)
/// Goal: Build a sectioned UI layout similar to a real app Home screen.
/// - Demonstrates Column to arrange sections vertically.
/// - Demonstrates consistent spacing using Padding and SizedBox (8, 12, 16 px).
/// - Demonstrates ListView.builder showing movie titles with custom Card & ListTile.
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  // Movie dataset
  final List<Map<String, String>> movies = const [
    {
      'title': 'Avatar',
      'subtitle': 'Sample description',
      'initial': 'A',
    },
    {
      'title': 'Inception',
      'subtitle': 'Sample description',
      'initial': 'I',
    },
    {
      'title': 'Interstellar',
      'subtitle': 'Sample description',
      'initial': 'I',
    },
    {
      'title': 'Joker',
      'subtitle': 'Sample description',
      'initial': 'J',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Demo'),
      ),
      body: Padding(
        // Outer layout padding (16px)
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Headline Section using Text and Center/Column
            const Center(
              child: Text(
                'Now Playing',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Consistent spacing (16px)
            const SizedBox(height: 16),

            // Scrollable list of movies using Expanded + ListView.builder
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Padding(
                    // Consistent spacing between items (12px vertical margin)
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFFE3E7FF),
                          child: Text(
                            movie['initial']!,
                            style: const TextStyle(
                              color: Color(0xFF3F51B5),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        title: Text(
                          movie['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                          movie['subtitle']!,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
