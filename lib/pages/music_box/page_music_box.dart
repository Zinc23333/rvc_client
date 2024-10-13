import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:rvc_client/data/znetwork.dart';
import 'package:rvc_client/widgets/drawer_music_box.dart';

class PageMusicBox extends StatefulWidget {
  const PageMusicBox({super.key});

  @override
  State<PageMusicBox> createState() => _PageMusicBoxState();
}

class _PageMusicBoxState extends State<PageMusicBox> {
  final _remoteRTCVideoRenderer = RTCVideoRenderer();
  RTCPeerConnection? pc;

  @override
  void initState() {
    super.initState();
  }

  void initConnection() async {
    await _remoteRTCVideoRenderer.initialize();

    pc = await createPeerConnection({
      'iceServers': [
        {"url": "stun:stun.l.google.com:19302"}
      ],
      'sdpSemantics': 'unified-plan',
    });
    pc!.onTrack = (event) {
      // print(event.track.kind);
      // print(event.track);
      // print(event.transceiver);
      if (event.track.kind == 'video') {
        _remoteRTCVideoRenderer.srcObject = event.streams[0];
        print(_remoteRTCVideoRenderer.srcObject);
        setState(() {});
        print('+++++++++++++++++++++++++++++++++++');
      }

      // .setSrcObject(stream: event.streams[0], trackId: event.track.id);
      // print(.srcObject!.getTracks());
    };
    pc?.onConnectionState = (state) {
      print('connectionState $state');
    };

    pc?.onIceConnectionState = (state) {
      print('iceConnectionState $state');
    };

    pc?.onIceCandidate = (event) {
      print('onIceCandidate ${event.candidate}');
      // LiveTalking.sendIceCandidate(event.candidate);
    };
    // pc.onTrack = (event) {
    //   if (event.track.kind == 'video') {
    //     print("$event");
    //     // onAddRemoteStream?.call(newSession, event.streams[0]);
    //   }
    // };

    print("===> 1");
    await pc!.addTransceiver(
      kind: RTCRtpMediaType.RTCRtpMediaTypeVideo,
      init: RTCRtpTransceiverInit(direction: TransceiverDirection.RecvOnly),
    );
    print("===> 2");
    await pc!.addTransceiver(
      kind: RTCRtpMediaType.RTCRtpMediaTypeAudio,
      init: RTCRtpTransceiverInit(direction: TransceiverDirection.RecvOnly),
    );
    print("===> 3");
    final offer = await pc!.createOffer();
    print("===> 4");
    await pc!.setLocalDescription(offer);

    print("===> 5");
    final ld = await pc!.getLocalDescription();
    print("===> 6");
    final recv = await LiveTalking.offer(ld!);

    print("===> 7");
    await pc!.setRemoteDescription(RTCSessionDescription(recv!['sdp'], recv['type']));
    print("===> 8");

    // _remoteRTCVideoRenderer.srcObject =

    // print(DateTime.now().toString());
    // print(ld.sdp);
  }

  @override
  void dispose() {
    super.dispose();
    pc?.close().then((_) {
      pc?.dispose();
    });
    // _remoteRTCVideoRenderer.dis
    _remoteRTCVideoRenderer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return buildPortrait();
      } else {
        return buildLandscape();
      }
    });
  }

  Scaffold buildLandscape() {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          DrawerMusicBox(),
          ElevatedButton(
            onPressed: () {
              // LiveTalking.offer();
              initConnection();
            },
            child: Text("ss"),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: RTCVideoView(
                _remoteRTCVideoRenderer,
                mirror: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Scaffold buildPortrait() {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerMusicBox(),
      body: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              // LiveTalking.offer();
              initConnection();
            },
            child: Text("test"),
          ),
          Expanded(
            child: RTCVideoView(
              _remoteRTCVideoRenderer,
              mirror: true,
            ),
          ),
        ],
      ),
    );
  }
}
