import 'package:flutter/material.dart';

/// Exercise 1: Core Widgets Demo
/// Demonstrates essential Flutter display widgets:
/// - Text (Headline styling)
/// - Icon (Material Icons)
/// - Image.network (Network image with error & loading handling)
/// - Card containing a ListTile (leading icon, title, subtitle)
class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1 – Core Widgets Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Headline Text Widget
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // 2. Icon Widget using Material Icons
            const Icon(
              Icons.movie,
              size: 72,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),

            // 3. Image.network Widget (aerial highway interchange or landscape)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?w=600&auto=format&fit=crop&q=80',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                // Graceful loading indicator
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                // Fallback placeholder if offline or network unavailable
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          'Image preview (offline fallback)',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // 4. Card containing a ListTile
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.star,
                  color: Colors.blueGrey,
                  size: 28,
                ),
                title: Text(
                  'Movie Item',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  'This is a sample ListTile inside a Card.',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
