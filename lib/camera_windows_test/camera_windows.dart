import 'dart:async';
import 'dart:io';

import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_screen_change/camera_windows_test/picture_select.dart';
import 'package:test_screen_change/camera_windows_test/testImg_model.dart';

class CameraWindows extends StatefulWidget {
  const CameraWindows({super.key});

  @override
  State<CameraWindows> createState() => _CameraWindowsState();
}

class _CameraWindowsState extends State<CameraWindows> {
  String _cameraInfo = 'Unknown';
  List<CameraDescription> _cameras = <CameraDescription>[];
  int _cameraIndex = 0;
  int _cameraId = -1;
  bool _initialized = false;
  // bool _recording = false;
  // bool _recordingTimed = false;
  // bool _recordAudio = true;
  bool _previewPaused = false;
  Size? _previewSize;
  ResolutionPreset _resolutionPreset = ResolutionPreset.veryHigh;
  StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
  StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;
  int picture = 0; //찍은 갯수 체크하기
  List<TestImgModel> pictureList = []; //찍은 사진 담아두기

  @override
  void initState() {
    super.initState();
    pictureList = []; //전 화면에서 넘어왔을 경우 이미지 목록 초기화
    _fetchCameras();
  }

  @override
  void dispose() {
    _disposeCurrentCamera();
    _errorStreamSubscription?.cancel();
    _errorStreamSubscription = null;
    _cameraClosingStreamSubscription?.cancel();
    _cameraClosingStreamSubscription = null;
    super.dispose();
  }

  //플러그인에서 사용가능한 카메라 목록을 가져온다.
  Future<void> _fetchCameras() async {
    String cameraInfo;
    List<CameraDescription> cameras = <CameraDescription>[];

    int cameraIndex = 0;
    try {
      cameras = await CameraPlatform.instance.availableCameras();
      if (cameras.isEmpty) {
        cameraInfo = 'No available cameras';
      } else {
        cameraIndex = _cameraIndex % cameras.length;
        cameraInfo = 'Found camera: ${cameras[cameraIndex].name}';
      }
    } on PlatformException catch (e) {
      cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
    }

    if (mounted) {
      setState(() {
        _cameraIndex = cameraIndex;
        _cameras = cameras;
        _cameraInfo = cameraInfo;
      });
    }
  }

  //카메라 초기화
  Future<void> _initializeCamera() async {
    assert(!_initialized);

    if (_cameras.isEmpty) {
      return;
    }

    int cameraId = -1;
    try {
      final int cameraIndex = _cameraIndex % _cameras.length;
      final CameraDescription camera = _cameras[cameraIndex];

      cameraId = await CameraPlatform.instance.createCamera(
        camera,
        _resolutionPreset,
        // enableAudio: _recordAudio,
      );

      unawaited(_errorStreamSubscription?.cancel());
      _errorStreamSubscription = CameraPlatform.instance
          .onCameraError(cameraId)
          .listen(_onCameraError);

      unawaited(_cameraClosingStreamSubscription?.cancel());
      _cameraClosingStreamSubscription = CameraPlatform.instance
          .onCameraClosing(cameraId)
          .listen(_onCameraClosing);

      final Future<CameraInitializedEvent> initialized =
          CameraPlatform.instance.onCameraInitialized(cameraId).first;

      await CameraPlatform.instance.initializeCamera(
        cameraId,
      );

      final CameraInitializedEvent event = await initialized;
      _previewSize = Size(
        event.previewWidth,
        event.previewHeight,
      );

      if (mounted) {
        setState(() {
          _initialized = true;
          _cameraId = cameraId;
          _cameraIndex = cameraIndex;
          _cameraInfo = 'Capturing camera: ${camera.name}';
        });
      }
    } on CameraException catch (e) {
      try {
        if (cameraId >= 0) {
          await CameraPlatform.instance.dispose(cameraId);
        }
      } on CameraException catch (e) {
        debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
      }

      // Reset state.
      if (mounted) {
        setState(() {
          _initialized = false;
          _cameraId = -1;
          _cameraIndex = 0;
          _previewSize = null;
          // _recording = false;
          // _recordingTimed = false;
          _cameraInfo =
              'Failed to initialize camera: ${e.code}: ${e.description}';
        });
      }
    }
  }

  Future<void> _disposeCurrentCamera() async {
    if (_cameraId >= 0 && _initialized) {
      try {
        await CameraPlatform.instance.dispose(_cameraId);

        if (mounted) {
          setState(() {
            _initialized = false;
            _cameraId = -1;
            _previewSize = null;
            // _recording = false;
            // _recordingTimed = false;
            _previewPaused = false;
            _cameraInfo = 'Camera disposed';
          });
        }
      } on CameraException catch (e) {
        if (mounted) {
          setState(() {
            _cameraInfo =
                'Failed to dispose camera: ${e.code}: ${e.description}';
          });
        }
      }
    }
  }

