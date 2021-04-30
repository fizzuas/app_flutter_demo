import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/util/view_size_utils.dart';


typedef void TextFieldCallBack(String content);
typedef void CancelCallBack();

class CommonTitleView extends StatefulWidget implements PreferredSizeWidget {
  final String titleName;
  final bool backHomeVisible;
  final bool queryVisible;
  final bool toBTVisible;
  bool isSearchBar;

  bool clearAllTxt = false;

  final TextFieldCallBack fieldCallBack;
  final CancelCallBack cancelCallBack;

  CommonTitleView({Key key, this.fieldCallBack, this.cancelCallBack,
    this.titleName,
    this.isSearchBar = false,
    this.backHomeVisible = true,
    this.toBTVisible = true,
    this.queryVisible = false})
      : super(key: key);

  @override
  _CommonTitleViewState createState() => _CommonTitleViewState();

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _CommonTitleViewState extends State<CommonTitleView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Material(
          color: Colors.blue,
          child: SafeArea(
            top: true,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back,color: Colors.black45,),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Text(
                            widget.titleName,
                            style: TextStyle(
                                color: Colors.black, fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          )),);
  }

}

