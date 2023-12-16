import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModels/JoinPrivateRoomViewModel.dart';

class JoinPrivateRoomPage extends StatefulWidget {
  TextEditingController lobbyCodeController = TextEditingController();

  @override
  _JoinPrivateRoomState createState() => _JoinPrivateRoomState();
}

class _JoinPrivateRoomState extends State<JoinPrivateRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: widget.lobbyCodeController,
                decoration: const InputDecoration(
                  hintText: 'Enter the Room Code',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String accessCode = widget.lobbyCodeController.text;
                final viewModel = context.read<JoinPrivateRoomViewModel>();
                await viewModel.joinRoom(accessCode);
                if (viewModel.messageError.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(viewModel.messageError),
                    ),
                  );
                }
              },
              child: Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}