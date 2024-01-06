import 'package:flutter/material.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'widgets/gym_custom_buttons_widget.dart';
import 'widgets/gym_details_content_widget.dart';

class GymDetailsScreen extends StatelessWidget {
  const GymDetailsScreen({super.key, required this.model});
  final GymModel model;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          constraints: BoxConstraints(
            maxWidth: getWidth / 2,
          ),
          child: Text(
            model.name,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          height: getHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: GymDetailsContentWidget(model: model),
                ),
              ),
              GymCustomButtonsWidget(
                lat: model.location.latitude,
                long: model.location.longitude,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
