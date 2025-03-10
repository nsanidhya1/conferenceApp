import 'dart:async';
import 'dart:io'; // Required for exit(0)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart'; // Required for SystemNavigator.pop()

void main() {
  runApp(ConferenceApp());
}

class ConferenceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conference App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: IntroScreen(), // Start with Intro Screen
    );
  }
}

// INTRO SCREEN (Displays Logo for 2 Seconds)
class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Image.asset(
              'assets/logo.png', // Replace with your actual logo path
              fit: BoxFit.contain,
              height: 150, // Big logo
            ),
            SizedBox(height: 20), // Space between logo and text
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Ensure text stays within bounds
              child: Text(
                'Department of\nElectronics and Communication Engineering\nJaypee Institute of Information Technology, Noida\npresents',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14, /*fontWeight: FontWeight.bold*/
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HOME SCREEN

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imgList = [
    'assets/img_1.png',
    'assets/PXL_20231221_063223135.jpg',
    'assets/PXL_20231221_063610562.jpg',
    'assets/confimg.jpeg',
    'assets/img_2.png',
    'assets/img_3.png',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _currentPage = (_currentPage + 1) % imgList.length;
          _pageController.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          _startAutoPlay();
        });
      }
    });
  }

  void _showOutroScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OutroScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _showOutroScreen();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('ICSC 2025')),
        drawer: ConferenceDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.blue,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    '2025 10TH INTERNATIONAL CONFERENCE ON SIGNAL PROCESSING AND COMMUNICATION (ICSC)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF042B4A),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Department of Electronics and Communication Engineering, \n Jaypee Institute of Information Technology, Noida',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF042B4A),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '20th - 22nd February, 2025',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF042B4A),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: imgList.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    imgList[index],
                    fit: BoxFit.contain,
                    width: double.infinity,
                  );
                },
              ),
            ),
            Column(
              children: [
                Text(
                  'Brought to you by',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 5),
                Image.asset(
                  'assets/spon1.png',
                  fit: BoxFit.contain,
                  height: 50,
                ),
                SizedBox(height: 5),
                Image.asset(
                  'assets/spon2.png',
                  fit: BoxFit.contain,
                  height: 50,
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// OUTRO SCREEN (Displays Credit for 2 Seconds)
class OutroScreen extends StatefulWidget {
  @override
  _OutroScreenState createState() => _OutroScreenState();
}

class _OutroScreenState extends State<OutroScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      // Close the app after Outro
      if (Platform.isAndroid) {
        SystemNavigator.pop(); // Close app on Android
      } else if (Platform.isIOS) {
        exit(0); // Close app on iOS
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Designed and developed by \nSanidhya Nigam and Divyanshi Gupta.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 16), // Adds spacing between text boxes
            Text(
              '© 2025 All Rights Reserved, JIIT.',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class ConferenceDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Text(
              'Conference Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          _createDrawerItem(context, Icons.info, 'About Us', AboutUsScreen()),
          _createDrawerItem(context, Icons.message,
              'Message From General Chair', GeneralChairMessageScreen()),
          _createDrawerItem(context, Icons.person, 'Keynote Speakers',
              KeynoteSpeakersScreen()),
          _createDrawerItem(
              context, Icons.schedule, 'Schedule', ScheduleScreen()),
          _createDrawerItem(
              context, Icons.group, 'Committees', CommitteesScreen()),
          _createDrawerItem(context, Icons.app_registration, 'Registration',
              RegistrationScreen()),
          _createDrawerItem(context, Icons.book, 'For Authors',
              AuthorGuidelinesScreen()), // Updated this item
          _createDrawerItem(context, Icons.emoji_events, 'Awards',
              BestPaperAwardScreen()), // Updated this item
          _createDrawerItem(
              context, Icons.attach_money, 'Sponsorship', SponsorsScreen()),
          _createDrawerItem(
              context, Icons.contact_mail, 'Contact Us', ContactUsScreen()),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      BuildContext context, IconData icon, String title, Widget? screen) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      onTap: () {
        if (screen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        }
      },
    );
  }
}

class SponsorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sponsors'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Image.asset('assets/spon1.png',
                      height: 200, fit: BoxFit.contain),
                  SizedBox(height: 8),
                  Text('Sponsor 1',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Column(
                children: [
                  Image.asset('assets/spon2.png',
                      height: 200, fit: BoxFit.contain),
                  SizedBox(height: 8),
                  Text('Sponsor 2',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BestPaperAwardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ICSC 2025 Best Paper Award"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        // Added scroll view
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Best Paper Awards are presented at ICSC conferences to authors whose work represents groundbreaking research in their respective areas. By recognizing these select papers for their ingenuity and importance, ICSC highlights some of the theoretical and practical innovations that are likely to shape the future, especially in the areas of Signal Processing, Communication, Intelligent Computing, and Machine Learning, and VLSI Technology and Embedded Systems.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 20),
              Text(
                'The accepted works that are properly presented in the conference as per the guidelines of ICSC 2025 will only be considered for the "Best Paper Award".',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 30),
              Text(
                'Winners of ICSC 2023 "Best Paper Award":',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildAwardTrack(
                  'Communication',
                  '“An Array of Fibonacci Hexagon based Printed Radiators for Vehicular Communications”',
                  'Kalyan Sundar Kola, Anirban Chatterjee, Sandip Bhattacharya'),
              _buildAwardTrack(
                  'Signal Processing',
                  '“Throat microphone speech recognition in Hindi Language using Residual Convolutional Neural Network”',
                  'Raj Kumar, Manoj Tripathy, R S Anand, Niraj Kumar'),
              _buildAwardTrack(
                  'Intelligent Computing and Machine Learning',
                  '“Road detection from Remote Sensing Images using Machine Learning”',
                  'Pruthvirajsinh Anopsinh Kathiya, Kashyap Sindhav, Ruchi Gajjar'),
              _buildAwardTrack(
                  'VLSI Technology and Embedded Systems',
                  '“Modeling and Analysis of Step-down Switched Capacitor DC-DC Converter for SoC”',
                  'Sunita Saini'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAwardTrack(String track, String title, String authors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            track,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 5),
          Text(
            'Authors: $authors',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class ContactUsScreen extends StatelessWidget {
  // URL to open
  //final String _url = 'https://maps.app.goo.gl/YWqyd7BwndUjKTjG7';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            'Prof. Sajai Vir Singh',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Department of Electronics & Communication Engineering\n\nJaypee Institute of Information Technology',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 5),
          SizedBox(height: 5),
          Text(
            'Noida, Uttar Pradesh, India',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Text(
            'Email: sajaivir.singh@jiit.ac.in',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            'Phone: (+91)-120-4195873 (Office), (+91)- 98993 49350 (Mobile)',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 30),
          Text(
            'Venue:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => _launchURL(context), // Pass context for SnackBar
            child: Text(
              'Jaypee Institute of Information Technology',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue, // Blue color for the link
                decoration: TextDecoration.underline, // Underline the text
              ),
            ),
          ),
          Text(
            '10, Block A, Sector 62, Noida - 201309',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Text(
            'How to reach:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Metro: The nearest metro station is NOIDA ELECTRONIC CITY. The institute is situated at a walking distance from the metro station.',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Text(
            'Railway: Noida is well connected to the New Delhi, Old Delhi, and Ghaziabad railway stations by bus. Cabs can be hired just outside the railway stations.',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Text(
            'Airport: Cabs can be hired just outside the airport terminal for JIIT Sector‐62, Noida.',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  // Function to launch the URL
  void _launchURL(BuildContext context) async {
    final Uri _url = Uri.parse(
        'https://maps.app.goo.gl/YWqyd7BwndUjKTjG7'); // Ensure this is a Uri

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      // Show a SnackBar if the URL cannot be launched
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $_url'),
        ),
      );
    }
  }
}

class AuthorGuidelinesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call For Papers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Author Guidelines',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '1. Originality:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Ensure that your paper presents original research that has not been previously published or is not currently under review elsewhere. Properly attribute and cite any prior work or sources you use.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '2. Relevance:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Align your paper with the conference\'s scope and theme. Ensure that your research is relevant to the field covered by the conference and contributes to the existing body of knowledge.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '3. Clarity and Organization:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Clearly articulate your ideas and findings. Organize your paper in a logical manner, including appropriate sections such as introduction, methodology, results, discussion, and conclusion. Use headings and subheadings to enhance readability.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '4. Language and Grammar:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Write your paper in clear and concise language, ensuring that it is grammatically correct. Use appropriate technical terminology and define any specialized terms or acronyms used.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '5. Figures and Tables:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Use figures, graphs, and tables to enhance the understanding of your research findings. Ensure that all visuals are clear, labeled, and referenced appropriately within the text.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '6. Citations and References:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Cite relevant works accurately and provide a comprehensive list of references at the end of your paper. Follow the IEEE citation style guidelines for consistency and proper attribution.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '7. Results and Analysis:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Present your research results in a clear and transparent manner. Provide appropriate statistical analysis and interpretation of the findings. Discuss the significance and implications of your results.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '8. Ethical Considerations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Adhere to ethical standards in conducting and reporting your research. Ensure that any experiments involving human subjects or sensitive data comply with ethical guidelines and have appropriate approvals.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '9. Peer Review:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Be prepared for a peer review process, where experts in your field will review your paper. Address any reviewer comments or suggestions constructively and thoroughly revise your paper as needed.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '10. Submission Deadline:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Submit your paper before the specified deadline. Late submissions are typically not accepted.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '11. Presentation:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'If your paper is accepted, prepare a clear and engaging presentation to deliver at the conference. Practice your presentation beforehand to ensure that you can effectively communicate your research.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '\nInstructions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '1. Paper Formatting: Follow the formatting guidelines provided by the conference. Use the provided template or style file to ensure consistency. https://www.ieee.org/conferences/publishing/templates.html',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '2. Paper Length: Pay attention to the specified page limit for your paper. Ensure that your submission adheres to the required length, including all figures, tables, and references.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '3. Title and Abstract: Provide a clear and concise title that accurately reflects the content of your paper. Write an informative abstract that summarizes the objectives, methods, and key findings of your research.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '4. Introduction: Begin your paper with an introduction that clearly presents the motivation, problem statement, and objectives of your research. Provide sufficient background information to help readers understand the context of your work.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '5. Methods and Materials: Describe the methodology, algorithms, or techniques used in your research. Provide enough detail to allow readers to understand and potentially replicate your work. If applicable, include information about the datasets, hardware, or software used.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '6. Results and Analysis: Present your results in a clear and organized manner. Use tables, figures, and graphs to illustrate your findings. Provide a detailed analysis and interpretation of the results, highlighting their significance and relevance.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '7. Discussion and Conclusion: Discuss the implications of your results and their significance in relation to the research objectives. Address any limitations or challenges encountered during your study. Summarize your main findings and state your conclusions.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '8. References: Include a list of all references cited in your paper. Follow the IEEE citation style guidelines for formatting your references. Ensure that all cited works are accurately and consistently cited within the text.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '9. Plagiarism and Originality: Ensure that your paper is original and does not contain any plagiarized content. Cite and attribute all relevant sources appropriately. Plagiarism in any form is strictly prohibited and can lead to the rejection of your paper.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '10. Submission Process: Follow the instructions provided by the conference for paper submission. This usually involves submitting your paper through an online submission system. Make sure to meet the specified submission deadline.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '11. Peer Review Process: Be aware that your paper will undergo a peer review process. Reviewers will evaluate the quality, relevance, and novelty of your work. Address any reviewer comments and revise your paper accordingly before the final submission deadline.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '12. Presentation: If your paper is accepted, prepare a clear and engaging presentation to deliver at the conference. Follow any guidelines or instructions provided by the conference organizers regarding presentation format and duration.',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '\nScope',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Authors are invited to submit original unpublished research work that demonstrates the recent advances in the following areas of interest, but are not limited to:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'COMMUNICATION \n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '• 5G Technology and Implementations\n'
              '• 5G-Broadband, and Low Latency Solutions\n'
              '• Adaptive Antennas for Wireless Systems\n'
              '• Beamforming Technologies\n'
              '• Cognitive and Software-Defined Radio\n'
              '• Cooperative Communication\n'
              '• Cryptography, Security and Privacy algorithms\n'
              '• Energy Efficient Protocol and Routing\n'
              '• Energy Harvesting Communication Systems\n'
              '• Femtocells\n'
              '• Free Space Optics Communication\n'
              '• Full Duplex Systems\n'
              '• Heterogeneous Cellular Networks\n'
              '• Internet-of-Things / Devices\n'
              '• Large Scale Massive MIMO Systems\n'
              '• Link and System Capacity\n'
              '• Location Estimation and Tracking\n'
              '• Millimeter Wave Communication\n'
              '• MIMO and Multi Antenna Communications\n'
              '• Modelling, Estimation and Equalization of Wireless Channels\n'
              '• Multiuser Detection\n'
              '• Network Information and Coding Theory\n'
              '• OFDM and CDMA Technologies and Systems\n'
              '• Optical, Satellite and Underwater Communications\n'
              '• Resource Allocation and Interference Management\n'
              '• Security and Privacy in Wireless Technologies and Applications\n'
              '• Signal Separation and Interference Rejection\n'
              '• Small Cells and Multi-tier Networks\n'
              '• Smart Grid Communications\n'
              '• Traffic Analysis\n'
              '• V2V, M2M and D2D communications\n'
              '• Vehicular Wireless Networks\n'
              '• Virtualization in Wireless Networks\n'
              '• Wireless Body Area Networks\n'
              '• Green Communication for Next-Generation Wireless Systems\n'
              '• Hybrid Wireless Communication Systems\n'
              '• Radio over Fiber(ROF) and FSO',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'SIGNAL PROCESSING\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '• Signal processing for Finance\n'
              '• Bioinformatics and Genomics\n'
              '• Compressed Sensing and Sparse Modeling\n'
              '• Computational Imaging/ Spectral Imaging\n'
              '• Design/Implementation of Signal Processing Systems\n'
              '• DSP Algorithms and Architecture\n'
              '• Image/Video Processing & Data Compression\n'
              '• Image Forensics\n'
              '• Information Forensics and Security\n'
              '• Multimedia Signal Processing\n'
              '• Nonlinear Signal Processing\n'
              '• Optimization Techniques\n'
              '• Pattern Analysis and Classification\n'
              '• Radar and Sonar Signal Processing\n'
              '• Sensor Array and Multichannel Signal Processing\n'
              '• Signal Processing for Big Data\n'
              '• Signal Processing for Communications\n'
              '• Signal Processing for Computer Vision and Robotics\n'
              '• Signal Processing for Education\n'
              '• Signal Processing for Power Systems\n'
              '• Signal Processing for the Internet of Things\n'
              '• Signal Processing for VLSI\n'
              '• Signal Processing Over Graphs and Networks\n'
              '• Signal Processing Theory and Methods\n'
              '• Speech and Language Processing\n'
              '• Statistical Signal Processing',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'VLSI Technology and Embedded Systems\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '• Analog and Mixed Signal Circuits and Systems\n'
              '• Applications of Embedded for IoT, Biometric, and Signal Processing\n'
              '• Circuit Reliability and Fault Tolerance\n'
              '• Computer Aided Designs and Verifications\n'
              '• Device Technology, Modeling and Simulation\n'
              '• Digital Circuits and FPGA based Designs\n'
              '• Electric Vehicles and Future Prospects\n'
              '• Electronic Devices in Environmental Monitoring and Prediction\n'
              '• Electronic Waste Recovery and Reuse\n'
              '• Electronics and Optics based Material and Devices\n'
              '• Embedded for AI, ML, and Future based Technologies\n'
              '• Emerging and post-CMOS Technologies\n'
              '• Flexible, Wearable Electronics and Sensors\n'
              '• Memory Circuits and System Design\n'
              '• MEMS/NEMS Devices and its Applications\n'
              '• Nanophotonic and Nanoelectronics-Emerging Hybrid Platform, Materials and Functions\n'
              '• Physical Design and Verification\n'
              '• Radio Frequency based ICs and its Applications\n'
              '• Recent Trends in Drone and Robotic Technology\n'
              '• Semiconducting Electronic Material and Devices- Applications in Energy, Storage and Conversion\n'
              '• Sustainable Electronic Product Design\n'
              '• VLSI for Biomedical Signal Processing',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Intelligent Computing and Machine Learning\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '• Architectures and platforms for blockchain\n'
              '• Blockchain for Big Data\n'
              '• Blockchain Multi-Agent systems\n'
              '• Blockchain for Internet of Things\n'
              '• Blockchain in 5G\n'
              '• Block chain and Crypto Currency\n'
              '• AI and Evolutionary Algorithms\n'
              '• Algorithms and Programming\n'
              '• Algorithms and Systems for Big Data Search\n'
              '• Analytics Reasoning and Sense-making on Big Data\n'
              '• Artificial Intelligence with Internet of Things\n'
              '• Artificial Intelligence with Natural Language Processing and Fuzzy Systems\n'
              '• Artificial Neural Networks and Convolution Neural Networks\n'
              '• Big Data Analytics and Metrics\n'
              '• Big Data Architectures\n'
              '• Big Data Management\n'
              '• Big Data Models and Algorithms\n'
              '• Big Data Protection, Integrity and Privacy\n'
              '• Big Data Quality and Provenance Control\n'
              '• Big Data Search and Mining\n'
              '• Big Data Transformation and Presentation\n'
              '• Deep and Reinforcement Learning\n'
              '• Deep Learning with Cyber Security\n'
              '• Decision Support Systems\n'
              '• Distributed and Decentralized Machine Learning Algorithms\n'
              '• Experimental Evaluations of Machine Learning New Innovative Machine Learning Methods\n'
              '• Intelligent Information Systems\n'
              '• Intelligent Networks\n'
              '• Intelligent Tutoring Systems\n'
              '• Intelligent Data Mining and Farming\n'
              '• Machine Learning for 5G System\n'
              '• Machine Learning for Internet of Things\n'
              '• Machine Learning for Multimedia\n'
              '• Machine Learning for Network Slicing Optimization\n'
              '• Machine Learning for Security and Protection\n'
              '• Machine Learning for User Behavior Prediction\n'
              '• Optimization of Machine Learning Methods\n'
              '• Performance Analysis of Machine Learning Algorithms\n'
              '• Software Tools for AI',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Papers will be reviewed by renowned experts in their field and those selected will be called for presentation and inclusion in the conference proceeding based on their clarity, originality, relevance and significance.',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Registration Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'At least one author of every accepted paper is mandatorily required to register before the given deadline. Any one author or co-author may present the paper at the conference. The certificate of presentation will be issued in the name of the presenting author only. Accepted papers will be submitted for inclusion into IEEE Xplore subject to meeting IEEE Xplore’s scope and quality requirements.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Registration Fees:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            //
            SizedBox(height: 10),
            Text(
              'Authors:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Academicians/R&D Professional: INR 8000 (IEEE Member) | INR 10000 (Non-IEEE Member) | USD 280 (IEEE Member) | USD 350 (Non-IEEE Member)',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Students: INR 4500 (IEEE Member) | INR 5500 (Non-IEEE Member) | USD 140 (IEEE Member) | USD 175 (Non-IEEE Member)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Co-Authors (If main author is already registered and Co-Author also wants to register):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Academicians/R&D Professional: INR 4000 (IEEE Member) | INR 4800 (Non-IEEE Member) | USD 175 (IEEE Member) | USD 200 (Non-IEEE Member)',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Students: INR 2500 (IEEE Member) | INR 3000 (Non-IEEE Member) | USD 110 (IEEE Member) | USD 140 (Non-IEEE Member)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Non-Author Participants:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Academicians/R&D Professionals (3 Days Registration): INR 3000 (IEEE Member) | INR 4000 (Non-IEEE Member)',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Academicians/R&D Professionals (1 Day Registration): INR 2000 (IEEE Member) | INR 2500 (Non-IEEE Member)',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Students (3 Days Registration): INR 2500 (IEEE Member) | INR 3500 (Non-IEEE Member)',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Students (1 Day Registration): INR 2000 (IEEE Member) | INR 3000 (Non-IEEE Member)',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Industry: INR 12000 (Non-IEEE Member)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Registration Instructions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '• Kindly download and fill the Registration Form and complete your registration through Register Now, irrespective of the mode of payment.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Kindly ensure that the Remitter\'s (Participant/Author) name and the Purpose of remittance (Registration Fees) are clearly mentioned by the Remitter in the Funds Transfer Application.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Authors claiming discounted registration fee must produce valid proof for availing the discounted fee (copy of student matriculation card, IEEE membership card must be submitted).',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Papers must be strictly checked through IEEE PDF express (Conference ID: 64553). Final paper checked through IEEE pdf express must be uploaded through the Link.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• The electronic IEEE Copyright Form (eCF) will be used to transfer the copyright to IEEE. The corresponding author/registered author will receive the link of eCF on the registered email ID.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'For any query/help regarding registration, please feel free to contact Dr. Rahul Kaushik at rahul.kaushik@jiit.ac.in',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Additional Instructions for Co-Authors/Non-Author participants:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '• In a paper with more than one author, all authors cannot register as "Co-Authors".',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• One of the authors must pay full registration fee, while others can avail Co-Author discount.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Co-Author registration discount can be availed only after one of the authors has successfully registered with full registration fee.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Co-Authors who wish to avail registration discount have to compulsorily indicate fee payment details of the first author.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Other interested participants can also attend the conference by registering under separate category of non-author participants.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Co-Authors/Non-Author participants claiming discounted registration fee must produce valid proof for availing the discounted fee (copy of student matriculation card, IEEE membership card must be submitted).',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Payment Modes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Indian Participants: Please pay through QR code below.\n',
              style: TextStyle(fontSize: 16),
            ),
            Image.asset(
              'assets/qrc.png', // Ensure that the image path is correct
              height: 150, // Adjust the size as needed
            ),
            SizedBox(height: 10),
            Text(
              '\n 2. Foreign participants: Please pay through Wire Transfer.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'The Participants/Authors can pay the registration fee through Fund Transfer. The Fund Transfer must be made to the following Account details:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '• Correspondent Bank Name: CITI BANK NEW YORK, USA',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Swift Code: CITIUS33XXX',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• IDBI Bank Swift Code: IBKLINBB010',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Beneficiary Name: Jaypee Institute of Information Technology',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Account No.: 0200104000323550 (IDBI Bank Ltd., Sector-63, Noida, U.P., India)',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Purpose: Educational Fees (Mention Student\'s name, Father\'s name and Remitter\'s name)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Note:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '• Swift Copy (Wire transfer advice/MT103) should be sent by email at fees@jiit.ac.in with a copy to icsc@jiit.ac.in for information of the Institute.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• All banks charges in foreign and in India, in connection with the remittance will be charged to the account of the Remitter. Any shortage in the prescribed fees amount, on account of bank charges credited to the Institute’s A/c shall be borne by the remitter.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class CommitteesScreen extends StatelessWidget {
  final List<String> committees = [
    'Advisory Committee',
    'Organising Committee',
    'Track Chair/TPC',
    'Session Chair'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Committees'),
      ),
      body: ListView.builder(
        itemCount: committees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              committees[index],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to a committee details screen or show more info
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CommitteeDetailScreen(committeeName: committees[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CommitteeDetailScreen extends StatelessWidget {
  final String committeeName;

  CommitteeDetailScreen({required this.committeeName});

  // Function to launch URLs
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Committees data
    final Map<String, List<String>> committeeMembers = {
      'Advisory Committee': [
        'Prof. George K. Karagiannidis, Aristotle University of Thessaloniki, Greece\n',
        'Prof. Carlos M. Travieso-González, University of Las Palmas de Gran Canaria, SPAIN\n',
        'Prof. Ram M. Narayanan, The Pennsylvania State University, USA\n',
        'Prof. Banmali S. Rawat, University of Nevada, Reno, USA\n',
        'Prof. Satish K. Sharma, San Diego State University, California, USA\n',
        'Prof. Tawfik Ismail, Cairo University, Egypt\n',
        'Prof. Ramesh Bansal, University of Sharjah, UAE\n',
        'Prof. Arun Kumar, IIT Delhi, India\n',
        'Prof. V. Ramgopal Rao, VC, BITS Pilani, India\n',
        'Prof. Hariom Gupta, IIT Roorkee, India\n',
        'Prof. Asheesh Kumar Singh, MNNIT, Prayagraj, India\n',
        'Prof. Sudhanshu Maheshwari, AMU, Aligarh, India\n',
        'Prof. Omar Farooq, AMU, Aligarh, India\n',
        'Prof. Manish Goswami, IIIT Allahabad, India\n',
        'Prof. Satish Kumar Singh, IIIT Allahabad, India\n',
        'Dr. Rajiv Mathur, Principal Consulting Partner, Wipro Consulting, California, USA\n',
        'Dr. Amit Sachan, VP, JIO, India\n'
      ],
      'Organising Committee': [
        'General Chair\n Prof. Shweta Srivastava, JIIT Noida',
        'Organizing Secretary\n Prof. Sajai Vir Singh, JIIT Noida',
        'Co-organizing Secretary:\n Prof. Vineet Khandelwal, JIIT Noida',
        'Publication Chairs:\n Prof. Jitendra Mohan, JIIT Noida',
        'Prof. Jasmine Saini, JIIT Noida',
        '\nMembers\n',
        'Abhay Kumar\n',
        'Ajay Kumar\n',
        'Archana Pandey\n',
        'Atul Kumar\n',
        'Bajrang Bansal\n',
        'Chandan Kumar\n',
        'Gaurav Khanna\n',
        'Abhijeet Upadhya\n',
        'Alok Joshi\n',
        'Ashish Goel\n',
        'Atul Kumar Srivastava\n',
        'Bhartendu Chaturvedi\n',
        'Divya Kaushik\n',
        'Gaurav Verma\n',
        'Jasmine Saini\n',
        'Jitendra Mohan\n',
        'Juhi Gupta\n',
        'Madhu Jain\n',
        'Kapil Dev Tyagi\n',
        'Madhu Jhariya\n',
        'Megha Agarwal\n',
        'Niraj Kumar\n',
        'Nitin Muchhal\n',
        'Pimmy Gandotra\n',
        'Rachna Singh\n',
        'Rahul Kumar\n',
        'Nisha Venkatech\n',
        'Pankaj Kumar Yadav\n',
        'Pranhakarha\n',
        'Raghvenda Kumar Singh\n',
        'Reema Budhiraja\n',
        'Rishibrind Kumar Upadhyay\n',
        'Ritesh Kumar Sharma\n',
        'Ruby Beniwal\n',
        'Satya Narayan Patel\n',
        'Sajai Vir Singh\n',
        'Satvendra Kumar\n',
        'Shamim Akhter\n',
        'Shradna Sayana\n',
        'Shwetabh Singh\n',
        'Vimal Kumar Mishra\n',
        'Vineet Khandelwal\n',
        'Shivajl Tyagi\n',
        'Shruti Kalra\n',
        'Smriti Bhatnagar\n',
        'Vijay Khare\n',
        'Vishal Narain Saxena\n',
        'Yogesh Kumai\n'
      ],
      'Track Chair/TPC': [
        'Communication:\n- Chair: Prof. Ghanshyam Singh, MNIT Jaipur, India\n- Co-Chair: Prof. Ashish Goel, JIIT Noida, India\n\n',
        'Signal Processing:\n- Chair: Prof. Ram Bilas Pachori, IIT Indore, India\n- Co-Chair: Prof. Megha Agarwal, JIIT Noida, India\n\n',
        'VLSI Technology & Embedded Systems:\n- Chair: Prof. Sudeb Dasgupta, IIT Roorkee, India\n- Co-Chair: Dr. Vimal Kumar Mishra, JIIT Noida, India\n\n',
        'Intelligent Computing and Machine Learning:\n- Chair: Prof. Karm Veer Arya, ABV-IIITM, Gwalior, India\n- Co-Chair: Prof. Vijay Khare, JIIT Noida, India',
        "\n\n TPC: \n\nDr. Shailesh Kumar, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Shamim Akhter, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Shardha Porwal, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Sheeja Francis, Jerusalem College of Engineering, Chennai, India\n\n Dr. Shefali Sharma, Jaypee University of Engineering and Technology, Guna, India\n\n Dr. Shelly Sachdeva, National Institute of Technology, Delhi, India\n\n Dr. Shikha Jain, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Shikha Mehta, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Shilpi Lavania, Institute of Engineering & Technology, Khandari Campus, Agra, India\n\n Dr. Shiv Gupta, Greater Noida Institute of Technology, Greater Noida, India\n\n Dr. Shiv Shivhare, Bennett University, Greater Noida, India\n\n Dr. Shivani, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Shradha Saxena, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Shruti Gupta, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Shruti Jain, Jaypee University of Information Technology, Waknaghat, Solan, India\n\n Dr. Shruti Jaiswal, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Shruti Kalra, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Shubhankar Majumdar, National Institute of Technology, Meghalaya, India\n\n Dr. Shweta Pandit, Jaypee University of Information Technology, Noida, India\n\n Dr. Shweta Rani, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Somya Jain, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Sonal Singhal, Shiv Nadar University, Greater Noida, India\n\n Dr. Sonal Tuteja, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Sonam Gupta, Ajay Kumar Garg Engineering College, Ghaziabad, India\n\n Dr. Subir Sarkar, Jadavpur University, Kolkata, India\n\n Dr. Subodh Singhal, Jaypee University of Engineering and Technology, Noida, India\n\n Dr. Sumit Kumar, Symbiosis Institute of Technology, Pune, India\n\n Dr. Sunildatt Sharma, Jaypee University of Engineering and Technology, Guna, India\n\n Dr. Surya Singh, Rajkiya Engineering College, Ambedkar Nagar, India\n\n Dr. Taj Alam, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Tajinder Arora, Aligarh Muslim University, Aligarh, India\n\n Dr. Tanmai Kulshreshtha, Pranveer Singh Institute of Technology, Kanpur, India\n\n Dr. Tanupriya Choudhury, Symbiosis International University, Pune, India\n\n Dr. Tarun Agrawal, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Tarun Rawat, Netaji Subhas Institute of Technology, Delhi, India\n\n Dr. Thangalakshmi S, Indian Maritime University Chennai Campus, Chennai, India\n\n Dr. Thipendra P Singh, Bennett University, Greater Noida, India\n\n Dr. Tribhuwan Tewari, Jaypee Institute of Information Technology, Noida, India\n\n Dr. V Koushick, Vel Tech Rangarajan Dr Sagunthala R&D Institute of Science and Technology, Chennai, India\n\n Dr. Vandana Roy, Gyan Ganga Institute of Technology & Sciences, Jabalpur, India\n\n Dr. Varsha Garg, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Vartika Puri, Jaypee Institute of Information and Technology, Noida, India\n\n Dr. Varun Srivastava, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Vedvyas Dwivedi, Indus University, Ahmedabad, India\n\n Dr. Vijay Khare, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Vikas Baghel, Jaypee University of Information Technology, Waknaghat, Solan, India\n\n Dr. Vikas Goel, Krishna Institute of Engineering and Technology, Ghazibad, India\n\n Dr. Vikash, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Vimal Mishra, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Vinay Mittal, Koneru Lakshmaiah University, Vijayawada, India\n\n Dr. Vinay Tikkiwal, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Vipin Balyan, Cape Peninsula University of Technology, South Africa\n\n Dr. Virendra P. Vishwakarma, Guru Gobind Singh Indraprastha University, Delhi, India\n\n Dr. Vishal Saxena, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Vishnu Sharma, Galgotia College, Greater Noida, India\n\n Dr. Viswas Sadasivan, Amrita Vishwa Vidyapeetham, Amritapuri, India\n\n Dr. Vivek Dwivedi, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Vivek Singh, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Vivekanand Mishra, Sardar Vallabhbhai Patel National Institute of Technology, Surat, India\n\n Dr. Wriddhi Bhowmik, Kalinga Institute of Industrial Technology, Bhubaneswar, India\n\n Dr. Yogesh Chauhan, Gautam Buddha University, Greater Noida, India\n\n Dr. Yogesh Kumar, Jaypee Institute of Information Technology, Noida, India\n\n Dr. Yudhishthir Pandey, Rajkiya Engineering College, Ambedkar Nagar, India\n\n Dr. Yugal Kumar, Jaypee University of Information Technology, Waknaghat, Solan, India\n\n Dr. Yugnanda Malhotra, Bharati Vidyapeeth College of Engineering, New Delhi, India\n\n"
      ],
      'Session Chair': [
        'Dr. Satyanand Singh\n'
            'Associate Professor,\n'
            'College of Engineering, Science & Technology, Fiji National University\n\n'
            'Prof. Bhaskar Gupta\n'
            'Professor, Chandigarh College of Engineering and Technology, Chandigarh\n\n'
            'Prof. Basant Kumar\n'
            'Professor, NIT Allahabad\n\n'
            'Dr. Vipin Balyan\n'
            'Associate Professor, Cape Peninsula University of Technology, South Africa\n\n'
            'Prof. D. S. Saini\n'
            'Professor, Chandigarh College of Engineering and Technology\n\n'
            'Prof. Kaushik Rai\n'
            'Professor, West Bengal State University, Ph.D. (Engg)\n\n'
            'Prof. Manish Goswami\n'
            'Professor, IIIT Allahabad\n\n'
            'Prof. Vishal Bhatnagar\n'
            'Professor, NSUT, Delhi\n\n'
            'Dr. Anuradha Pughat\n'
            'Scientist, Department of Science and Technology, Delhi\n\n'
            'Prof. N. S. Beniwal\n'
            'Professor, BIET Jhansi\n\n'
            'Prof. Ashish Srivastava\n'
            'Professor, SKILL FACULTY OF ENGINEERING & TECHNOLOGY, Shri Vishwakarma Skill University\n\n'
            'Dr. Pushpendra Kumar\n'
            'Associate Professor, JNU Delhi\n\n'
            'Prof. Thipendra P. Singh\n'
            'Professor, Dean Academic Affairs, Bennet University, Greater Noida\n\n'
            'Prof. Rajesh Kumar Dubey\n'
            'Professor, Department of Electrical Engineering,\n'
            'School of Engineering & Technology, Central University of Haryana, Mahendergarh 123031\n\n'
            'Dr. Abhinav Gupta\n'
            'Senior Vice President, NatWest Group India, NatWest Digital Services India Pvt. Ltd.\n\n'
            'Prof. Virendra P. Vishwakarma\n'
            'Professor, University School of Information, Communication & Technology,\n'
            'Guru Gobind Singh Indraprastha University, Sector 16-C, Dwarka, New Delhi-110078\n\n'
            'Prof. Divakar Yadav\n'
            'Professor, Indira Gandhi National Open University (IGNOU)\n\n'
            'Prof. Vinod Kumar Yadav\n'
            'Professor, Department of Electrical Engineering,\n'
            'Delhi Technological University (DTU), Shahbad Daulatpur, Main Bawana Road, Delhi-110042, India\n\n'
            'Prof. Nidhi Goel\n'
            'Professor, Indira Gandhi Delhi Technical University For Women (IGDTUW)\n\n'
            'Prof. Arun Sharma\n'
            'Professor, Dean (Academic Affairs), Department of IT\n'
            'Managing Director - IGDTUW Anveshan Foundation\n'
            'Coordinator - CoE (AI), funded by DST, GoI\n'
            'Indira Gandhi Delhi Technical University for Women (IGDTUW)\n\n'
            'Dr. Krishna Singh\n'
            'Associate Professor, Delhi Skill and Entrepreneurship University\n\n'
            'Dr. Manoj Kumar Mukul\n'
            'Associate Professor, Department of Electronic Science, University of Delhi, New Delhi\n\n'
            'Dr. Shelly Sachdeva\n'
            'Associate Professor, NIT Delhi\n\n'
            'Prof. Arti Noor\n'
            'Dean and Professor, JIIT Noida\n\n'
            'Prof. Bhagwati Prasad Chamola\n'
            'Professor, JIIT Noida\n\n'
            'Prof. R. K. Dwivedi\n'
            'Professor, JIIT Noida\n\n'
            'Prof. Alka Tripathi\n'
            'Professor & Head, JIIT Noida\n\n'
            'Prof. Anirban Pathak\n'
            'Professor, JIIT Noida\n\n'
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(committeeName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: committeeMembers[committeeName]?.length ?? 0,
          itemBuilder: (context, index) {
            bool isHighlighted = committeeName == 'Organising Committee' &&
                index < 6; // Highlight only the first four members

            String member = committeeMembers[committeeName]![index];
            String url = '';

            // Define URLs for specific members
            if (member.contains('Prof. Shweta Srivastava')) {
              url =
                  'https://www.jiit.ac.in/prof-shweta-srivastava'; // Replace with actual URL
            } else if (member.contains('Prof. Sajai Vir Singh')) {
              url =
                  'https://www.jiit.ac.in/prof-sajai-vir-singh'; // Replace with actual URL
            } else if (member.contains('Prof. Vineet Khandelwal')) {
              url =
                  'https://www.jiit.ac.in/prof-vineet-khandelwal'; // Replace with actual URL
            } else if (member.contains('Prof. Jitendra Mohan')) {
              url =
                  'https://www.jiit.ac.in/prof-jitendra-mohan'; // Replace with actual URL
            } else if (member.contains('Prof. Jasmine Saini')) {
              url =
                  'https://www.jiit.ac.in/prof-jasmine-saini'; // Replace with actual URL
            }

            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: isHighlighted
                      ? 6
                      : 1), // Increased spacing for highlighted members
              child: GestureDetector(
                onTap: url.isNotEmpty ? () => _launchURL(url) : null,
                child: Text(
                  member,
                  textAlign: TextAlign.center, // Center align the text
                  style: TextStyle(
                    fontSize: isHighlighted ? 18 : 16,
                    fontWeight:
                        isHighlighted ? FontWeight.bold : FontWeight.normal,
                    color: url.isNotEmpty
                        ? Colors.blue
                        : Colors
                            .black, // Change color to blue if URL is present
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 30.0), // Add horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16, color: Colors.black), // Default text style
                children: [
                  TextSpan(
                    text: 'The ',
                  ),
                  TextSpan(
                    text:
                        'Department of Electronics and Communication Engineering (ECE)',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue), // Highlighted text style
                  ),
                  TextSpan(
                    text:
                        ' at the Jaypee Institute of Information Technology (JIIT) is proud to host the 10th International Conference on Signal Processing and Communication (ICSC 2025). As a leading academic department, we are dedicated to promoting research, innovation, and knowledge exchange in the field of electrical and computer engineering.',
                  ),
                ],
              ),
              textAlign: TextAlign.justify, // Justify text
            ),
            SizedBox(height: 20),
            Text(
              'At JIIT\'s ECE Department, we take pride in our world-class faculty members who are renowned experts in their respective fields. They bring a wealth of knowledge, expertise, and research experience to the department. Our faculty members actively engage in cutting-edge research in areas such as signal processing, communications, image and video processing, machine learning, and wireless networks, among others. Their research contributions have been published in prestigious international journals and presented at renowned conferences.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify, // Justify text
            ),
            SizedBox(height: 20),
            Text(
              'We believe in nurturing the next generation of engineering professionals through a holistic approach to education. Our curriculum is designed to provide a strong foundation in electrical and computer engineering principles while incorporating the latest advancements in the field. Students at our department have access to state-of-the-art laboratories and facilities, enabling hands-on experiences in designing and implementing signal processing and communication systems. Through practical projects, internships, and industry collaborations, we ensure that our students develop essential skills that are in high demand in the industry.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify, // Justify text
            ),
            SizedBox(height: 20),
            Text(
              'ICSC 2025 serves as an excellent platform for researchers, academicians, and industry professionals from around the globe to exchange ideas, discuss emerging trends, and showcase innovative research outcomes. The conference will feature keynote lectures by distinguished experts in the field, paper presentations, and interactive sessions, facilitating knowledge dissemination and fostering collaborations. Participants will have the opportunity to explore the latest advancements in signal processing and communication technologies, engage in insightful discussions, and establish valuable connections with fellow researchers and industry professionals.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify, // Justify text
            ),
            SizedBox(height: 20),
            Text(
              'As the host of ICSC 2025, the ECE Department at JIIT is committed to ensuring a successful and impactful conference. We have assembled a dedicated organizing committee that will work tirelessly to curate a rich and diverse program. The conference will cover a wide range of topics including but not limited to digital signal processing, wireless communication, multimedia systems, network security, and machine learning for signal processing. We encourage researchers to submit their original research papers to contribute to the conference proceedings and share their findings with the international community.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify, // Justify text
            ),
            SizedBox(height: 20),
            Text(
              'We invite participants from academia, industry, and research organizations to join us at ICSC 2025 for an intellectually stimulating and enriching experience. With its beautiful campus, state-of-the-art facilities, and vibrant academic community, JIIT provides an ideal setting for fostering collaborations and advancing knowledge in the field of signal processing and communication.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify, // Justify text
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black), // Default text style for track headings
                children: [
                  TextSpan(
                    text: 'Tracks',
                    style: TextStyle(
                      fontSize: 22.0, // Increase font size
                      fontWeight: FontWeight.bold, // Bold text
                      decoration: TextDecoration.underline, // Underline text
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16, color: Colors.black), // Default text style
                children: [
                  TextSpan(
                    text: 'Track 1: Communication\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue), // Highlighted track heading style
                  ),
                  TextSpan(
                    text:
                        'The Communication track focuses on the latest developments in wireless communication, optical communication, satellite communication, mobile and cellular communication, network protocols, information theory, coding techniques, and cognitive radio. We welcome researchers and experts to submit their contributions and shed light on emerging trends and breakthroughs in communication technologies.',
                  ),
                ],
              ),
              textAlign: TextAlign.justify, // Justify text
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16, color: Colors.black), // Default text style
                children: [
                  TextSpan(
                    text: 'Track 2: Signal Processing\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue), // Highlighted track heading style
                  ),
                  TextSpan(
                    text:
                        'The Signal Processing track invites submissions on various topics such as digital signal processing, image and video processing, audio processing, biomedical signal processing, pattern recognition, signal analysis and modeling, signal compression and coding, and statistical signal processing. Researchers are encouraged to share their findings and innovations in these exciting areas.',
                  ),
                ],
              ),
              textAlign: TextAlign.justify, // Justify text
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16, color: Colors.black), // Default text style
                children: [
                  TextSpan(
                    text: 'Track 3: VLSI and Embedded Technology\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue), // Highlighted track heading style
                  ),
                  TextSpan(
                    text:
                        'The VLSI and Embedded Technology track provides a platform for researchers to showcase their work in VLSI design methodologies, system-on-chip (SoC) architectures, hardware-software co-design, low-power VLSI design, reconfigurable computing, embedded systems design, FPGA-based systems, and testing and verification of VLSI circuits. We invite scholars and professionals to present their novel approaches and advancements in this rapidly evolving field.',
                  ),
                ],
              ),
              textAlign: TextAlign.justify, // Justify text
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16, color: Colors.black), // Default text style
                children: [
                  TextSpan(
                    text:
                        'Track 4: Intelligent Computing and Machine Learning\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue), // Highlighted track heading style
                  ),
                  TextSpan(
                    text:
                        'The Intelligent Computing and Machine Learning track aims to gather cutting-edge research in artificial intelligence, machine learning algorithms and models, deep learning, natural language processing, data mining and knowledge discovery, intelligent systems and applications, swarm intelligence, and evolutionary computation.',
                  ),
                ],
              ),
              textAlign: TextAlign.justify, // Justify text
            ),
          ],
        ),
      ),
    );
  }
}

class GeneralChairMessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message From General Chair'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/img.png'),
            ),
            SizedBox(height: 10),
            Text(
              'Prof. Shweta Srivastava',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Dean (A&R)-II & HOD, ECE\nProfessor and Head\nGeneral Chair, ICSC 2025',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'On behalf of the organizing committee, it is my great pleasure to welcome you to the 10th IEEE International Conference on Signal Processing and Communication (ICSC 2025). This conference serves as a premier platform for researchers, practitioners, and industry experts to share their knowledge, insights, and advancements in the fields of signal processing and communication.\n\n'
                  'With an unwavering commitment to excellence, ICSC 2025 aims to foster collaborative discussions, promote innovation, and facilitate the exchange of ideas among participants from around the globe. The conference agenda has been meticulously designed to encompass a wide array of topics, including but not limited to signal processing algorithms, wireless communication systems, image and video processing, machine learning applications, VLSI, IOT and emerging technologies.\n\n'
                  'We are honored to have distinguished keynote speakers who are pioneers in their respective domains, ready to inspire us with their expertise and vision. In addition, a rich selection of technical sessions will provide valuable opportunities for in-depth exploration and interactive engagement.\n\n'
                  'I wholeheartedly encourage all participants to actively engage in the conference, seize the opportunity to learn from renowned experts, and contribute to the advancement of signal processing and communication. Let us embrace this occasion to exchange knowledge, inspire innovation, and shape the future of our field.\n\n'
                  'Once again, a warm welcome to ICSC 2025. I wish you all an enlightening, productive, and memorable experience.\n\n'
                  'Best regards,\n'
                  'Prof. Shweta Srivastava\n'
                  'General Chair, ICSC 2025',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KeynoteSpeakersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Keynote Speakers')),
      body: ListView(
        children: [
          _buildDayButton(context, 'Day 1',
              DaySpeakersScreen(day: 'Day 1', speakers: day1Speakers)),
          _buildDayButton(context, 'Day 2',
              DaySpeakersScreen(day: 'Day 2', speakers: day2Speakers)),
          _buildDayButton(context, 'Day 3',
              DaySpeakersScreen(day: 'Day 3', speakers: day3Speakers)),
        ],
      ),
    );
  }

  Widget _buildDayButton(BuildContext context, String day, Widget screen) {
    return ListTile(
      title: Text(day,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
    );
  }
}

class DaySpeakersScreen extends StatelessWidget {
  final String day;
  final List<Map<String, String>> speakers;

  DaySpeakersScreen({required this.day, required this.speakers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$day Speakers')),
      body: ListView.builder(
        itemCount: speakers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Large circular speaker image centered
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(speakers[index]['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Speaker Name
                Text(
                  speakers[index]['name']!,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),

                // Speaker University
                Text(
                  speakers[index]['university']!,
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),

                // Speaker Expertise
                Text(
                  'Expertise: ${speakers[index]['expertise']}',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),

                // Venue Information
                Text(
                  'Venue: ${speakers[index]['venue']}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                Divider(thickness: 2), // Separator for each speaker
              ],
            ),
          );
        },
      ),
    );
  }
}

