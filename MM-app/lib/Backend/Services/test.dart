import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoneyMonkeyOpenAITest extends StatefulWidget {
  const MoneyMonkeyOpenAITest({Key? key}) : super(key: key);

  @override
  _MoneyMonkeyOpenAITestState createState() => _MoneyMonkeyOpenAITestState();
}

class _MoneyMonkeyOpenAITestState extends State<MoneyMonkeyOpenAITest> {
  final TextEditingController _apiKeyController = TextEditingController();
  String _testResults = '';
  bool _isLoading = false;
  String? _threadId;
  
  // List of assistants to test
  final Map<String, String> _assistants = {
    'General Financial': 'asst_lE0rWT5ClaMGRGVFOBP44QR2',
    'Budgeting Education': 'asst_6pdI9EAQ0GoaiA5b5yx7zE1R',
    'Investing Education': 'asst_Jn3NnhTQ80HXAnFYXYXf5rRD',
    'Try-It Scenario': 'asst_vEUIdTbI3c6iMWGYc3JoeJV7',
    'Reflection': 'asst_R5uiQO3lB06XGS2MxqCeenFH',
    'Exit Check': 'asst_IZgxSKH40t9EpW7gDhpnKYIM',
  };

  @override
  void initState() {
    super.initState();
    // Auto-fill the API key if available in memory (for testing only)
    final String storedKey = const String.fromEnvironment('OPENAI_API_KEY', defaultValue: '');
    if (storedKey.isNotEmpty) {
      _apiKeyController.text = storedKey;
    }
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  // Add test results with timestamp
  void _addResult(String result) {
    setState(() {
      _testResults += '\n[${DateTime.now().toString().substring(11, 19)}] $result';
    });
    _scrollToBottom();
  }

  // Clear results
  void _clearResults() {
    setState(() {
      _testResults = '';
    });
  }

  final ScrollController _scrollController = ScrollController();
  
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Check API Key Validity
  Future<void> _checkAPIKey() async {
    if (_apiKeyController.text.isEmpty) {
      _addResult('❌ Error: API key is required');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      _addResult('🔍 Testing API Key...');
      
      final response = await http.get(
        Uri.parse('https://api.openai.com/v1/models'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_apiKeyController.text}',
        },
      );
      
      _addResult('📊 Status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        _addResult('✅ API Key is valid');
      } else {
        _addResult('❌ API Key validation error: ${response.body}');
      }
    } catch (e) {
      _addResult('❌ Exception: $e');
      if (e.toString().contains('XMLHttpRequest')) {
        _addResult('⚠️ CORS issue detected. This is normal in web browsers.');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Test 1: List all available assistants
  Future<void> _listAssistants() async {
    if (_apiKeyController.text.isEmpty) {
      _addResult('❌ Error: API key is required');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      _addResult('🔍 Listing available assistants...');
      
      final response = await http.get(
        Uri.parse('https://api.openai.com/v1/assistants'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_apiKeyController.text}',
          'OpenAI-Beta': 'assistants=v2'
        },
      );
      
      _addResult('📊 Status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data'].isNotEmpty) {
          _addResult('✅ Found ${data['data'].length} assistants');
          
          for (var assistant in data['data']) {
            _addResult('📌 ID: ${assistant['id']}, Name: ${assistant['name']}');
          }
        } else {
          _addResult('⚠️ No assistants found in this account/organization');
        }
      } else {
        _addResult('❌ Error: ${response.body}');
      }
    } catch (e) {
      _addResult('❌ Exception: $e');
      if (e.toString().contains('XMLHttpRequest')) {
        _addResult('⚠️ CORS issue detected. This is normal in web browsers.');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Test 2: Create a thread
  Future<void> _createThread() async {
    if (_apiKeyController.text.isEmpty) {
      _addResult('❌ Error: API key is required');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      _addResult('🔍 Creating a new thread...');
      
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/threads'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_apiKeyController.text}',
          'OpenAI-Beta': 'assistants=v2'
        },
        body: jsonEncode({}),
      );
      
      _addResult('📊 Status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final threadData = jsonDecode(response.body);
        _threadId = threadData['id'];
        _addResult('✅ Created thread with ID: $_threadId');
      } else {
        _addResult('❌ Error: ${response.body}');
      }
    } catch (e) {
      _addResult('❌ Exception: $e');
      if (e.toString().contains('XMLHttpRequest')) {
        _addResult('⚠️ CORS issue detected. This is normal in web browsers.');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  // Test 3: Add a message to the thread
  Future<void> _addMessageToThread() async {
    if (_apiKeyController.text.isEmpty) {
      _addResult('❌ Error: API key is required');
      return;
    }

    if (_threadId == null) {
      _addResult('❌ Error: Need to create a thread first');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      _addResult('🔍 Adding a message to thread...');
      
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/threads/$_threadId/messages'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_apiKeyController.text}',
          'OpenAI-Beta': 'assistants=v2'
        },
        body: jsonEncode({
          'role': 'user',
          'content': 'Hi, I have a question about financial literacy.',
        }),
      );
      
      _addResult('📊 Status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final messageData = jsonDecode(response.body);
        _addResult('✅ Added message with ID: ${messageData['id']}');
      } else {
        _addResult('❌ Error: ${response.body}');
      }
    } catch (e) {
      _addResult('❌ Exception: $e');
      if (e.toString().contains('XMLHttpRequest')) {
        _addResult('⚠️ CORS issue detected. This is normal in web browsers.');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Test 4: Test a specific assistant
  Future<void> _testAssistant(String name, String assistantId) async {
    if (_apiKeyController.text.isEmpty) {
      _addResult('❌ Error: API key is required');
      return;
    }

    if (_threadId == null) {
      _addResult('❌ Error: Need to create a thread first');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      _addResult('🔍 Testing $name assistant...');
      _addResult('Assistant ID: $assistantId');
      _addResult('Thread ID: $_threadId');
      
      // First check if the assistant exists
      final assistantResponse = await http.get(
        Uri.parse('https://api.openai.com/v1/assistants/$assistantId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_apiKeyController.text}',
          'OpenAI-Beta': 'assistants=v2'
        },
      );
      
      if (assistantResponse.statusCode != 200) {
        _addResult('❌ Error: Assistant not found - ${assistantResponse.body}');
        setState(() {
          _isLoading = false;
        });
        return;
      }
      
      _addResult('✅ Assistant found');
      
      // Run the assistant on the thread
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/threads/$_threadId/runs'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_apiKeyController.text}',
          'OpenAI-Beta': 'assistants=v2'
        },
        body: jsonEncode({
          'assistant_id': assistantId,
        }),
      );
      
      _addResult('📊 Status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final runData = jsonDecode(response.body);
        final runId = runData['id'];
        _addResult('✅ Started run with ID: $runId');
        
        // Wait for run to complete
        _addResult('⏳ Waiting for run to complete...');
        await _waitForRunCompletion(_threadId!, runId);
      } else {
        _addResult('❌ Error: ${response.body}');
      }
    } catch (e) {
      _addResult('❌ Exception: $e');
      if (e.toString().contains('XMLHttpRequest')) {
        _addResult('⚠️ CORS issue detected. This is normal in web browsers.');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Helper to wait for run completion
  Future<void> _waitForRunCompletion(String threadId, String runId) async {
    bool isCompleted = false;
    int attempts = 0;
    const maxAttempts = 30;
    
    while (!isCompleted && attempts < maxAttempts) {
      attempts++;
      
      try {
        final response = await http.get(
          Uri.parse('https://api.openai.com/v1/threads/$threadId/runs/$runId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${_apiKeyController.text}',
            'OpenAI-Beta': 'assistants=v2'
          },
        );
        
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final status = data['status'];
          
          _addResult('🔄 Run status: $status (attempt $attempts)');
          
          if (status == 'completed') {
            isCompleted = true;
            _addResult('✅ Run completed successfully');
            
            // Get messages
            await _getMessages();
          } else if (status == 'failed' || status == 'cancelled' || status == 'expired') {
            _addResult('❌ Run ended with status: $status');
            if (data['last_error'] != null) {
              _addResult('❌ Error details: ${data['last_error']}');
            }
            break;
          } else {
            await Future.delayed(const Duration(seconds: 1));
          }
        } else {
          _addResult('❌ Error checking run status: ${response.body}');
          break;
        }
      } catch (e) {
        _addResult('❌ Exception while checking run: $e');
        break;
      }
    }
    
    if (!isCompleted && attempts >= maxAttempts) {
      _addResult('⚠️ Timed out waiting for run to complete');
    }
  }

  // Get messages from thread
  Future<void> _getMessages() async {
    try {
      _addResult('🔍 Getting messages from thread...');
      
      final response = await http.get(
        Uri.parse('https://api.openai.com/v1/threads/$_threadId/messages'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_apiKeyController.text}',
          'OpenAI-Beta': 'assistants=v2'
        },
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final messages = data['data'];
        
        _addResult('✅ Retrieved ${messages.length} messages');
        
        for (var message in messages) {
          if (message['role'] == 'assistant') {
            _addResult('🤖 Assistant: ${message['content'][0]['text']['value']}');
          } else {
            _addResult('👤 User: ${message['content'][0]['text']['value']}');
          }
        }
      } else {
        _addResult('❌ Error getting messages: ${response.body}');
      }
    } catch (e) {
      _addResult('❌ Exception getting messages: $e');
    }
  }

  // Create a completely new assistant
  Future<void> _createNewAssistant() async {
    if (_apiKeyController.text.isEmpty) {
      _addResult('❌ Error: API key is required');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      _addResult('🔍 Creating a new test assistant...');
      
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/assistants'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_apiKeyController.text}',
          'OpenAI-Beta': 'assistants=v2'
        },
        body: jsonEncode({
          'name': 'Money Monkey Test Assistant',
          'instructions': 'You are an educational financial assistant for the Money Monkey app used in schools.',
          'model': 'gpt-4o',
          'tools': [{'type': 'code_interpreter'}]
        }),
      );
      
      _addResult('📊 Status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final assistantData = jsonDecode(response.body);
        final newAssistantId = assistantData['id'];
        _addResult('✅ Created new assistant with ID: $newAssistantId');
        _addResult('💡 Use this ID in your application to replace the non-working IDs');
        
        // Add this to the list of assistants to test
        setState(() {
          _assistants['New Test Assistant'] = newAssistantId;
        });
      } else {
        _addResult('❌ Error: ${response.body}');
      }
    } catch (e) {
      _addResult('❌ Exception: $e');
      if (e.toString().contains('XMLHttpRequest')) {
        _addResult('⚠️ CORS issue detected. This is normal in web browsers.');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Monkey OpenAI Test'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('CORS Warning for Web'),
                  content: const Text(
                    'When running in a web browser, you may encounter CORS errors. '
                    'This is normal and expected because browsers restrict direct API calls to external domains.\n\n'
                    'For production use, you should implement a backend proxy or use a serverless function to make these API calls.'
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _apiKeyController,
              decoration: const InputDecoration(
                labelText: 'OpenAI API Key',
                border: OutlineInputBorder(),
                hintText: 'sk-...',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Step 1: Check your API key and create a thread',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _checkAPIKey,
                  child: const Text('Check API Key'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _listAssistants,
                  child: const Text('List Your Assistants'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _createThread,
                  child: const Text('Create Thread'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _addMessageToThread,
                  child: const Text('Add Message'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _createNewAssistant,
                  child: const Text('Create New Assistant'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Step 2: Test your assistants',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _assistants.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      onPressed: _isLoading || _threadId == null
                          ? null
                          : () => _testAssistant(entry.key, entry.value),
                      child: Text('Test ${entry.key}'),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Test Results:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _clearResults,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Clear Results'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      child: Text(
                        _testResults.isEmpty ? 'Test results will appear here' : _testResults,
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ),
                    if (_isLoading)
                      Container(
                        color: Colors.black.withOpacity(0.1),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Monkey OpenAI Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MoneyMonkeyOpenAITest(),
    );
  }
}