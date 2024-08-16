import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ibrahim_lokman_info/widgets/glass_card.dart';

class ResumeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const ResumeScreen(
      {Key? key, required this.isDarkMode, required this.toggleTheme})
      : super(key: key);

  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'Skills': GlobalKey(),
    'Experience': GlobalKey(),
    'Education': GlobalKey(),
    'Projects': GlobalKey(),
  };
  String _selectedSection = '';
  void _scrollToSection(String section) {
    setState(() {
      _selectedSection = section;
    });
    final context = _sectionKeys[section]?.currentContext;
    if (context != null) {
      // Get the render box of the section
      final RenderBox box = context.findRenderObject() as RenderBox;
      // Get the position of the section relative to the viewport
      final position = box.localToGlobal(Offset.zero);
      // Get the current scroll offset
      final currentScroll = _scrollController.offset;
      // Calculate the new offset
      final newOffset = currentScroll +
          position.dy -
          MediaQuery.of(context).padding.top -
          kToolbarHeight -
          16;

      // Calculate the maximum scroll extent
      final maxScroll = _scrollController.position.maxScrollExtent;

      // Ensure the new offset doesn't exceed the maximum scroll extent
      final clampedOffset = newOffset.clamp(0.0, maxScroll);

      _scrollController.animateTo(
        clampedOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: const Text('Ibrahim Lokman'),
            pinned: true,
            floating: false,
            backgroundColor: Colors.transparent,
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),
            ),
            // actions: [
            //   ..._sectionKeys.keys.map(
            //     (section) => TextButton(
            //       onPressed: () => _scrollToSection(section),
            //       child: Text(
            //         section,
            //         style: TextStyle(
            //           color: _selectedSection == section
            //               ? widget.isDarkMode
            //                   ? Colors.white
            //                   : const Color.fromARGB(255, 97, 31, 110)
            //               : widget.isDarkMode
            //                   ? Colors.white
            //                   : Colors.black,
            //           fontWeight: _selectedSection == section
            //               ? FontWeight.bold
            //               : FontWeight.normal,
            //         ),
            //       ),
            //     ),
            //   ),
            //   Switch(
            //     value: widget.isDarkMode,
            //     onChanged: (_) => widget.toggleTheme(),
            //     activeColor: Colors.white,
            //   ),
            // ],

            actions: [
              ..._sectionKeys.keys.map(
                (section) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton(
                    onPressed: () => _scrollToSection(section),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedSection == section
                          ? (widget.isDarkMode
                              ? Colors.white.withOpacity(0.2)
                              : const Color.fromARGB(255, 97, 31, 110))
                          : Colors.transparent,
                      elevation: _selectedSection == section ? 4 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      section,
                      style: TextStyle(
                        color: _selectedSection == section
                            ? (widget.isDarkMode ? Colors.white : Colors.white)
                            : (widget.isDarkMode ? Colors.white : Colors.black),
                        fontWeight: _selectedSection == section
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Switch(
                value: widget.isDarkMode,
                onChanged: (_) => widget.toggleTheme(),
                activeColor: Colors.white,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isDarkMode
                      ? [Colors.grey[900]!, Colors.blueGrey[900]!]
                      : [Colors.blue[200]!, Colors.purple[200]!],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlassCard(
                        child: _buildContactInfo(),
                        isDarkMode: widget.isDarkMode),
                    const SizedBox(height: 20),
                    GlassCard(
                        child: _buildCareerObjective(),
                        isDarkMode: widget.isDarkMode),
                    const SizedBox(height: 20),
                    GlassCard(
                      child: _buildSkills(),
                      isDarkMode: widget.isDarkMode,
                      key: _sectionKeys['Skills'],
                      isSelected: _selectedSection == 'Skills',
                    ),
                    // ... other sections
                    const SizedBox(height: 20),
                    GlassCard(
                      child: _buildWorkExperience(),
                      isDarkMode: widget.isDarkMode,
                      key: _sectionKeys['Experience'],
                      isSelected: _selectedSection == 'Experience',
                    ),
                    const SizedBox(height: 20),
                    GlassCard(
                        child: _buildOnlineCourses(),
                        isDarkMode: widget.isDarkMode),
                    const SizedBox(height: 20),
                    GlassCard(
                        child: _buildAchievement(),
                        isDarkMode: widget.isDarkMode),
                    const SizedBox(height: 20),
                    GlassCard(
                      child: _buildProjects(),
                      isDarkMode: widget.isDarkMode,
                      key: _sectionKeys['Projects'],
                      isSelected: _selectedSection == 'Projects',
                    ),
                    const SizedBox(height: 20),
                    GlassCard(
                      child: _buildEducation(),
                      isDarkMode: widget.isDarkMode,
                      key: _sectionKeys['Education'],
                      isSelected: _selectedSection == 'Education',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // appBar: AppBar(
  //     //   title: const Text('Ibrahim Lokman'),
  //     //   backgroundColor: Colors.transparent,
  //     //   elevation: 0,
  //     //   flexibleSpace: ClipRect(
  //     //     child: BackdropFilter(
  //     //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //     //       child: Container(color: Colors.transparent),
  //     //     ),
  //     //   ),
  //     //   actions: [
  //     //     ..._sectionKeys.keys.map(
  //     //       (section) => TextButton(
  //     //         onPressed: () => _scrollToSection(section),
  //     //         child: Text(
  //     //           section,
  //     //           style: TextStyle(
  //     //             color: _selectedSection == section
  //     //                 ? Colors.white
  //     //                 : Colors.white70,
  //     //             fontWeight: _selectedSection == section
  //     //                 ? FontWeight.bold
  //     //                 : FontWeight.normal,
  //     //           ),
  //     //         ),
  //     //       ),
  //     //     ),
  //     //     Switch(
  //     //       value: widget.isDarkMode,
  //     //       onChanged: (_) => widget.toggleTheme(),
  //     //       activeColor: Colors.white,
  //     //     ),
  //     //   ],
  //     // ),
  //     // extendBodyBehindAppBar: true,

  //     body: Container(
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //           colors: widget.isDarkMode
  //               ? [Colors.grey[900]!, Colors.blueGrey[900]!]
  //               : [Colors.blue[200]!, Colors.purple[200]!],
  //         ),
  //       ),
  //       child: SingleChildScrollView(
  //         controller: _scrollController,
  //         padding: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             GlassCard(
  //                 child: _buildContactInfo(), isDarkMode: widget.isDarkMode),
  //             const SizedBox(height: 20),
  //             GlassCard(
  //                 child: _buildCareerObjective(),
  //                 isDarkMode: widget.isDarkMode),
  //             const SizedBox(height: 20),
  //             GlassCard(
  //               child: _buildSkills(),
  //               isDarkMode: widget.isDarkMode,
  //               key: _sectionKeys['Skills'],
  //               isSelected: _selectedSection == 'Skills',
  //             ),
  //             const SizedBox(height: 20),
  //             GlassCard(
  //               child: _buildWorkExperience(),
  //               isDarkMode: widget.isDarkMode,
  //               key: _sectionKeys['Experience'],
  //               isSelected: _selectedSection == 'Experience',
  //             ),
  //             const SizedBox(height: 20),
  //             GlassCard(
  //                 child: _buildOnlineCourses(), isDarkMode: widget.isDarkMode),
  //             const SizedBox(height: 20),
  //             GlassCard(
  //                 child: _buildAchievement(), isDarkMode: widget.isDarkMode),
  //             const SizedBox(height: 20),
  //             GlassCard(
  //               child: _buildProjects(),
  //               isDarkMode: widget.isDarkMode,
  //               key: _sectionKeys['Projects'],
  //               isSelected: _selectedSection == 'Projects',
  //             ),
  //             const SizedBox(height: 20),
  //             GlassCard(
  //               child: _buildEducation(),
  //               isDarkMode: widget.isDarkMode,
  //               key: _sectionKeys['Education'],
  //               isSelected: _selectedSection == 'Education',
  //             ),

  //           ],
  //         ),
  //       ),
  //       // child: SingleChildScrollView(
  //       //   controller: _scrollController,
  //       //   padding: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
  //       //   child: Column(
  //       //     crossAxisAlignment: CrossAxisAlignment.start,
  //       //     children: [
  //       //       GlassCard(
  //       //           child: _buildContactInfo(), isDarkMode: widget.isDarkMode),
  //       //       const SizedBox(height: 20),
  //       //       GlassCard(
  //       //           child: _buildCareerObjective(),
  //       //           isDarkMode: widget.isDarkMode),
  //       //       const SizedBox(height: 20),
  //       //       GlassCard(
  //       //         child: _buildSkills(),
  //       //         isDarkMode: widget.isDarkMode,
  //       //         key: _sectionKeys['skills'],
  //       //       ),
  //       //       const SizedBox(height: 20),
  //       //       GlassCard(
  //       //         child: _buildWorkExperience(),
  //       //         isDarkMode: widget.isDarkMode,
  //       //         key: _sectionKeys['experience'],
  //       //       ),
  //       //       const SizedBox(height: 20),
  //       //       GlassCard(
  //       //           child: _buildOnlineCourses(), isDarkMode: widget.isDarkMode),
  //       //       const SizedBox(height: 20),
  //       //       GlassCard(
  //       //           child: _buildAchievement(), isDarkMode: widget.isDarkMode),
  //       //       const SizedBox(height: 20),
  //       //       GlassCard(
  //       //         child: _buildProjects(),
  //       //         isDarkMode: widget.isDarkMode,
  //       //         key: _sectionKeys['projects'],
  //       //       ),
  //       //       const SizedBox(height: 20),
  //       //       GlassCard(
  //       //         child: _buildEducation(),
  //       //         isDarkMode: widget.isDarkMode,
  //       //         key: _sectionKeys['education'],
  //       //       ),
  //       //     ],
  //       //   ),
  //       // ),
  //     ),
  //   );
  // }

  /// G L A S S   E F E C T   R E S U M E
// class ResumeScreen extends StatelessWidget {
//   const ResumeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ibrahim Lokman'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: ClipRect(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: Container(color: Colors.transparent),
//           ),
//         ),
//       ),
//       extendBodyBehindAppBar: true,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.blue[200]!, Colors.purple[200]!],
//           ),
//         ),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GlassCard(child: _buildContactInfo()),
//               const SizedBox(height: 20),
//               GlassCard(child: _buildCareerObjective()),
//               const SizedBox(height: 20),
//               GlassCard(child: _buildSkills()),
//               const SizedBox(height: 20),
//               GlassCard(child: _buildWorkExperience()),
//               const SizedBox(height: 20),
//               GlassCard(child: _buildOnlineCourses()),
//               const SizedBox(height: 20),
//               GlassCard(child: _buildAchievement()),
//               const SizedBox(height: 20),
//               GlassCard(child: _buildProjects()),
//               const SizedBox(height: 20),
//               GlassCard(child: _buildEducation()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

  ///  N O R M A L
// class ResumeScreen extends StatelessWidget {
//   const ResumeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ibrahim Lokman'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildContactInfo(),
//             const SizedBox(height: 20),
//             _buildCareerObjective(),
//             const SizedBox(height: 20),
//             _buildSkills(),
//             const SizedBox(height: 20),
//             _buildWorkExperience(),
//             const SizedBox(height: 20),
//             _buildOnlineCourses(),
//             const SizedBox(height: 20),
//             _buildAchievement(),
//             const SizedBox(height: 20),
//             _buildProjects(),
//             const SizedBox(height: 20),
//             _buildEducation(),
//           ],
//         ),
//       ),
//     );
//   }

  Widget _buildContactInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ibrahim Lokman',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Email: ibrahimlokman.bd@gmail.com'),
        Text('Phone: +8801625218406'),
        Text('Address: Aftabnagar, Dhaka'),
        Text('LinkedIn: linkedin.com/in/ibrahim-lokman'),
        Text('Github: github.com/Ibrahim-Lokman'),
        Text('DataCamp: app.datacamp.com/profile/ibrahimlokman'),
        Text('Leetcode: leetcode.com/ibrahim_lokman/'),
      ],
    );
  }

  Widget _buildSkills() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('• Java, Dart, JavaScript'),
        Text('• Flutter (Bloc, GetX)'),
        Text('• IOS (UIKit, Swift)'),
        Text('• Android (XML, Kotlin)'),
        Text('• Linux, Git'),
        Text('• MySQL, MongoDB, Neo4J'),
        Text('• Problem Solving'),
      ],
    );
  }

  Widget _buildWorkExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Work Experience',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildJobEntry(
          'Software Engineer',
          'Innospace Infotech Limited',
          'Feb 10, 2024 - Present',
          ['Working on a CRM App. (Bloc)', 'Working on an EdTech App. (Bloc)'],
        ),
        const SizedBox(height: 15),
        _buildJobEntry(
          'Trainee Software Engineer (Flutter)',
          'RedDot Digital Limited',
          'June 1, 2023 - Jan 15, 2024',
          [
            'Worked on a Sales Force Automation SaaS app. (GetX)',
            'Worked on an E-learning app. (GetX)',
            'Worked on Manual Attendance and Leave Request features of Human Resources Information System (HRIS) app (GetX)',
          ],
        ),
        const SizedBox(height: 15),
        _buildJobEntry(
          'Intern Software Engineering',
          'RedDot Digital Limited',
          'January 23, 2023 - May 23, 2023',
          [
            'Worked on PMS Planning feature of Human Resources Information System (HRIS) app.'
          ],
        ),
      ],
    );
  }

  Widget _buildJobEntry(String title, String company, String duration,
      List<String> responsibilities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(company,
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
        Text(duration, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 5),
        ...responsibilities.map((r) => Text('• $r')).toList(),
      ],
    );
  }

  Widget _buildCareerObjective() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Career Objective',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(
            'To pursue a challenging and growth-oriented career in an organization that may broaden my current skills, knowledge, and abilities gathered through education and thus become a successful Software Engineer. Additionally, I have interests in Data Science, Machine Learning, Distributed Computing, and Blockchain.'),
      ],
    );
  }

  Widget _buildOnlineCourses() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Online Courses',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(
            '1. Spring Boot 3, Spring 6 & Hibernate for Beginners by Chad Darby'),
        Text('2. Neo4j and Cypher Fundamentals by Neo4j Graph'),
        Text('3. Feature Engineering for ML, Udemy'),
        Text('4. Blockchain Basics'),
      ],
    );
  }

  Widget _buildAchievement() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Achievement',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Finalist at "Therap JavaFest 2022"'),
      ],
    );
  }

  Widget _buildProjects() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Projects',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Web App and Mobile App:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text('1. Online Quiz web with Spring Boot and Angular'),
        Text('2. Online Shop project with Flutter and Firebase'),
        Text('3. Meal Menu project with Flutter'),
        Text('4. Expense Tracker project with Flutter'),
        Text('5. Community Market app with Django and Flutter'),
        Text('6. Online Car Showroom web with PHP and HTML, CSS'),
      ],
    );
  }

  Widget _buildEducation() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Education',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Bachelor of Science',
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Computer Science and Engineering'),
        Text('CGPA: 3.66'),
        Text('BRAC University'),
        Text('January 2019 - December 2022'),
      ],
    );
  }
}
