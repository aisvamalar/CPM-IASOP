import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctors Q&A',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: QAScreen(),
    );
  }
}

class QAScreen extends StatefulWidget {
  @override
  _QAScreenState createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> with TickerProviderStateMixin {
  late List<bool> _isExpandedList;
  late List<Map<String, String>> _filteredQAList;
  final TextEditingController _searchController = TextEditingController();
  final Set<int> _bookmarkedIndexes = {};
  String _selectedCategory = 'All';

  final List<Map<String, String>> _qaList = [
    {
      'question': 'What are the common side effects of this medication?',
      'answer': 'Common side effects include nausea, headache, dizziness, and fatigue.',
      'category': 'General'
    },
    {
      'question': 'How should I store this medication?',
      'answer': 'Store it at room temperature, away from moisture and direct sunlight.',
      'category': 'Dosage'
    },
    {
      'question': 'Can I take this medication with other drugs?',
      'answer': 'Consult with a healthcare provider before combining this medication with others.',
      'category': 'Interactions'
    },
    // More questions...
  ];

  final List<String> _categories = ['All', 'General', 'Dosage', 'Interactions'];

  @override
  void initState() {
    super.initState();
    _isExpandedList = List<bool>.filled(_qaList.length, false);
    _filteredQAList = List.from(_qaList);
    _searchController.addListener(_filterQAList);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterQAList() {
    setState(() {
      _filteredQAList = _qaList.where((qa) {
        final matchesSearch = qa['question']!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
        final matchesCategory =
            _selectedCategory == 'All' || qa['category'] == _selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
      _isExpandedList = List<bool>.filled(_filteredQAList.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Q&A for Doctors',style: (TextStyle(color:Colors.white,fontWeight: FontWeight.bold,)),),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark, color: Colors.white),
            onPressed: () {
              // Show only bookmarked questions
              setState(() {
                _selectedCategory = 'Bookmarks';
                _filteredQAList = _qaList
                    .asMap()
                    .entries
                    .where((entry) => _bookmarkedIndexes.contains(entry.key))
                    .map((entry) => entry.value)
                    .toList();
                _isExpandedList =
                List<bool>.filled(_filteredQAList.length, false);
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryTabs(),
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredQAList.length,
              itemBuilder: (context, index) {
                return _buildQAItem(index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: _showNewQuestionDialog,
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
                _filterQAList();
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal : Colors.teal.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.teal),
          hintText: 'Search questions...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.teal),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
      ),
    );
  }

  Widget _buildQAItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          leading: Icon(Icons.question_answer, color: Colors.teal),
          title: Text(
            _filteredQAList[index]['question']!,
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Wrap(
            spacing: 12,
            children: [
              IconButton(
                icon: Icon(
                  _bookmarkedIndexes.contains(index)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: Colors.teal,
                ),
                onPressed: () {
                  setState(() {
                    if (_bookmarkedIndexes.contains(index)) {
                      _bookmarkedIndexes.remove(index);
                    } else {
                      _bookmarkedIndexes.add(index);
                    }
                  });
                },
              ),
              Icon(
                _isExpandedList[index] ? Icons.expand_less : Icons.expand_more,
                color: Colors.teal,
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _filteredQAList[index]['answer']!,
                style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 16,
                ),
              ).animate().fade(duration: Duration(milliseconds: 500)),
            ),
          ],
          onExpansionChanged: (isExpanded) {
            setState(() {
              _isExpandedList[index] = isExpanded;
            });
          },
        ),
      ),
    );
  }

  void _showNewQuestionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController questionController = TextEditingController();
        TextEditingController answerController = TextEditingController();
        String selectedCategory = _categories[1];

        return AlertDialog(
          title: Text('Ask a New Question'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: answerController,
                decoration: InputDecoration(
                  labelText: 'Answer',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                items: _categories
                    .skip(1)
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.teal)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _qaList.add({
                    'question': questionController.text,
                    'answer': answerController.text,
                    'category': selectedCategory,
                  });
                  _isExpandedList.add(false);
                  _filterQAList(); // Refresh the filtered list
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
