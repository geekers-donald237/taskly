import '../../data/models/task_model.dart';

abstract class TaskRepository {
  TaskRepository();

  Future<List<TaskModel>> getTasks();

  Future<void> createNewTask(TaskModel taskModel);

  Future<List<TaskModel>> updateTask(TaskModel taskModel);

  Future<List<TaskModel>> deleteTask(TaskModel taskModel);

  Future<List<TaskModel>> sortTasks(int sortOption);

  Future<List<TaskModel>> searchTasks(String search);
}
