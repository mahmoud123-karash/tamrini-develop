import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/generated/l10n.dart';

class LocationSearchDialog extends StatelessWidget {
  const LocationSearchDialog({
    super.key,
    required this.onSuggestionSelected,
    required this.controller,
  });
  final void Function(Prediction) onSuggestionSelected;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
          width: 350,
          child: TypeAheadField(
            hideSuggestionsOnKeyboardHide: false,
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: S.of(context).search,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(style: BorderStyle.none, width: 0),
                ),
                hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 20,
                  ),
            ),
            suggestionsCallback: (pattern) async {
              return await searchLocation(context, pattern);
            },
            itemBuilder: (context, Prediction suggestion) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    Expanded(
                      child: Text(
                        suggestion.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
            onSuggestionSelected: onSuggestionSelected,
          ),
        ),
      ),
    );
  }
}
