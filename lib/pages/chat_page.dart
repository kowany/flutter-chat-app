import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _estaEscribiendo = false;
  List<ChatMessage> _messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                child: Text(
                  'Va',
                  style: TextStyle(fontSize: 12.0),
                ),
                backgroundColor: Colors.blue[100],
                maxRadius: 14.0,
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                'Vanessa Bustamante',
                style: TextStyle(color: Colors.black87, fontSize: 12.0),
              )
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _messages.length,
                    reverse: true,
                    itemBuilder: (_, int index) => _messages[index]),
              ),
              Divider(
                height: 1.0,
              ),
              // TODO: caja de  texto
              Container(
                color: Colors.white,
                child: _inputChat(),
              )
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handledSubmit,
                onChanged: (String texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),
            // botón enviar
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Platform.isIOS
                    ? CupertinoButton(
                        child: Text('Enviar'),
                        onPressed: _estaEscribiendo
                            ? () => _handledSubmit(_textController.text.trim())
                            : null,
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: IconTheme(
                          data: IconThemeData(color: Colors.blue[400]),
                          child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.send,
                            ),
                            onPressed: _estaEscribiendo
                                ? () =>
                                    _handledSubmit(_textController.text.trim())
                                : null,
                          ),
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  _handledSubmit(String texto) {
    if (texto.length == 0) return;
    print('$texto');
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      ),
    );
    this._messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    //TODO: off del socket
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
