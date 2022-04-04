import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'meeting_action_button.dart';

// Meeting ActionBar
class MeetingActionBar extends StatelessWidget {
  // control states
  final bool isMicEnabled,
      isWebcamEnabled,
      isScreenShareEnabled,
      isScreenShareButtonDisabled;

  // callback functions
  final void Function() onCallEndButtonPressed,
      onMicButtonPressed,
      onWebcamButtonPressed,
      onSwitchCameraButtonPressed,
      onMoreButtonPressed,
      onScreenShareButtonPressed;

  const MeetingActionBar({
    Key? key,
    required this.isMicEnabled,
    required this.isWebcamEnabled,
    required this.isScreenShareEnabled,
    required this.isScreenShareButtonDisabled,
    required this.onCallEndButtonPressed,
    required this.onMicButtonPressed,
    required this.onWebcamButtonPressed,
    required this.onSwitchCameraButtonPressed,
    required this.onScreenShareButtonPressed,
    required this.onMoreButtonPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(

      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: <Widget>[
      //     Container(
      //       color: Colors.blueAccent,
      //       child: IconButton(
      //         onPressed: (){},
      //         icon: Icon(Icons.mic_off),
      //         // onPressed: _speechToText.isNotListening
      //         //     ? _startListening
      //         //     : _stopListening,
      //         // tooltip: 'Listen',
      //         // icon: Icon(_speechToText.isNotListening
      //         //     ? Icons.mic_off
      //         //     : Icons.mic),
      //         padding: EdgeInsets.all(100.0),
      //
      //       ),
      //     ),
      //     Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: [
              // Call End Control
              Expanded(
                child: MeetingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: onCallEndButtonPressed,
                  icon: Icons.call_end,
                ),
              ),

              // Mic Control
              Expanded(
                child: MeetingActionButton(
                  onPressed: onMicButtonPressed,
                  backgroundColor:
                      isMicEnabled? hoverColor : secondaryColor.withOpacity(0.8),
                  icon: isMicEnabled ? Icons.mic : Icons.mic_off,
                ),
              ),

              // Webcam Control
              Expanded(
                child: MeetingActionButton(
                  onPressed: onWebcamButtonPressed,
                  backgroundColor: isWebcamEnabled
                      ? hoverColor
                      : secondaryColor.withOpacity(0.8),
                  icon: isWebcamEnabled ? Icons.videocam : Icons.videocam_off,
                ),
              ),

              // Webcam Switch Control
              Expanded(
                child: MeetingActionButton(
                  backgroundColor: secondaryColor.withOpacity(0.8),
                  onPressed: isWebcamEnabled ? onSwitchCameraButtonPressed : null,
                  icon: Icons.cameraswitch,
                ),
              ),

              // ScreenShare Control
              if (Platform.isAndroid)
                Expanded(
                  child: MeetingActionButton(
                    backgroundColor: isScreenShareEnabled
                        ? hoverColor
                        : secondaryColor.withOpacity(0.8),
                    onPressed: isScreenShareButtonDisabled
                        ? null
                        : onScreenShareButtonPressed,
                    icon: isScreenShareEnabled
                        ? Icons.screen_share
                        : Icons.stop_screen_share,
                    iconColor:
                        isScreenShareButtonDisabled ? Colors.white30 : Colors.white,
                  ),
                ),

              // More options
              Expanded(
                child: MeetingActionButton(
                  backgroundColor: secondaryColor.withOpacity(0.8),
                  onPressed: onMoreButtonPressed,
                  icon: Icons.more_vert,
                ),
              ),
            ],
          ),
    //       ),
    //     ]
    //   ),
    );
  }
}
