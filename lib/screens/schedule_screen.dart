import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<String> categories = [
    'Pediatrician',
    'Neurosurgeon',
    'ENT',
    'Oncologist',
    'Cardiologist',
    // Add more categories as needed
  ];

  final Map<String, List<Map<String, String>>> doctorsByCategory = {
    'Pediatrician': [
      {'name': 'Dr. Serena Gomes', 'experience': '18 Years', 'patients': '1.08K'},
      {'name': 'Dr. Khan', 'experience': '21 Years', 'patients': '569'},
      {'name': 'Dr. Meena', 'experience': '28 Years', 'patients': '1.08K'},
      {'name': 'Dr. Kiara', 'experience': '21 Years', 'patients': '569'},
      {'name': 'Dr. Mona', 'experience': '8 Years', 'patients': '1.08K'},
      {'name': 'Dr. Aishu', 'experience': '12 Years', 'patients': '569'},
      {'name': 'Dr. Bharani', 'experience': '38 Years', 'patients': '1.08K'},
      {'name': 'Dr. Vishnu', 'experience': '21 Years', 'patients': '569'},
      {'name': 'Dr. Velmurugan', 'experience': '8 Years', 'patients': '1.08K'},
      {'name': 'Dr. Senorita', 'experience': '21 Years', 'patients': '569'},
    ],
    'Neurosurgeon': [
      {'name': 'Dr. Farid Raihan', 'experience': '21 Years', 'patients': '3.09K'},
      {'name': 'Dr. Farid Raihan', 'experience': '11 Years', 'patients': '3.09K'},
      {'name': 'Dr. Farid Raihan', 'experience': '17 Years', 'patients': '3.09K'},
      {'name': 'Dr. Farid Raihan', 'experience': '18 Years', 'patients': '3.09K'},
      {'name': 'Dr. Farid Raihan', 'experience': '16 Years', 'patients': '3.09K'},
      {'name': 'Dr. Farid Raihan', 'experience': '23 Years', 'patients': '3.09K'},
      {'name': 'Dr. Farid Raihan', 'experience': '27 Years', 'patients': '3.09K'},
      {'name': 'Dr. Farid Raihan', 'experience': '`7 Years', 'patients': '3.09K'},
      {'name': 'Dr. Farid Raihan', 'experience': '27 Years', 'patients': '3.09K'},
      // Add more Neurosurgeon doctors
    ],
    'ENT': [
      {'name': 'Dr. Kiran Shakia', 'experience': '8 Years', 'patients': '1.08K'},
      {'name': 'Dr. Kiran Shakia', 'experience': '8 Years', 'patients': '1.08K'},
      {'name': 'Dr. Kiran Shakia', 'experience': '8 Years', 'patients': '1.08K'},
      {'name': 'Dr. Kiran Shakia', 'experience': '8 Years', 'patients': '1.08K'},
      {'name': 'Dr. Kiran Shakia', 'experience': '8 Years', 'patients': '1.08K'},
      {'name': 'Dr. Kiran Shakia', 'experience': '8 Years', 'patients': '1.08K'},
      {'name': 'Dr. Kiran Shakia', 'experience': '8 Years', 'patients': '1.08K'},
      {'name': 'Dr. Kiran Shakia', 'experience': '8 Years', 'patients': '1.08K'},
      // Add more ENT doctors
    ],
    'Oncologist': [
      {'name': 'Dr. Masuda Khan', 'experience': '1 Year', 'patients': '2.10K'},
      {'name': 'Dr. Masuda Khan', 'experience': '1 Year', 'patients': '2.10K'},
      {'name': 'Dr. Masuda Khan', 'experience': '1 Year', 'patients': '2.10K'},
      {'name': 'Dr. Masuda Khan', 'experience': '1 Year', 'patients': '2.10K'},
      {'name': 'Dr. Masuda Khan', 'experience': '1 Year', 'patients': '2.10K'},
      {'name': 'Dr. Masuda Khan', 'experience': '1 Year', 'patients': '2.10K'},
      {'name': 'Dr. Masuda Khan', 'experience': '1 Year', 'patients': '2.10K'},
      {'name': 'Dr. Masuda Khan', 'experience': '1 Year', 'patients': '2.10K'},
      {'name': 'Dr. Masuda Khan', 'experience': '1 Year', 'patients': '2.10K'},
      // Add more Oncologist doctors
    ],
    'Cardiologist': [
      {'name': 'Dr. Johir Raihan', 'experience': '4 Years', 'patients': '937'},
      {'name': 'Dr. Johir Raihan', 'experience': '4 Years', 'patients': '937'},
      {'name': 'Dr. Johir Raihan', 'experience': '4 Years', 'patients': '937'},
      {'name': 'Dr. Johir Raihan', 'experience': '4 Years', 'patients': '937'},
      {'name': 'Dr. Johir Raihan', 'experience': '4 Years', 'patients': '937'},
      {'name': 'Dr. Johir Raihan', 'experience': '4 Years', 'patients': '937'},
      {'name': 'Dr. Johir Raihan', 'experience': '4 Years', 'patients': '937'},
      {'name': 'Dr. Johir Raihan', 'experience': '4 Years', 'patients': '937'},
      {'name': 'Dr. Johir Raihan', 'experience': '4 Years', 'patients': '937'},
      // Add more Cardiologist doctors
    ],
    // Add more categories and their respective doctors as needed
  };

  String selectedCategory = 'Pediatrician';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Specialists',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DoctorSearch(doctorsByCategory: doctorsByCategory),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(categories[index]),
                    selected: selectedCategory == categories[index],
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = categories[index];
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Colors.tealAccent,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: doctorsByCategory[selectedCategory]!.length,
              itemBuilder: (context, index) {
                final doctor = doctorsByCategory[selectedCategory]![index];
                return AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.tealAccent.withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ScheduleCard(
                    name: doctor['name']!,
                    specialty: selectedCategory,
                    experience: doctor['experience']!,
                    patients: doctor['patients']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String experience;
  final String patients;

  ScheduleCard({
    required this.name,
    required this.specialty,
    required this.experience,
    required this.patients,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      color: Colors.teal[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.teal, size: 30),
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              specialty,
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  experience,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Text('Patients: $patients', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class DoctorSearch extends SearchDelegate<String> {
  final Map<String, List<Map<String, String>>> doctorsByCategory;

  DoctorSearch({required this.doctorsByCategory});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = doctorsByCategory.entries
        .expand((entry) => entry.value)
        .where((doctor) => doctor['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ScheduleCard(
          name: results[index]['name']!,
          specialty: doctorsByCategory.keys.firstWhere((category) =>
              doctorsByCategory[category]!.contains(results[index])),
          experience: results[index]['experience']!,
          patients: results[index]['patients']!,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = doctorsByCategory.entries
        .expand((entry) => entry.value)
        .where((doctor) => doctor['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]['name']!),
          subtitle: Text(doctorsByCategory.keys.firstWhere((category) =>
              doctorsByCategory[category]!.contains(suggestions[index]))),
          onTap: () {
            query = suggestions[index]['name']!;
            showResults(context);
          },
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ScheduleScreen(),
    theme: ThemeData(
      primaryColor: Colors.teal,
      hintColor: Colors.tealAccent,
      scaffoldBackgroundColor: Colors.white,
    ),
  ));
}