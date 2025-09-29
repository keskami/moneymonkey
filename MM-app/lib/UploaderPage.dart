// import 'package:flutter/material.dart';
// import 'package:money_monkey/UploadScript.dart';

// class DataUploaderPage extends StatefulWidget {
//   const DataUploaderPage({Key? key}) : super(key: key);

//   @override
//   State<DataUploaderPage> createState() => _DataUploaderPageState();
// }

// class _DataUploaderPageState extends State<DataUploaderPage> {
//   bool _isUploading = false;
//   String _statusMessage = "Ready to upload";
//   List<String> _logMessages = [];
//   ScrollController _scrollController = ScrollController();

//   // Custom log function that will be passed to the uploader
//   void _logMessage(String message) {
//     setState(() {
//       _logMessages.add(message);
//     });
    
//     // Auto-scroll to the bottom of the log
//     Future.delayed(Duration(milliseconds: 50), () {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 200),
//           curve: Curves.easeOut,
//         );
//       }
//     });
    
//     // Also print to console for debugging
//     print(message);
//   }

//   Future<void> _uploadData() async {
//     if (_isUploading) return; // Prevent multiple uploads
    
//     setState(() {
//       _isUploading = true;
//       _statusMessage = "Uploading data to Firebase...";
//       _logMessages = ["Starting upload process..."];
//     });
    
//     try {
//       // Create a modified version of uploadDataToFirebase that accepts a logger
      
//       setState(() {
//         _statusMessage = "Upload completed successfully";
//         _logMessages.add("Upload process finished successfully!");
//       });
//     } catch (e) {
//       setState(() {
//         _statusMessage = "Error: $e";
//         _logMessages.add("ERROR: $e");
//       });
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Firebase Data Uploader'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Sample Data Uploader',
//                       style: Theme.of(context).textTheme.headlineSmall,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'This utility will upload all the sample data to Firebase Firestore.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         ElevatedButton(
//                           onPressed: _isUploading ? null : _uploadData,
//                           child: Text(_isUploading ? 'Uploading...' : 'Upload Data'),
//                         ),
//                         const SizedBox(width: 16),
//                         Text(
//                           _statusMessage,
//                           style: TextStyle(
//                             color: _statusMessage.contains('Error')
//                                 ? Colors.red
//                                 : _statusMessage.contains('completed')
//                                     ? Colors.green
//                                     : Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Upload Logs',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       const SizedBox(height: 8),
//                       Expanded(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           padding: const EdgeInsets.all(8),
//                           child: ListView.builder(
//                             controller: _scrollController,
//                             itemCount: _logMessages.length,
//                             itemBuilder: (context, index) {
//                               final message = _logMessages[index];
//                               Color textColor = Colors.white;
//                               if (message.contains("Error") ||
//                                   message.contains("ERROR")) {
//                                 textColor = Colors.red;
//                               } else if (message.contains("success")) {
//                                 textColor = Colors.green;
//                               }
//                               return Text(
//                                 message,
//                                 style: TextStyle(
//                                   color: textColor,
//                                   fontFamily: 'monospace',
//                                   fontSize: 12,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }