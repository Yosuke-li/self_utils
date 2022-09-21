import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'format.dart';

/// Widget with markdown buttons
class MarkdownTextInput extends StatefulWidget {
  /// Callback called when text changed
  final Function onTextChanged;

  /// Initial value you want to display
  final String initialValue;

  /// Validator for the TextFormField
  final String? Function(String? value)? validators;

  /// String displayed at hintText in TextFormField
  final String? label;

  /// Change the text direction of the input (RTL / LTR)
  final TextDirection? textDirection;

  /// List of action the component can handle
  final List<MarkdownType> actions;

  /// Optionnal controller to manage the input
  final TextEditingController controller;

  /// Constructor for [MarkdownTextInput]
  MarkdownTextInput(
      this.onTextChanged,
      this.initialValue, {
        this.label = '',
        this.validators,
        this.textDirection = TextDirection.ltr,
        this.actions = const [
          MarkdownType.bold,
          MarkdownType.italic,
          MarkdownType.title,
          MarkdownType.link,
          MarkdownType.list
        ],
        required this.controller,
      });

  @override
  _MarkdownTextInputState createState() => _MarkdownTextInputState();
}

class _MarkdownTextInputState extends State<MarkdownTextInput> {
  late TextEditingController _controller;
  TextSelection textSelection = const TextSelection(baseOffset: 0, extentOffset: 0);


  void onTap(MarkdownType type, {int titleSize = 1}) {
    final basePosition = textSelection.baseOffset;
    var noTextSelected = (textSelection.baseOffset - textSelection.extentOffset) == 0;

    final result = FormatMarkdown.convertToMarkdown(
        type, _controller.text, textSelection.baseOffset, textSelection.extentOffset,
        titleSize: titleSize);

    _controller.value = _controller.value
        .copyWith(text: result.data, selection: TextSelection.collapsed(offset: basePosition + result.cursorIndex));

    if (noTextSelected) {
      _controller.selection = TextSelection.collapsed(offset: _controller.selection.end - result.replaceCursorIndex);
    }
  }

  @override
  void initState() {
    _controller = widget.controller;
    _controller.text = widget.initialValue;
    _controller.addListener(() {
      if (_controller.selection.baseOffset != -1) textSelection = _controller.selection;
      widget.onTextChanged(_controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 44,
            child: Material(
              color: Theme.of(context).cardColor,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.actions.map((type) {
                  return type == MarkdownType.title
                      ? ExpandableNotifier(
                    child: Expandable(
                      key: Key('H#_button'),
                      collapsed: ExpandableButton(
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'H#',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      expanded: Container(
                        color: Colors.white10,
                        child: Row(
                          children: [
                            for (int i = 1; i <= 6; i++)
                              InkWell(
                                key: Key('H${i}_button'),
                                onTap: () => onTap(MarkdownType.title, titleSize: i),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'H$i',
                                    style: TextStyle(fontSize: (18 - i).toDouble(), fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ExpandableButton(
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.close,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : InkWell(
                    key: Key(type.key),
                    onTap: () => onTap(type),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(type.icon),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.newline,
            controller: _controller,
            maxLines: 1000,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) => widget.validators!(value),
            cursorColor: Theme.of(context).primaryColor,
            textDirection: widget.textDirection,
            decoration: InputDecoration(
              enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
              focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
              hintText: widget.label,
              hintStyle: const TextStyle(color: Color.fromRGBO(63, 61, 86, 0.5)),
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }
}