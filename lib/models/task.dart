// parameter yg diproses di AI itu

// penghubung antara client dan server(kita) dan ditengah tengah ada restful API

// setiap kali user masukkin tugas di app kamu, ini bakal jadi object Task
// ini yang nanti dikirim ke server buat diproses AI schedule generator
class Task {
  final String name;
  final String priority;
  final int duration;
  final String deadline;

  Task({required this.name, required this.priority, required this.duration, required this.deadline});

  @override
  //penyamarataan tipe data to string
  String toString() {
    return 'Task{name: $name, priority: $priority, duration: $duration, deadline: $deadline}';
  }
}