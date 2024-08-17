import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:taskly/presentation/pages/tasks/new_task_screen.dart';
import 'package:taskly/presentation/pages/tasks/widgets/task_view.dart';
import '../../../core/services/notification/toast_service.dart';
import '../../blocs/tasks_bloc/tasks_bloc.dart';
import '../../components/app_bar/custom_app_bar.dart';
import '../../components/text_fields/build_text_field.dart';
import '../../components/widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<TasksBloc>().add(FetchTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: ScaffoldMessenger(
            child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          appBar: CustomAppBar(
            title: 'Hi Jerome',
            showBackArrow: false,
            actionWidgets: [
              PopupMenuButton<int>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 1,
                onSelected: (value) {
                  switch (value) {
                    case 0:
                      {
                        context
                            .read<TasksBloc>()
                            .add(SortTaskEvent(sortOption: 0));
                        break;
                      }
                    case 1:
                      {
                        context
                            .read<TasksBloc>()
                            .add(SortTaskEvent(sortOption: 1));
                        break;
                      }
                    case 2:
                      {
                        context
                            .read<TasksBloc>()
                            .add(SortTaskEvent(sortOption: 2));
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
                            'assets/svgs/calender.svg',
                            width: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          buildText(
                              'Sort by date',
                              Colors.black,
                              12.dp,
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
                            'assets/svgs/task_checked.svg',
                            width: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          buildText(
                              'Completed tasks',
                              Colors.black,
                              12.dp,
                              FontWeight.normal,
                              TextAlign.start,
                              TextOverflow.clip)
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/task.svg',
                            width: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          buildText(
                              'Pending tasks',
                              Colors.black,
                              12.dp,
                              FontWeight.normal,
                              TextAlign.start,
                              TextOverflow.clip)
                        ],
                      ),
                    ),
                  ];
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset('assets/svgs/filter.svg'),
                ),
              ),
            ],
          ),
          body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: BlocConsumer<TasksBloc, TasksState>(
                      listener: (context, state) {
                    if (state is LoadTaskFailure) {
                      ToastService()
                          .showSnackbar(context, state.error, isError: true);
                    }

                    if (state is AddTaskFailure || state is UpdateTaskFailure) {
                      context.read<TasksBloc>().add(FetchTaskEvent());
                    }
                  }, builder: (context, state) {
                    if (state is TasksLoading) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }

                    if (state is LoadTaskFailure) {
                      return Center(
                        child: buildText(
                            state.error,
                            Colors.black,
                            14.dp,
                            FontWeight.normal,
                            TextAlign.center,
                            TextOverflow.clip),
                      );
                    }

                    if (state is FetchTasksSuccess) {
                      return state.tasks.isNotEmpty || state.isSearching
                          ? Column(
                              children: [
                                BuildTextField(
                                    hint: "Search recent task",
                                    controller: searchController,
                                    inputType: TextInputType.text,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                    fillColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    onChange: (value) {
                                      context.read<TasksBloc>().add(
                                          SearchTaskEvent(keywords: value));
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                    child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.tasks.length,
                                  itemBuilder: (context, index) {
                                    return TaskItemView(
                                        taskModel: state.tasks[index]);
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    );
                                  },
                                ))
                              ],
                            )
                          : Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/tasks.svg',
                                    height: size.height * .20,
                                    width: size.width,
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  buildText(
                                      'Schedule your tasks',
                                      Colors.black,
                                      30.dp,
                                      FontWeight.w600,
                                      TextAlign.center,
                                      TextOverflow.clip),
                                  buildText(
                                      'Manage your task schedule easily\nand efficiently',
                                      Colors.black.withOpacity(.5),
                                      12.dp,
                                      FontWeight.normal,
                                      TextAlign.center,
                                      TextOverflow.clip),
                                ],
                              ),
                            );
                    }
                    return Container();
                  }))),
          floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add_circle,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).push(SwipeablePageRoute(
                  canOnlySwipeFromEdge: true,
                  builder: (BuildContext context) => const NewTaskScreen(),
                ));
              }),
        )));
  }
}
