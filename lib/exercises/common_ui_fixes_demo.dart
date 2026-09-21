import 'package:flutter/material.dart';

/// Exercise 5: Debug & Fix Common UI Errors
/// Goal: Understand common layout issues and fix them.
///
/// 4 Key Fixes Demonstrated:
/// 1. Fix ListView inside Column using Expanded:
///    - Error: "Vertical viewport was given unbounded height."
///    - Solution: Wrap ListView with Expanded or Flexible so it receives bounded height constraints.
///
/// 2. Fix overflow on small screens / keyboards using SingleChildScrollView:
///    - Error: "A RenderFlex overflowed by xxx pixels on the bottom."
///    - Solution: Wrap content Column with SingleChildScrollView to allow vertical scrolling.
///
/// 3. Fix state update issue by adding setState():
///    - Problem: Updating variables without calling setState() will not trigger build(), leaving the UI stale.
///    - Solution: Mutate state inside setState(() { ... }) to schedule a re-render.
///
/// 4. Fix DatePicker BuildContext errors:
///    - Problem: Calling showDatePicker with an invalid context (e.g. root app context without Navigator or unmounted context).
///    - Solution: Use a valid BuildContext under a Navigator/MaterialApp (e.g. State's context or Builder widget context) and check `mounted`.
class CommonUiFixesDemo extends StatefulWidget {
  const CommonUiFixesDemo({super.key});

  @override
  State<CommonUiFixesDemo> createState() => _CommonUiFixesDemoState();
}

class _CommonUiFixesDemoState extends State<CommonUiFixesDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // State for Issue 3 (setState demonstration)
  int _brokenCounter = 0;
  int _fixedCounter = 0;

  // State for Issue 4 (DatePicker demonstration)
  DateTime? _pickedDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 – Common UI Fixes'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.view_stream), text: '1. ListView in Column'),
            Tab(icon: Icon(Icons.screen_rotation), text: '2. Screen Overflow'),
            Tab(icon: Icon(Icons.refresh), text: '3. State Update'),
            Tab(icon: Icon(Icons.calendar_today), text: '4. DatePicker Context'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildIssue1ListViewInColumn(),
          _buildIssue2ScreenOverflow(),
          _buildIssue3StateUpdate(),
          _buildIssue4DatePickerContext(),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // 1. ListView inside Column Fix using Expanded
  // -------------------------------------------------------------
  Widget _buildIssue1ListViewInColumn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderBanner(
            title: 'Fix 1: ListView inside Column',
            description:
                'A Column has infinite height constraint, and a default ListView also wants infinite height, causing a crash:\n"Vertical viewport was given unbounded height."\n\n'
                'Fix: Wrap ListView with Expanded so it takes remaining bounded space.',
            isFixApplied: true,
          ),
          const SizedBox(height: 12),
          const Text(
            'Live ListView inside Column (Fixed with Expanded):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),

          // Here is the fix: Wrap ListView.builder in Expanded!
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text('${index + 1}'),
                    ),
                    title: Text('Item #${index + 1} properly contained'),
                    subtitle: const Text('Scrolls smoothly inside Column'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // 2. Screen Overflow Fix using SingleChildScrollView
  // -------------------------------------------------------------
  Widget _buildIssue2ScreenOverflow() {
    // Here is the fix: Wrap the Column inside SingleChildScrollView!
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderBanner(
            title: 'Fix 2: Screen Overflow with SingleChildScrollView',
            description:
                'On small screens or when the on-screen keyboard appears, fixed-height content causes yellow-and-black striped error:\n"A RenderFlex overflowed by xxx pixels."\n\n'
                'Fix: Wrap the parent Column inside a SingleChildScrollView.',
            isFixApplied: true,
          ),
          const SizedBox(height: 16),
          const Text(
            'Long Form / Multiple Widgets (Safely Scrollable):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          for (int i = 1; i <= 6; i++)
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.layers, color: Colors.teal.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Content Block $i - No yellow/black overflow stripes even on small screens or when rotated.',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // 3. State Update Fix using setState()
  // -------------------------------------------------------------
  Widget _buildIssue3StateUpdate() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderBanner(
            title: 'Fix 3: State Update with setState()',
            description:
                'In Flutter StatefulWidgets, modifying variable values without calling setState() updates the memory variable, but Flutter never reruns build(). The screen remains unchanged!\n\n'
                'Fix: Enclose state variable mutations inside setState(() { ... }).',
            isFixApplied: true,
          ),
          const SizedBox(height: 16),

          // Without setState demonstration
          Card(
            color: Colors.red.shade50,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        'Without setState() [Buggy]:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Counter value displayed: $_brokenCounter'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100,
                      foregroundColor: Colors.red.shade900,
                    ),
                    onPressed: () {
                      // BUG: Variable changes, but no setState(), so UI does not reflect change!
                      _brokenCounter++;
                    },
                    child: const Text('Tap me (_brokenCounter++ without setState)'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // With setState demonstration
          Card(
            color: Colors.green.shade50,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'With setState() [Fixed]:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Counter value displayed: $_fixedCounter',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // FIX: setState notifies the framework to rerun build()!
                      setState(() {
                        _fixedCounter++;
                      });
                    },
                    child: const Text('Tap me (with setState)'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // 4. DatePicker BuildContext Error Fix
  // -------------------------------------------------------------
  Widget _buildIssue4DatePickerContext() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderBanner(
            title: 'Fix 4: DatePicker BuildContext Hierarchy',
            description:
                'Calling showDatePicker requires a BuildContext that has a Navigator ancestor.\n'
                'Common errors occur when:\n'
                '1. Passing a stale or unmounted context.\n'
                '2. Calling showDatePicker in initState or before the widget mounts.\n'
                '3. Using a context above MaterialApp.\n\n'
                'Fix: Call showDatePicker inside user action handler using a valid mounted widget context, or use Builder(builder: (context) => ...).',
            isFixApplied: true,
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.date_range, size: 48, color: Colors.indigo),
                  const SizedBox(height: 12),
                  Text(
                    _pickedDate == null
                        ? 'No Date Picked'
                        : 'Selected: ${_pickedDate!.day}/${_pickedDate!.month}/${_pickedDate!.year}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Builder(
                    builder: (buttonContext) {
                      return ElevatedButton.icon(
                        icon: const Icon(Icons.calendar_month),
                        label: const Text('Open DatePicker with Valid Context'),
                        onPressed: () async {
                          // Correct usage: buttonContext is guaranteed to be below Scaffold & Navigator
                          final DateTime? selected = await showDatePicker(
                            context: buttonContext,
                            initialDate: _pickedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          // Always verify mounted before calling setState in async gaps
                          if (mounted && selected != null) {
                            setState(() {
                              _pickedDate = selected;
                            });
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for explanation banner
  Widget _buildHeaderBanner({
    required String title,
    required String description,
    required bool isFixApplied,
  }) {
    return Card(
      elevation: 0,
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isFixApplied ? Icons.verified : Icons.warning_amber_rounded,
                  color: Colors.blue.shade700,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue.shade900,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