// Speaker data categorized by days
final List<Map<String, String>> day1Speakers = [
  {
    'name': 'Dr. L Venkata Subramaniam',
    'university': 'IBM India',
    'image': 'assets/img_6.png',
    'expertise': 'Artificial Intelligence, Quantum AI/ML, Quantum Computing',
    'venue': 'LT4'
  },
  {
    'name': 'Prof. (Dr.) Bhim Singh',
    'university': 'IIT Delhi, SERB National Science Chair & Emeritus Professor',
    'image': 'assets/img_7.png',
    'expertise': 'Electrical Engineering, Power Systems, Energy Conversion',
    'venue': 'LT4'
  },
  {
    'name': 'Dr. Manish Kumar Hooda',
    'university': 'Director, Indian Semiconductor Mission, MeitY, India',
    'image': 'assets/img_8.png',
    'expertise': 'Semiconductor Technology, Chip Development',
    'venue': 'LT4 (Offline)'
  },
];

final List<Map<String, String>> day2Speakers = [
  {
    'name': 'Prof. Ananjan Basu',
    'university': 'IIT Delhi, Centre for Applied Research in Electronics',
    'image': 'assets/img_9.png',
    'expertise': 'Millimeter-wave Imaging, MEMS, Non-linear Circuits',
    'venue': 'LT4'
  },
  {
    'name': 'Prof. Ravinder Dahiya',
    'university': 'Northeastern University, USA',
    'image': 'assets/img_10.png',
    'expertise':
        'Flexible Printed Electronics, Robotics, Haptics, Interactive Systems',
    'venue': 'LT4 (Online)'
  },
];

