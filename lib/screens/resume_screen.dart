import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibrahim_lokman_info/widgets/glass_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeScreen extends StatefulWidget {
  final bool isDarkMode;
  // final VoidCallback toggleTheme;

  const ResumeScreen({
    super.key,
    required this.isDarkMode,
    // required this.toggleTheme,
  });

  @override
  ResumeScreenState createState() => ResumeScreenState();
}

class ResumeScreenState extends State<ResumeScreen> {
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
      // floatingActionButton: Switch(
      //   value: widget.isDarkMode,
      //   onChanged: (_) => widget.toggleTheme(),
      //   activeColor: Colors.white,
      // ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: null,
            pinned: true,
            floating: false,
            backgroundColor: Colors.transparent,
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),
            ),
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
                        isDarkMode: widget.isDarkMode,
                        child: _buildContactInfo()),
                    const SizedBox(height: 20),
                    GlassCard(
                        isDarkMode: widget.isDarkMode,
                        child: _buildCareerObjective()),
                    const SizedBox(height: 20),
                    GlassCard(
                      isDarkMode: widget.isDarkMode,
                      key: _sectionKeys['Skills'],
                      isSelected: _selectedSection == 'Skills',
                      child: _buildSkills(),
                    ),
                    // ... other sections
                    const SizedBox(height: 20),
                    GlassCard(
                      isDarkMode: widget.isDarkMode,
                      key: _sectionKeys['Experience'],
                      isSelected: _selectedSection == 'Experience',
                      child: _buildWorkExperience(),
                    ),
                    const SizedBox(height: 20),
                    GlassCard(
                      isDarkMode: widget.isDarkMode,
                      child: _buildOnlineCourses(),
                    ),
                    const SizedBox(height: 20),
                    GlassCard(
                      isDarkMode: widget.isDarkMode,
                      child: _buildAchievement(),
                    ),
                    const SizedBox(height: 20),
                    GlassCard(
                      isDarkMode: widget.isDarkMode,
                      key: _sectionKeys['Education'],
                      isSelected: _selectedSection == 'Education',
                      child: _buildEducation(),
                    ),
                    const SizedBox(height: 20),
                    GlassCard(
                      isDarkMode: widget.isDarkMode,
                      key: _sectionKeys['Projects'],
                      isSelected: _selectedSection == 'Projects',
                      child: _buildProjects(),
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

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ibrahim Lokman',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const Text('Aftabnagar, Dhaka'),
        const SizedBox(height: 10),
        _buildClickableText('Email: ibrahimlokman.bd@gmail.com',
            'mailto:ibrahimlokman.bd@gmail.com'),
        _buildClickableText('Phone: +8801625218406', 'tel:+8801625218406'),
        _buildClickableText('LinkedIn: linkedin.com/in/ibrahim-lokman',
            'https://linkedin.com/in/ibrahim-lokman'),
        _buildClickableText('Github: github.com/Ibrahim-Lokman',
            'https://github.com/Ibrahim-Lokman'),
        _buildClickableText('DataCamp: app.datacamp.com/profile/ibrahimlokman',
            'https://app.datacamp.com/profile/ibrahimlokman'),
        _buildClickableText('Leetcode: leetcode.com/ibrahim_lokman/',
            'https://leetcode.com/ibrahim_lokman/'),
      ],
    );
  }

  Widget _buildClickableText(String text, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Chip(
          label: Text(
            text,
            style: const TextStyle(
              //      color: Colors.blue,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (kIsWeb) {
      // Running on web
      if (await canLaunchUrl(url)) {
        await launchUrl(url, webOnlyWindowName: '_blank');
      } else {
        throw 'Could not launch $url';
      }
    } else {
      // Running on mobile or desktop
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }
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
  // Widget _buildWorkExperience() {
  //   final List<Widget> experienceCards = [
  //     _buildExperienceCard(
  //       'Software Engineer',
  //       'Innospace Infotech Limited',
  //       'Feb 10, 2024 - Present',
  //       ['Working on a CRM App. (Bloc)', 'Working on an EdTech App. (Bloc)'],
  //     ),
  //     _buildExperienceCard(
  //       'Trainee Software Engineer (Flutter)',
  //       'RedDot Digital Limited',
  //       'June 1, 2023 - Jan 15, 2024',
  //       [
  //         'Worked on a Sales Force Automation SaaS app. (GetX)',
  //         'Worked on an E-learning app. (GetX)',
  //         'Worked on Manual Attendance and Leave Request features of Human Resources Information System (HRIS) app (GetX)',
  //       ],
  //     ),
  //     _buildExperienceCard(
  //       'Intern Software Engineering',
  //       'RedDot Digital Limited',
  //       'January 23, 2023 - May 23, 2023',
  //       [
  //         'Worked on PMS Planning feature of Human Resources Information System (HRIS) app.'
  //       ],
  //     ),
  //   ];

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text('Work Experience',
  //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  //       const SizedBox(height: 20),
  //       ConstrainedBox(
  //         constraints: const BoxConstraints(
  //           maxWidth: double.infinity,
  //           minWidth: double.infinity,
  //           minHeight: 100,
  //           maxHeight: 300,
  //         ), // Adjust this value as needed
  //         child: CarouselSlider(
  //           options: CarouselOptions(
  //             enlargeCenterPage: false,
  //             autoPlay: true,
  //             aspectRatio: 16 / 9,
  //             autoPlayCurve: Curves.fastOutSlowIn,
  //             enableInfiniteScroll: true,
  //             autoPlayAnimationDuration: const Duration(milliseconds: 300),
  //             viewportFraction: 0.5,
  //           ),
  //           items: experienceCards,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildExperienceCard(String title, String company, String duration,
  //     List<String> responsibilities) {
  //   return Card(
  //     elevation: 4,
  //     margin: const EdgeInsets.all(10),
  //     child: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(title,
  //                 style: const TextStyle(
  //                     fontSize: 18, fontWeight: FontWeight.bold)),
  //             const SizedBox(height: 8),
  //             Text(company,
  //                 style: const TextStyle(
  //                     fontSize: 16, fontStyle: FontStyle.italic)),
  //             Text(duration,
  //                 style: const TextStyle(fontSize: 14, color: Colors.grey)),
  //             const SizedBox(height: 12),
  //             ...responsibilities
  //                 .map((resp) => Padding(
  //                       padding: const EdgeInsets.only(bottom: 4),
  //                       child: Row(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           const Text('• ',
  //                               style: TextStyle(
  //                                   fontSize: 14, fontWeight: FontWeight.bold)),
  //                           Expanded(
  //                               child: Text(resp,
  //                                   style: const TextStyle(fontSize: 14))),
  //                         ],
  //                       ),
  //                     ))
  //                 .toList(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildJobEntry(String title, String company, String duration,
      List<String> responsibilities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        // Container(
        //   padding: const EdgeInsets.all(5),
        //   decoration: BoxDecoration(
        //     color: Colors.black,
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   child: Image.asset(
        //     'assets/images/innospace_logo.png',
        //     height: 50,
        //     fit: BoxFit.contain,
        //   ),
        // ),
        Text(company,
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            )),
        Text(duration, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 5),
        ...responsibilities.map((r) => Text('• $r')),
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
