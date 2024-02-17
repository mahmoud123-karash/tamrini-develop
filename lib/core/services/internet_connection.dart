import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

void checkInternet() {
  bool internetdisconnected = false;
  Future.delayed(const Duration(seconds: 7)).then(
    (value) => InternetConnectionChecker().onStatusChange.listen(
      (status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            if (internetdisconnected) {
              ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(
                SnackBar(
                  content: Text(
                      S.of(navigationKey.currentContext!).internet_connection),
                  duration: const Duration(seconds: 5),
                  backgroundColor: Colors.green,
                ),
              );
              internetdisconnected = false;
            }

            break;
          case InternetConnectionStatus.disconnected:
            ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(
              SnackBar(
                content: Text(S.of(navigationKey.currentContext!).no_internet),
                duration: const Duration(seconds: 5),
                backgroundColor: Colors.red,
              ),
            );
            internetdisconnected = true;
            break;
        }
      },
    ),
  );
}
