import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:utilities/utilities.dart';

import 'package:shca/modules/events/models/event_interface.dart';
import 'package:shca/modules/home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';

import '../../core/rtc/events.dart';

class Command {
  static final all = [
    open,
    turnOn,
    close,
    turnOff,
    arOpen,
    arTurnOn,
    arClose,
    arTurnOff
  ];

  static const open = CommandModel(name: "open", value: 1);
  static const turnOn = CommandModel(name: "turn on", value: 1);
  static const close = CommandModel(name: "close", value: 0);
  static const turnOff = CommandModel(name: "turn off", value: 0);

  static const arOpen = CommandModel(name: "افتح", value: 1);
  static const arTurnOn = CommandModel(name: "شغل", value: 1);
  static const arClose = CommandModel(name: "اقفل", value: 0);
  static const arTurnOff = CommandModel(name: "اطفي", value: 0);
}

class CommandModel {
  final String name;
  final double value;
  const CommandModel({
    required this.name,
    required this.value,
  });
}

class Utils {
  static List<EventInterface> interfaces = [];

  static void scanText(
    String rawText,
  ) {
    final text = rawText.toLowerCase();

    for (var command in Command.all) {
      if (text.contains(command.name)) {
        final interfaceName =
            _getTextAfterCommand(text: text, command: command.name);

        if (interfaceName != null) {
          _changeInterfaceValue(interfaceName, command.value);
        }

        break;
      }
    }
  }

  static String? _getTextAfterCommand({
    required String text,
    required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return null;
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static void _changeInterfaceValue(
    String name,
    double value,
  ) {
    var index = StringSimilarity.findBestMatch(
            name, interfaces.map((e) => e.interfaceName).toList())
        .bestMatchIndex;

    var interface = interfaces[index];
    var data = InterfaceValueChangeData(
        interfaceId: interface.interfaceId, value: value);
    NavigationService.context!
        .read<FetchInterfacesCubit>()
        .updateInterfaceValue(data);
  }
}
