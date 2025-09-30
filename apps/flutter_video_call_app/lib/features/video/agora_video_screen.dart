import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

/// Replace these with your values
const String appId = 'efe4f07d84b949bb8b13b34e11d4ae3f';
const String token = 'token'; // use null for testing if certificate disabled
const String defaultChannel = 'test_channel';

class AgoraVideoScreen extends StatefulWidget {
  final String channelId;
  final String? rtcToken;
  final String? localUserName;

  const AgoraVideoScreen({
    Key? key,
    this.channelId = defaultChannel,
    this.rtcToken,
    this.localUserName,
  }) : super(key: key);

  @override
  State<AgoraVideoScreen> createState() => _AgoraVideoScreenState();
}

class _AgoraVideoScreenState extends State<AgoraVideoScreen> with WidgetsBindingObserver {
  late final RtcEngine _engine;
  final Set<int> _remoteUids = {};
  int? _localUid;
  bool _joined = false;
  bool _muted = false;
  bool _videoEnabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initEngine();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _leaveChannel();
    _engine.release();
    super.dispose();
  }

  Future<bool> _requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();
    return statuses[Permission.camera]!.isGranted && statuses[Permission.microphone]!.isGranted;
  }

  Future<void> _initEngine() async {
    if (appId.isEmpty || appId == 'YOUR_AGORA_APP_ID') {
      throw Exception('Please provide your Agora App ID in appId constant.');
    }

    await _requestPermissions();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: appId));

    await _engine.enableVideo();
    await _engine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 1280, height: 720),
        frameRate: 30,
        bitrate: 0,
      ),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _joined = true;
            _localUid = connection.localUid;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUids.add(remoteUid);
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          setState(() {
            _remoteUids.remove(remoteUid);
          });
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          setState(() {
            _joined = false;
            _remoteUids.clear();
            _localUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(
      token: widget.rtcToken ?? token,
      channelId: widget.channelId,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _leaveChannel() async {
    try {
      await _engine.leaveChannel();
    } catch (_) {}
  }

  void _toggleMute() {
    setState(() {
      _muted = !_muted;
    });
    _engine.muteLocalAudioStream(_muted);
  }

  void _toggleVideo() {
    setState(() {
      _videoEnabled = !_videoEnabled;
    });
    _engine.muteLocalVideoStream(!_videoEnabled);
    _engine.enableLocalVideo(_videoEnabled);
  }

  Widget _renderLocalPreview() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }

  Widget _renderRemoteVideo(int uid) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: _engine,
        canvas: VideoCanvas(uid: uid),
        connection: RtcConnection(channelId: widget.channelId),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Optionally mute when backgrounded
    } else if (state == AppLifecycleState.resumed) {
      // Restore if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final remoteList = _remoteUids.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora - Channel: ${widget.channelId}'),
        actions: [
          IconButton(
            tooltip: 'Leave',
            icon: const Icon(Icons.call_end),
            onPressed: () async {
              await _leaveChannel();
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _joined
                          ? (remoteList.isEmpty
                              ? Center(child: _renderLocalPreview())
                              : _renderRemoteVideo(remoteList.first))
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    Positioned(
                      right: 12,
                      top: 12,
                      width: 120,
                      height: 160,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          color: Colors.black,
                        ),
                        child: _renderLocalPreview(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _joined
                          ? 'Joined as uid: ${_localUid ?? "?"} — Remotes: ${_remoteUids.length}'
                          : 'Connecting...',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(_muted ? Icons.mic_off : Icons.mic),
                        label: Text(_muted ? 'Unmute' : 'Mute'),
                        onPressed: _toggleMute,
                      ),
                      ElevatedButton.icon(
                        icon: Icon(_videoEnabled ? Icons.videocam : Icons.videocam_off),
                        label: Text(_videoEnabled ? 'Video Off' : 'Video On'),
                        onPressed: _toggleVideo,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        icon: const Icon(Icons.call_end),
                        label: const Text('Leave'),
                        onPressed: () async {
                          await _leaveChannel();
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
