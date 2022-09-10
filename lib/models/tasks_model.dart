class TasksDAO {
  int? idTask;
  String? dscTask;
  DateTime? fechaEntrega;

  TasksDAO({this.idTask, this.dscTask, this.fechaEntrega});

  factory TasksDAO.fromJSON(Map<String, dynamic> mapTask) {
    return TasksDAO(
      idTask: mapTask['idTask'],
      dscTask: mapTask['dscTask'],
      fechaEntrega: mapTask['fechaEntrega'],
    );
  }
}
