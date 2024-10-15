import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monitoring_stress/screens/history/cubit/get_data_cemas_cubit.dart';
import 'package:monitoring_stress/screens/history/cubit/get_data_tegang_cubit.dart';
import 'package:monitoring_stress/screens/history/cubit/get_data_tenang_cubit.dart';
import 'package:monitoring_stress/screens/history/cubit/get_history_cubit.dart';
import 'package:monitoring_stress/screens/history/detail_page.dart';
import 'package:monitoring_stress/screens/history/history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetHistoryCubit()..getDataRileks(),
        ),
        BlocProvider(
          create: (context) => GetDataTenangCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => GetDataCemasCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => GetDataTegangCubit()..getData(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'History',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Text(
                      'Rileks',
                      style: GoogleFonts.roboto(fontSize: 20),
                    ),
                    Text(
                      'Tenang',
                      style: GoogleFonts.roboto(fontSize: 20),
                    ),
                    Text(
                      'Cemas',
                      style: GoogleFonts.roboto(fontSize: 20),
                    ),
                    Text(
                      'Tegang',
                      style: GoogleFonts.roboto(fontSize: 20),
                    ),
                  ],
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BlocBuilder<GetHistoryCubit, GetHistoryState>(
                      builder: (context, state) {
                        List<String> allKeys = [];
                        if (state is GetHistoryLoaded) {
                          log(state.collection.data.length.toString());
                          allKeys = state.collection.data.keys.toList();
                          return ListView.builder(
                              key: const ValueKey('listViewKey'), //
                              itemCount: state.collection.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: HistoryCard(
                                    title: allKeys[index],
                                    onDelete: () async {
                                      log("deleted ${allKeys[index]}");
                                      context
                                          .read<GetHistoryCubit>()
                                          .delete(allKeys[index]);
                                    },
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                              name: allKeys[index],
                                              collection: state.collection),
                                        )),
                                  ),
                                );
                              });
                        }
                        return const Center(child: Text('Tidak Ada Data'));
                      },
                    ),
                    // TENANG
                    BlocBuilder<GetDataTenangCubit, GetDataTenangState>(
                      builder: (context, tenang) {
                        if (tenang is GetDataTenangLoaded) {
                          List<String> allKeys =
                              tenang.collection.data.keys.toList();
                          return ListView.builder(
                              itemCount: tenang.collection.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: HistoryCard(
                                    title: allKeys[index],
                                    onDelete: () {
                                      log(allKeys[index]);
                                      context
                                          .read<GetDataTenangCubit>()
                                          .delete(allKeys[index]);
                                    },
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                            name: allKeys[index],
                                            collection: tenang.collection,
                                          ),
                                        )),
                                  ),
                                );
                              });
                        }
                        return const Center(child: Text('Tidak Ada Data'));
                      },
                    ),
                    // CEMAS
                    BlocBuilder<GetDataCemasCubit, GetDataCemasState>(
                      builder: (context, state) {
                        if (state is GetDataCemasLoaded) {
                          List<String> allKeys =
                              state.collection.data.keys.toList();
                          return ListView.builder(
                              itemCount: state.collection.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: HistoryCard(
                                    title: allKeys[index],
                                    onDelete: () {
                                      log(allKeys[index]);
                                      context
                                          .read<GetDataCemasCubit>()
                                          .delete(allKeys[index]);
                                    },
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                              name: allKeys[index],
                                              collection: state.collection),
                                        )),
                                  ),
                                );
                              });
                        }
                        return const Center(child: Text('Tidak Ada Data'));
                      },
                    ),
                    // TEGANG
                    BlocBuilder<GetDataTegangCubit, GetDataTegangState>(
                      builder: (context, state) {
                        if (state is GetDataTegangLoaded) {
                          List<String> allKeys =
                              state.collection.data.keys.toList();
                          return ListView.builder(
                              itemCount: state.collection.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: HistoryCard(
                                    title: allKeys[index],
                                    onDelete: () {
                                      log(allKeys[index]);
                                      context
                                          .read<GetDataTegangCubit>()
                                          .delete(allKeys[index]);
                                    },
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                              name: allKeys[index],
                                              collection: state.collection),
                                        )),
                                  ),
                                );
                              });
                        }
                        return const Center(child: Text('Tidak Ada Data'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
