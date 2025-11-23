part of 'order_page.dart';

Widget carModelAutocomplete(
  TextEditingController controller,
  FocusNode focusNode,
    void Function(int modelId) onCarModelSelected
) {
  return RawAutocomplete<CarModel>(
    textEditingController: controller,
    focusNode: focusNode,
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text.isEmpty) {
        return const Iterable<CarModel>.empty();
      }
      return carSuggestions.where((CarModel option) {
        return option.f_model.toLowerCase().contains(
          textEditingValue.text.toLowerCase(),
        );
      });
    },

    fieldViewBuilder: (
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted,
    ) {
      return TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: tr().carModel,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
          ),
        ),
      );
    },
    optionsViewBuilder: (
      BuildContext context,
      AutocompleteOnSelected<CarModel> onSelected,
      Iterable<CarModel> options,
    ) {
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4,
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final String option = options.elementAt(index).f_model;
                return ListTile(
                  title: Text(option),
                  onTap: () {
                    final carModel = options.elementAt(index);
                    onSelected(carModel);
                    onCarModelSelected(carModel.f_id);
                  }
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
