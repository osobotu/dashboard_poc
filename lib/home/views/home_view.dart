import 'package:dashboard_poc/home/cubit/home_cubit.dart';
import 'package:dashboard_poc/home/widgets/widgets.dart';
import 'package:dashboard_poc/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileLayout: MobileHomeView(),
      desktopLayout: DesktopHomeView(),
      tabletLayout: TabletHomeView(),
    );
  }
}

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
        backgroundColor: const Color(0xFF363740),
      ),
      drawer: const BellumDrawer(),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              width: double.infinity,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return const OverviewCard(title: 'Unread', value: 50);
                },
              ),
            ),
          ),
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is HomeSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return ListTile(
                        title: Text(
                          '${user.firstName} ${user.lastName}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(user.email),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar)),
                      );
                    },
                  ),
                );
              }
              return Container(
                color: Colors.amberAccent,
              );
            },
          ),
        ],
      ),
    );
  }
}

class DesktopHomeView extends StatelessWidget {
  const DesktopHomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeInitial) {
            return const ShowProgress();
          } else if (state is HomeLoading) {
            return const ShowProgress();
          } else if (state is HomeSuccess) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BellumDrawer(),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Overview',
                          style: textTheme.headline5,
                        ),
                        trailing: IconButton(
                          tooltip: 'Log Out',
                          icon: const Icon(Icons.logout),
                          color: Colors.deepPurple,
                          onPressed: () {
                            context.go('/');
                          },
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 4,
                        child: SizedBox(
                          width: double.infinity,
                          child: GridView.builder(
                            itemCount: 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemBuilder: (context, index) {
                              return const OverviewCard(
                                  title: 'Unread', value: 50);
                            },
                          ),
                        ),
                      ),
                      BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is HomeSuccess) {
                            return Expanded(
                                child: ListView.builder(
                                    itemCount: state.users.length,
                                    itemBuilder: (context, index) {
                                      final user = state.users[index];
                                      return ListTile(
                                        title: Text(
                                          '${user.firstName} ${user.lastName}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(user.email),
                                        leading: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(user.avatar)),
                                      );
                                    }));
                          }
                          return Container(
                            color: Colors.amberAccent,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: MediaQuery.of(context).size.height,
                //     decoration: const BoxDecoration(
                //       color: Color(0xFFF7F8FC),
                //     ),
                //     child: Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.symmetric(
                //               vertical: 30, horizontal: 30),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text(
                //                 'Overview',
                //                 style: textTheme.displaySmall,
                //               ),
                //               Row(
                //                 children: [
                //                   const Text('Log Out'),
                //                   IconButton(
                //                     tooltip: 'Log Out',
                //                     icon: const Icon(Icons.logout),
                //                     color: Colors.deepPurple,
                //                     onPressed: () {
                //                       context.go('/');
                //                     },
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 30, vertical: 30),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: const [
                //               OverviewCard(
                //                 title: 'Unresolved',
                //                 value: 60,
                //               ),
                //               OverviewCard(
                //                 title: 'Overdue',
                //                 value: 16,
                //               ),
                //               OverviewCard(
                //                 title: 'Open',
                //                 value: 43,
                //               ),
                //               OverviewCard(
                //                 title: 'On Hold',
                //                 value: 64,
                //               ),
                //             ],
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 40, vertical: 0),
                //           child: Card(
                //             child: Container(
                //                 width: MediaQuery.of(context).size.width,
                //                 height: 400,
                //                 child: const Center(
                //                     child: Text('Today\'s trends'))),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            );
          } else if (state is HomeFailure) {
            return ErrorView(errorMessage: state.errorMessage);
          } else {
            return const InitialView();
          }
        },
      ),
    );
  }
}

class TabletHomeView extends StatelessWidget {
  const TabletHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
        backgroundColor: const Color(0xFF363740),
      ),
      drawer: const BellumDrawer(),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 4,
            child: SizedBox(
              width: double.infinity,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return const OverviewCard(title: 'Unread', value: 50);
                },
              ),
            ),
          ),
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is HomeSuccess) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final user = state.users[index];
                          return ListTile(
                            title: Text(
                              '${user.firstName} ${user.lastName}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(user.email),
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.avatar)),
                          );
                        }));
              }
              return Container(
                color: Colors.amberAccent,
              );
            },
          ),
        ],
      ),
    );
  }
}

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFDFE0EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Text(
              value.toString(),
              style: textTheme.displaySmall,
            )
          ],
        ),
      ),
    );
  }
}

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Fetch Users List'),
        onPressed: () {
          context.read<HomeCubit>().getUsers();
        },
      ),
    );
  }
}

class ShowProgress extends StatelessWidget {
  const ShowProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.redAccent),
      ),
    );
  }
}
