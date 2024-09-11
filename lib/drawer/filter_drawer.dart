// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taskwarrior/config/app_settings.dart';
import 'package:taskwarrior/model/storage/storage_widget.dart';
import 'package:taskwarrior/views/home/home.dart';
import 'package:taskwarrior/widgets/project_filter.dart';
import 'package:taskwarrior/widgets/tag_filter.dart';

// ignore: must_be_immutable
class FilterDrawer extends StatelessWidget {
  FilterDrawer(this.filters, {super.key});
  var tileColor = AppSettings.isDarkMode
      ? const Color.fromARGB(255, 48, 46, 46)
      : const Color.fromARGB(255, 220, 216, 216);

  final Filters filters;
  @override
  Widget build(BuildContext context) {
    var storageWidget = StorageWidget.of(context);
    return Drawer(
      backgroundColor: AppSettings.isDarkMode
          ? Color.fromARGB(255, 29, 29, 29)
          : Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            primary: false,
            key: const PageStorageKey('tags-filter'),
            children: [
              const Divider(
                color: Color.fromARGB(0, 48, 46, 46),
              ),
              Container(
                height: 45,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Text(
                    'Apply Filters',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: (AppSettings.isDarkMode
                            ? Colors.white
                            : Color.fromARGB(255, 48, 46, 46)),
                        fontSize: 25),
                  ),
                ),
              ),
              const Divider(
                color: Color.fromARGB(0, 48, 46, 46),
              ),
              Container(
                // width: MediaQuery.of(context).size.width * 1,
                // padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: tileColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListTile(
                  title: RichText(
                    maxLines: 2,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Status : ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppSettings.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: filters.pendingFilter ? 'pending' : 'completed',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: AppSettings.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: filters.togglePendingFilter,
                  textColor: AppSettings.isDarkMode
                      ? Colors.white
                      : Color.fromARGB(255, 48, 46, 46),
                ),
              ),
              const Divider(
                color: Color.fromARGB(0, 48, 46, 46),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                // padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: tileColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ProjectsColumn(
                  filters.projects,
                  filters.projectFilter,
                  filters.toggleProjectFilter,
                ),
              ),
              const Divider(
                color: Color.fromARGB(0, 48, 46, 46),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: tileColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Divider(
                      color: Color.fromARGB(0, 48, 46, 46),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Text(
                        'Filter Tag By:',
                        style: GoogleFonts.poppins(
                            color: (AppSettings.isDarkMode
                                ? Colors.white
                                : Color.fromARGB(255, 48, 46, 46)),
                            //
                            fontSize: 18),
                        //textAlign: TextAlign.right,
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(0, 48, 46, 46),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TagFiltersWrap(filters.tagFilters),
                    ),
                    const Divider(
                      color: Color.fromARGB(0, 48, 46, 46),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color.fromARGB(0, 48, 46, 46),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: tileColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                //height: 30,
                child: Column(
                  children: [
                    const Divider(
                      color: Color.fromARGB(0, 48, 46, 46),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Text(
                        'Sort By',
                        style: GoogleFonts.poppins(
                            color: (AppSettings.isDarkMode
                                ? Colors.white
                                : Color.fromARGB(255, 48, 46, 46)),
                            fontSize: 18),
                        //textAlign: TextAlign.right,
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(0, 48, 46, 46),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          for (var sort in [
                            'Created',
                            'Modified',
                            'Start Time',
                            'Due till',
                            'Priority',
                            'Project',
                            'Tags',
                            'Urgency',
                          ])
                            ChoiceChip(
                              label:
                                  (storageWidget.selectedSort.startsWith(sort))
                                      ? Text(
                                          storageWidget.selectedSort,
                                        )
                                      : Text(sort),
                              selected: false,
                              onSelected: (_) {
                                if (storageWidget.selectedSort == '$sort+') {
                                  storageWidget.selectSort('$sort-');
                                } else if (storageWidget.selectedSort ==
                                    '$sort-') {
                                  storageWidget.selectSort(sort);
                                } else {
                                  storageWidget.selectSort('$sort+');
                                }
                              },
                              labelStyle: GoogleFonts.poppins(
                                  color: AppSettings.isDarkMode
                                      ? Colors.black
                                      : Colors.white),
                              backgroundColor: AppSettings.isDarkMode
                                  ? Color.fromARGB(255, 220, 216, 216)
                                  : Color.fromARGB(255, 48, 46, 46),
                            ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(0, 48, 46, 46),
                    ),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppSettings.isDarkMode
                            ? Color.fromARGB(255, 220, 216, 216)
                            : Color.fromARGB(255, 48, 46, 46),
                      ),
                      child: TextButton(
                          onPressed: () {
                            if (storageWidget.selectedSort.endsWith('+') ||
                                storageWidget.selectedSort.endsWith('-')) {
                              storageWidget.selectSort(
                                  storageWidget.selectedSort.substring(0,
                                      storageWidget.selectedSort.length - 1));
                            }
                          },
                          child: Text(
                            'Reset Sort',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: AppSettings.isDarkMode
                                    ? Color.fromARGB(255, 48, 46, 46)
                                    : Colors.white),
                          )),
                    ),
                    const Divider(
                      color: Color.fromARGB(0, 48, 46, 46),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class TagFilterMetadata {
//   const TagFilterMetadata({
//     required this.display,
//     required this.selected,
//   });

//   final String display;
//   final bool selected;
// }

// class TagFilters {
//   const TagFilters({
//     required this.tagUnion,
//     required this.toggleTagUnion,
//     required this.tags,
//     required this.toggleTagFilter,
//   });

//   final bool tagUnion;
//   final void Function() toggleTagUnion;
//   final Map<String, TagFilterMetadata> tags;
//   final void Function(String) toggleTagFilter;
// }

// class TagFiltersWrap extends StatelessWidget {
//   const TagFiltersWrap(this.filters, {super.key});

//   final TagFilters filters;

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 4,
//       children: [
//         FilterChip(
//             onSelected: (_) => filters.toggleTagUnion(),
//             label: Text(filters.tagUnion ? 'OR' : 'AND',
//                 style: GoogleFonts.poppins())),
//         for (var entry in filters.tags.entries)
//           FilterChip(
//             onSelected: (_) => filters.toggleTagFilter(entry.key),
//             label: Text(
//               entry.value.display,
//               style: GoogleFonts.poppins(
//                 fontWeight: entry.value.selected ? FontWeight.w700 : null,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
