// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class VideoCallScreen extends StatefulWidget {
//   @override
//   _VideoCallScreenState createState() => _VideoCallScreenState();
// }

// class _VideoCallScreenState extends State<VideoCallScreen> {
//   RTCPeerConnection? _peerConnection;
//   MediaStream? _remoteStream;

//   final WebSocketChannel _channel = WebSocketChannel.connect(
//     Uri.parse('ws://your-signaling-server-url'),
//   );

//   @override
//   void initState() {
//     super.initState();
//     _initializePeerConnection();
//     _setupSignaling();
//   }

//   Future<void> _initializePeerConnection() async {
//     Map<String, dynamic> configuration = {
//       "iceServers": [
//         {"urls": "stun:stun.l.google.com:19302"}
//       ]
//     };

//     _peerConnection = await createPeerConnection(configuration);

//     _peerConnection?.onAddStream = (stream) {
//       setState(() {
//         _remoteStream = stream;
//       });
//     };
//   }

//   void _setupSignaling() {
//     _channel.stream.listen((message) async {
//       var data = json.decode(message);
//       switch (data['type']) {
//         case 'offer':
//           await _peerConnection?.setRemoteDescription(
//             RTCSessionDescription(data['sdp'], data['type']),
//           );
//           var answer = await _peerConnection?.createAnswer({});
//           await _peerConnection?.setLocalDescription(answer!);
//           _channel.sink.add(json.encode({
//             'type': 'answer',
//             'sdp': answer!.sdp,
//           }));
//           break;
//         case 'answer':
//           await _peerConnection?.setRemoteDescription(
//             RTCSessionDescription(data['sdp'], data['type']),
//           );
//           break;
//         case 'candidate':
//           await _peerConnection?.addCandidate(RTCIceCandidate(
//             data['candidate'],
//             data['sdpMid'],
//             data['sdpMLineIndex'],
//           ));
//           break;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Video Call')),
//       body: Center(
//         child: _remoteStream != null
//             ? RTCVideoView(_remoteStream!, mirror: false)
//             : CircularProgressIndicator(),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _peerConnection?.close();
//     _channel.sink.close();
//     super.dispose();
//   }
// }