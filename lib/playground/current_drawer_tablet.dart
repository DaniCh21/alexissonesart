import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CurrentDrawerTabletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              color: Colors.black12,
              width: 520,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RowWithLabelAndTextField(
                    label: 'Drawer Description',
                    textFieldHint: 'Enter Description (Optional)',
                  ),
                  CustomDivider(),
                  RowWithLabelAndTextField(
                    label: 'Pay in/out',
                    textFieldHint: 'Enter amount',
                  ),
                  CustomDivider(),
                  SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: FlatButton(
                      height: 60,
                      minWidth: 250,
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      onPressed: () => print('Btn was pressed'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit),
                          SizedBox(
                            width: 12,
                          ),
                          Text('End Drawer'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TwoLabeledRow(
                      leftLabel: 'Start time',
                      rightLabel: '22/11/2020 05:32 AM (5 hours ago)'),
                  CustomDivider(),
                  TwoLabeledRow(
                      leftLabel: 'Starting Cash', rightLabel: '220 SAR'),
                  CustomDivider(),
                  TwoLabeledRow(
                      leftLabel: 'Cash sales amount', rightLabel: '540 SAR'),
                  CustomDivider(),
                  TwoLabeledRow(
                      leftLabel: 'Card sales amount', rightLabel: '1250 SAR'),
                  CustomDivider(),
                  TwoLabeledRow(
                      leftLabel: 'Expected in drawer', rightLabel: '2200 SAR'),
                  CustomDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String label;
  final bool isLeft;

  LabelText({
    Key key,
    @required this.label,
    bool isLeftLabel,
  })  : isLeft = isLeftLabel == null ? true : isLeftLabel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Align(
        alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class RowWithLabelAndTextField extends StatelessWidget {
  final String label;
  final String textFieldHint;

  RowWithLabelAndTextField({
    Key key,
    @required this.label,
    @required this.textFieldHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: LabelText(
            label: label,
          ),
        ),
        Expanded(
          //child: TextField(),
          child: TextFormField(
            cursorColor: Colors.black,
            decoration: new InputDecoration(
              hintText: textFieldHint,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon: Icon(Icons.edit,),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  CustomDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        height: 1,
        color: Colors.black,
      ),
    );
  }
}

class TwoLabeledRow extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;

  TwoLabeledRow({
    Key key,
    @required this.leftLabel,
    @required this.rightLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: LabelText(
            label: leftLabel,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: LabelText(
              label: rightLabel,
              isLeftLabel: false,
            ),
          ),
        ),
      ],
    );
  }
}
