// 创建子线程 更新DB
import 'dart:isolate';

import 'package:dio/dio.dart';

final Map<String, Isolate> tasks = {};

typedef Completed = void Function();
typedef Error = void Function(String msg);
typedef Progress = void Function(int porgress);

Future<String> isolateDownload(String downloadUrl, String downloadDBPath,
    {String taskName,
    Completed completed,
    Error error,
    Progress progressCallback}) async {


  final ReceivePort receivePort = ReceivePort();
  Isolate isolateDownload =
      await Isolate.spawn(_isolateDownload, receivePort.sendPort);

  String taskID =
  ((taskName == null ? "" : taskName) + DateTime.now().toString());
  tasks[taskID] = isolateDownload;

  receivePort.listen((msg) {
    if (msg is SendPort) {
      msg.send("downloadUrl=" + downloadUrl);
      msg.send("downloadDBPath=" + downloadDBPath);
    } else if (msg is String) {
      print("main isolate receive \t" + msg); //3.接收子线程的数据
      if (msg.startsWith("progress=")) {
        int progress = int.parse(msg.substring("progress=".length, msg.length));
        if (progress != null) {
          progressCallback(progress);
        }
      } else if (msg == "completed") {
        receivePort?.close();
        isolateDownload?.kill(priority: Isolate.immediate);
        isolateDownload = null;
        if (completed != null) {
          completed();
        }
        tasks.remove(taskID);
      } else if (msg.startsWith("error=")) {
        receivePort?.close();
        isolateDownload?.kill(priority: Isolate.immediate);
        if (error != null) {
          error(msg);
        }
        isolateDownload = null;
        tasks.remove(taskID);

      }
    }
  });
  print("Job's requested, time:${DateTime.now()}"); //1.主线程不等待

  return taskID;
}

void _isolateDownload(SendPort mainPort) {
  final taskPort = ReceivePort();
  mainPort.send(taskPort.sendPort);
  String downloadUrl = "";
  String downloadDBPath = "";
  taskPort.listen((message) {
    print("isolate_download_db receive\t" + message);
    if (message is String) {
      if (message.startsWith("downloadUrl=")) {
        downloadUrl = message.substring("downloadUrl=".length, message.length);
      } else if (message.startsWith("downloadDBPath=")) {
        downloadDBPath =
            message.substring("downloadDBPath=".length, message.length);
      }
      if (downloadUrl.isNotEmpty && downloadDBPath.isNotEmpty) {
        downloadDB(downloadUrl, downloadDBPath, mainPort);
      }
    }
  });
}

void downloadDB(String downloadUrl, String downloadDBPath, SendPort mainPort) {
  var dio = Dio();
  int last = 0;
  bool flag = true;
  dio
      .download(
        downloadUrl,
        downloadDBPath,
        onReceiveProgress: (int count, int total) {
          // print("当前进度=" + (count / total * 100).toStringAsFixed(0) + "%");
          int progress = int.parse((count / total * 100).toStringAsFixed(0));
          if (progress > last) {
            mainPort.send("progress=" + progress.toString());
            last = progress;
          }
          if (count == total && flag) {
            mainPort.send("completed"); //2.子线程完成任务，回报数据
            flag = false;
          }
        },
      )
      .then((dynamic response) {})
      .catchError((dynamic error) {
        print("then on Error" + error.toString());
        mainPort.send("error=" + error.toString());
      });
}
