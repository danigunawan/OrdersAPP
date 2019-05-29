import 'package:flutter/material.dart';

class OrderNewPage extends StatefulWidget {
  @override
  State<OrderNewPage> createState() => _OrderNewPageState();
}

class _OrderNewPageState extends State<OrderNewPage> {
  int current_step = 0;

  List<Step> _getSteps(BuildContext context) {
    return [
      new Step(
          // Title of the Step
          title: current_step == 0 ? new Text("Cliente") : new Container(),
          // Content, it can be any widget here. Using basic Text for this example
          content: Row(
            children: <Widget>[
              Container(
                child: new Text("Cliente!"),
                height: 400,
              ),
            ],
          ),
          state: _getState(1),
          isActive: true),
      new Step(
          title: current_step == 1 ? new Text("Produtos") : new Container(),
          content: Row(
            children: <Widget>[
              Container(
                child: new Text("Produtos!"),
                height: 400,
              ),
            ],
          ),
          // You can change the style of the step icon i.e number, editing, etc.
          state: _getState(2),
          isActive: true),
      new Step(
          title: current_step == 2 ? new Text("Finalização") : new Container(),
          content: Row(
            children: <Widget>[
              Container(
                child: new Text("Finalização!"),
                height: 400,
              ),
            ],
          ),
          state: _getState(3),
          isActive: true),
      new Step(
          title: current_step == 3 ? new Text("Outro") : new Container(),
          content: Row(
            children: <Widget>[
              Container(
                child: new Text("Outro!"),
                height: 400,
              ),
            ],
          ),
          state: _getState(4),
          isActive: true),
    ];
  }

  StepState _getState(int i) {
    if (current_step >= i)
      return StepState.complete;
    else if (current_step + 1 == i)
      return StepState.editing;
    else if (current_step < i) return StepState.indexed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(0, 0, 0, 0.3),
      appBar: AppBar(
        title: Text('Nova Venda'),
        automaticallyImplyLeading: true,
      ),
      body: new Stepper(
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                  onPressed: onStepCancel,
                  child: current_step > 0
                      ? Row(
                          children: <Widget>[
                            Icon(
                              Icons.chevron_left,
                              size: 35,
                            ),
                            Text("Back", style: TextStyle(fontSize: 20))
                          ],
                        )
                      : new Container()),
              FlatButton(
                  onPressed: onStepContinue,
                  child: current_step < 3
                      ? Row(
                          children: <Widget>[
                            Text("Next", style: TextStyle(fontSize: 20)),
                            Icon(
                              Icons.chevron_right,
                              size: 35,
                            )
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Text("Save", style: TextStyle(fontSize: 20)),
                            Icon(
                              Icons.check,
                              size: 30,
                            )
                          ],
                        )),
            ],
          );
        },
        // Using a variable here for handling the currentStep
        currentStep: this.current_step,
        steps: _getSteps(context),
        type: StepperType.horizontal,
        onStepTapped: (step) {
          setState(() {
            // bloqueia que vá para próximo, ideal seria verificar se tá clicando no próximo (+1) e validar os dados
            if (current_step > step) current_step = step;
          });
          // print("onStepTapped : " + step.toString());
        },
        onStepCancel: () {
          setState(() {
            if (current_step > 0) {
              current_step = current_step - 1;
            } else {
              current_step = 0;
            }
          });
          // print("onStepCancel : " + current_step.toString());
        },
        onStepContinue: () {
          setState(() {
            var _steps = _getSteps(context);
            if (current_step < _steps.length - 1) {
              current_step = current_step + 1;
            } else {
              // Looping infinitamente
              // current_step = 0;
            }
          });
          // print("onStepContinue : " + current_step.toString());
        },
      ),
    );
  }
}
