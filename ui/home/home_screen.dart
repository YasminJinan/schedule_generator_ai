import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/services/gemini_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  final List<Task> tasks = []; // wadah untuk menampung input task dr user
  String scheduleResult = ''; // wadah untuk menampung hasil generate schedule dr gemini
  final GeminiService geminiService = GeminiService();

  // ini adalah suatu kondisi dimana kalo kita click button schedule, 
  // lalu generate ini punya 2 proses yg bersamaan jadi disini kita tambahin async method
  Future<void> _generateSchedule() async { 
    setState(() => isLoading = true); // kita trigger ui nya yaitu loading
    try { // disini kita juga sambil ngeset try catch buat memproses data dari Gemini nya
      String schedule = await geminiService.generateSchedule(tasks); // kalo misal proses generate nya selesai
      setState(() => scheduleResult = schedule); // maka akan menampilan schedule result dari hasil generete dari Gemini
    } catch (e) { // nah disini ada juga catch buat menangkap kalo schedule error
      setState(() => scheduleResult = e.toString());
    }
    // gamungkin kalo loadingnya active terus, bikin kondisi pas proses try catch selesai, loading hilang
    setState(() => isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Generator'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildHeader(),
          // letakan component add task card disini
          // letakan component task list disini
          _buildGenerateButton()
        ],
      ),
    );
  }
  
  // Header Chip 
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outline,)
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "plan your day faster",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  "Add task and generate",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant
                  ),
                )
              ],
            ),
          ),
          Chip(label:Text('${tasks.length} task'))
        ],
      ),
    );
  }

  // Button Generate
  Widget _buildGenerateButton() {
    return FilledButton.icon(
      onPressed: (isLoading || tasks.isEmpty) ? null : _generateSchedule,
      // Bisa ditekan dan menjalankan _generateSchedule() kalau tidak loading dan task ada isinya
      icon: isLoading
          ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2,),
          )
          : Icon(Icons.auto_awesome_rounded),
      label: Text(isLoading ? 'Generating...' : 'Generate Schedule'),
    ) ;

  }
}