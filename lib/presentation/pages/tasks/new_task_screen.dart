import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/services/notification/toast_service.dart';
import '../../../core/services/utils/utils.dart';
import '../../../data/models/task_model.dart';
import '../../blocs/tasks_bloc/tasks_bloc.dart';
import '../../components/app_bar/custom_app_bar.dart';
import '../../components/text_fields/build_text_field.dart';
import '../../components/widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();
  }

  _onRangeSelected(DateTime? start, DateTime? end, DateTime focusDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusDay;
      _rangeStart = start;
      _rangeEnd = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: const CustomAppBar(
          title: 'Create New Task',
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                BlocConsumer<TasksBloc, TasksState>(listener: (context, state) {
              if (state is AddTaskFailure) {
                ToastService()
                    .showSnackbar(context, state.error, isError: true);
              }
              if (state is AddTasksSuccess) {
                Navigator.pop(context);
              }
            }, builder: (context, state) {
              return ListView(
                children: [
                  TableCalendar(
                    calendarFormat: _calendarFormat,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.week: 'Week',
                    },
                    rangeSelectionMode: RangeSelectionMode.toggledOn,
                    focusedDay: _focusedDay,
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: DateTime.utc(2030, 1, 1),
                    onPageChanged: (focusDay) {
                      _focusedDay = focusDay;
                    },
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onRangeSelected: _onRangeSelected,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: buildText(
                        _rangeStart != null && _rangeEnd != null
                            ? 'Task starting at ${formatDate(dateTime: _rangeStart.toString())} - ${formatDate(dateTime: _rangeEnd.toString())}'
                            : 'Select a date range',
                        Theme.of(context).primaryColor,
                        12.dp,
                        FontWeight.w400,
                        TextAlign.start,
                        TextOverflow.clip),
                  ),
                  const SizedBox(height: 20),
                  buildText('Title', Colors.black, 14.dp, FontWeight.bold,
                      TextAlign.start, TextOverflow.clip),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                      hint: "Task Title",
                      controller: title,
                      inputType: TextInputType.text,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      onChange: (value) {}),
                  const SizedBox(
                    height: 20,
                  ),
                  buildText('Description', Colors.black, 13.dp, FontWeight.bold,
                      TextAlign.start, TextOverflow.clip),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                      hint: "Task Description",
                      controller: description,
                      inputType: TextInputType.multiline,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      onChange: (value) {}),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.onPrimary),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: buildText(
                                  'Cancel',
                                  Colors.black,
                                  14.dp,
                                  FontWeight.w600,
                                  TextAlign.center,
                                  TextOverflow.clip),
                            )),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                ),
                              ),
                            ),
                            onPressed: () {
                              final String taskId = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              var taskModel = TaskModel(
                                  id: taskId,
                                  title: title.text,
                                  description: description.text,
                                  startDateTime: _rangeStart,
                                  stopDateTime: _rangeEnd);
                              context
                                  .read<TasksBloc>()
                                  .add(AddNewTaskEvent(taskModel: taskModel));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: buildText(
                                  'Save',
                                  Theme.of(context).colorScheme.onPrimary,
                                  12.dp,
                                  FontWeight.w600,
                                  TextAlign.center,
                                  TextOverflow.clip),
                            )),
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