final List<Map<String, String>> day3Speakers = [
  {
    'name': 'Dr. Surya Bhattacharya',
    'university': 'A*STAR Institute of Microelectronics (IME), Singapore',
    'image': 'assets/img_5.png',
    'expertise':
        'CMOS Scaling, Semiconductor Packaging, AI-driven Multi-Chiplet Integration',
    'venue': 'LT4 (Online)'
  },
];

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String selectedDay = 'Day 1';

  final Map<String, List<Map<String, String>>> scheduleData = {
    'Day 1': [
      {
        'time': '10:00 AM - 11:00 AM',
        'event': 'Inauguration',
        'venue': 'Main Hall'
      },
      {
        'time': '11:00 AM - 11:30 AM',
        'event': 'High Tea',
        'venue': 'Cafeteria'
      },
      {
        'time': '11:30 AM - 12:30 PM',
        'event': 'Keynote Talk 1 - Dr. L Venkata Subramaniam',
        'venue': 'LT4'
      },
      {
        'time': '12:30 PM - 1:45 PM',
        'event': 'Technical Session 1',
        'venue': 'G10, G11, G12'
      },
      {'time': '1:45 PM - 2:30 PM', 'event': 'Lunch', 'venue': 'Cafeteria'},
      {
        'time': '2:30 PM - 3:30 PM',
        'event': 'Keynote Talk 2 - Prof. (Dr.) Bhim Singh',
        'venue': 'LT4'
      },
      {'time': '3:30 PM - 3:45 PM', 'event': 'Tea Break', 'venue': 'Cafeteria'},
      {
        'time': '3:45 PM - 5:00 PM',
        'event': 'Technical Session 2',
        'venue': 'G10, G11, G12'
      },
    ],
    'Day 2': [
      {
        'time': '09:00 AM - 10:00 AM',
        'event': 'Keynote Talk 3 - Dr. Manish Kumar Hooda',
        'venue': 'LT4'
      },
      {
        'time': '10:00 AM - 10:15 AM',
        'event': 'High Tea',
        'venue': 'Cafeteria'
      },
      {
        'time': '10:15 AM - 11:15 AM',
        'event': 'Keynote Talk 4 - Prof. Ananjan Basu',
        'venue': 'LT4'
      },
      {
        'time': '11:15 AM - 12:30 PM',
        'event': 'Technical Session 3',
        'venue': 'G10, G11, G12'
      },
      {
        'time': '12:30 PM - 1:45 PM',
        'event': 'Technical Session 4',
        'venue': 'G10, G11, G12'
      },
      {'time': '1:45 PM - 2:30 PM', 'event': 'Lunch', 'venue': 'Cafeteria'},
      {
        'time': '2:30 PM - 4:00 PM',
        'event': 'Technical Session 5',
        'venue': 'G10, G11, G12'
      },
      {'time': '4:00 PM - 4:15 PM', 'event': 'Tea Break', 'venue': 'Cafeteria'},
      {
        'time': '5:30 PM - 6:30 PM',
        'event': 'Keynote Talk 5 - Prof. Ravinder Dahiya',
        'venue': 'LT4'
      },
    ],
    'Day 3': [
      {
        'time': '09:00 AM - 10:00 AM',
        'event': 'Technical Session 6',
        'venue': 'G10, G11, G12'
      },
      {
        'time': '10:00 AM - 10:15 AM',
        'event': 'High Tea',
        'venue': 'Cafeteria'
      },
      {
        'time': '10:15 AM - 11:15 AM',
        'event': 'Keynote Talk 6 - Dr. Surya Bhattacharya',
        'venue': 'LT4'
      },
      {
        'time': '11:15 AM - 12:30 PM',
        'event': 'Technical Session 7',
        'venue': 'G10, G11, G12'
      },
      {
        'time': '12:30 PM - 1:30 PM',
        'event': 'Valedictory Session',
        'venue': 'LT4'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conference Schedule')),
      body: Column(
        children: [
          // Day Selection Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedDay,
              items: scheduleData.keys.map((String day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                );
              }).toList(),
              onChanged: (String? newDay) {
                setState(() {
                  selectedDay = newDay!;
                });
              },
            ),
          ),

          // Table displaying schedule
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                border: TableBorder.all(width: 1, color: Colors.black),
                columns: [
                  DataColumn(
                      label: Text('Time',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Event',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Venue',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: scheduleData[selectedDay]!.map((event) {
                  return DataRow(cells: [
                    DataCell(Text(event['time']!)),
                    DataCell(Text(event['event']!)),
                    DataCell(Text(event['venue']!)),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