  Widget _buildPreview() {
    return CameraPlatform.instance.buildPreview(_cameraId);
  }

  Future<void> _takePicture() async {
    final XFile file = await CameraPlatform.instance.takePicture(_cameraId);
    // _showInSnackBar('Picture captured to: ${file.path}');
    picture++;
    pictureList
        .add(TestImgModel(imgUrl: file.path, selectImg: false, imagType: 'L'));
    // file.path);
    //C:\Users\dlld1\OneDrive\사진\ [저장위치]

    print('picturelist $pictureList');
    print('Picture captured to: ${file.path} picture $picture');
    if (picture == 4) {
      //네번 찍었으면 사진 선택화면으로 이동하기
      _disposeCurrentCamera();
      _fetchCameras();
      picture = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PictureSelect(
            pictureList: pictureList,
          ),
        ),
      );
      // pictureList = [];
    }
  }

  Future<void> _togglePreview() async {
    if (_initialized && _cameraId >= 0) {
      if (!_previewPaused) {
        await CameraPlatform.instance.pausePreview(_cameraId);
      } else {
        await CameraPlatform.instance.resumePreview(_cameraId);
      }
      if (mounted) {
        setState(() {
          _previewPaused = !_previewPaused;
        });
      }
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.isNotEmpty) {
      _cameraIndex = (_cameraIndex + 1) % _cameras.length;
      if (_initialized && _cameraId >= 0) {
        await _disposeCurrentCamera();
        await _fetchCameras();
        if (_cameras.isNotEmpty) {
          await _initializeCamera();
        }
      } else {
        await _fetchCameras();
      }
    }
  }

  Future<void> _onResolutionChange(ResolutionPreset newValue) async {
    setState(() {
      _resolutionPreset = newValue;
    });
    if (_initialized && _cameraId >= 0) {
      await _disposeCurrentCamera();
      await _initializeCamera();
    }
  }

  void _onCameraError(CameraErrorEvent event) {
    if (mounted) {
      print('Error: ${event.description}');
      // _scaffoldMessengerKey.currentState?.showSnackBar(
      //     SnackBar(content: Text('Error: ${event.description}')));

      _disposeCurrentCamera();
      _fetchCameras();
    }
  }

  void _onCameraClosing(CameraClosingEvent event) {
    if (mounted) {
      print('Camera is closing');
      // _showInSnackBar('Camera is closing');
    }
  }

  // void _showInSnackBar(String message) {
  //   _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
  //     content: Text(message),
  //     duration: const Duration(seconds: 1),
  //   ));
  // }

  // final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  // GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<ResolutionPreset>> resolutionItems =
        ResolutionPreset.values
            .map<DropdownMenuItem<ResolutionPreset>>((ResolutionPreset value) {
      return DropdownMenuItem<ResolutionPreset>(
        value: value,
        child: Text(value.toString()),
      );
    }).toList();

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(_cameraInfo),
        ),
        if (_cameras.isEmpty) // 카메라가 없다면
          ElevatedButton(
            onPressed: _fetchCameras,
            child: const Text('Re-check available cameras'),
          ),
        if (_cameras.isNotEmpty) // 카메라가 있다면
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<ResolutionPreset>(
                //화면 해상도 조절
                value: _resolutionPreset,
                onChanged: (ResolutionPreset? value) {
                  if (value != null) {
                    _onResolutionChange(value);
                  }
                },
                items: resolutionItems,
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed:
                    _initialized ? _disposeCurrentCamera : _initializeCamera,
                child: Text(_initialized ? 'Dispose camera' : 'Create camera'),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: _initialized ? _takePicture : null,
                child: const Text('Take picture'),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: _initialized ? _togglePreview : null,
                child: Text(
                  _previewPaused ? 'Resume preview' : 'Pause preview',
                ),
              ),
              const SizedBox(width: 5),
              if (_cameras.length > 1) ...<Widget>[
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: _switchCamera,
                  child: const Text(
                    'Switch camera',
                  ),
                ),
              ],
            ],
          ),
        if (_initialized && _cameraId > 0 && _previewSize != null) // 카메라 생성하면
          Container(
            height: 750,
            child: Column(
              children: [
                if (_previewSize != null)
                  Center(
                    child: Text(
                      'Preview size: ${_previewSize!.width.toStringAsFixed(0)}x${_previewSize!.height.toStringAsFixed(0)}',
                    ),
                  ),
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 500,
                  ),
                  child: AspectRatio(
                    aspectRatio: _previewSize!.width / _previewSize!.height,
                    child: _buildPreview(),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
