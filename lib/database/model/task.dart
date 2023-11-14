class Task{
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? desc;
  DateTime? dateTime;
  bool? isDone;

  Task({this.id,this.title,this.desc,this.dateTime,this.isDone});

  Task.fromFireStore(Map<String,dynamic>?data):
    this(
        id: data?['id'],
      title: data?['title'],
      desc: data?['desc'],
      dateTime:DateTime.fromMicrosecondsSinceEpoch(data?['dateTime']) ,
      isDone: data?['isDone']
    );
  Map<String,dynamic>toFireStore(){
    return {
      'id' : id,
      'title' : title,
      'desc' : desc,
      'date':dateTime?.microsecondsSinceEpoch,
      'isDone' : isDone
    };
  }
}