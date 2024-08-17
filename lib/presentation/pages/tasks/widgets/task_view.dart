import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:taskly/presentation/pages/tasks/update_task_screen.dart';
import '../../../../core/services/utils/utils.dart';
import '../../../../data/models/task_model.dart';
import '../../../blocs/tasks_bloc/tasks_bloc.dart';
import '../../../components/widget.dart';

class TaskItemView extends StatefulWidget {
  final TaskModel taskModel;

  const TaskItemView({super.key, required this.taskModel});

  @override
  State<TaskItemView> createState() => _TaskItemViewState();
}

class _TaskItemViewState extends State<TaskItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
                value: widget.taskModel.completed,
                onChanged: (value) {
                  var taskModel = TaskModel(
                      id: widget.taskModel.id,
                      title: widget.taskModel.title,
                      description: widget.taskModel.description,
                      completed: !widget.taskModel.completed,
                      startDateTime: widget.taskModel.startDateTime,
                      stopDateTime: widget.taskModel.stopDateTime);
                  context
                      .read<TasksBloc>()
                      .add(UpdateTaskEvent(taskModel: taskModel));
                }),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: buildText(
                              widget.taskModel.title,
                              Colors.black,
                              14.dp,
                              FontWeight.w500,
                              TextAlign.start,
                              TextOverflow.clip)),
                      PopupMenuButton<int>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Theme.of(context).colorScheme.onPrimary,
                        elevation: 1,
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              {
                                Navigator.of(context).push(SwipeablePageRoute(
                                  canOnlySwipeFromEdge: true,
                                  builder: (BuildContext context) =>
                                      UpdateTaskScreen(
                                          taskModel: widget.taskModel),
                                ));
                                break;
                              }
                            case 1:
                              {
                                context.read<TasksBloc>().add(DeleteTaskEvent(
                                    taskModel: widget.taskModel));
                                break;
                              }
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/edit.svg',
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Edit task',
                                      Colors.black,
                                      14.dp,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip)
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/delete.svg',
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Delete task',
                                      Colors.red,
                                      14.dp,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip)
                                ],
                              ),
                            ),
                          ];
                        },
                        child:
                            SvgPicture.asset('assets/svgs/vertical_menu.svg'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  buildText(
                      widget.taskModel.description,
                      Colors.black,
                      12.dp,
                      FontWeight.normal,
                      TextAlign.start,
                      TextOverflow.clip),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/calender.svg',
                            width: 12,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: buildText(
                                '${formatDate(dateTime: widget.taskModel.startDateTime.toString())} - ${formatDate(dateTime: widget.taskModel.stopDateTime.toString())}',
                                Colors.black,
                                10.dp,
                                FontWeight.w400,
                                TextAlign.start,
                                TextOverflow.clip),
                          )
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
  }
}
