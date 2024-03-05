import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/utils/improts.dart';

import 'widgets/custom_confirm_lang_button_widget.dart';
import 'widgets/language_container_widget.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String lang;
  @override
  void initState() {
    lang = CacheHelper.getData(key: 'lang') ?? Platform.localeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String cachedLang = CacheHelper.getData(key: 'lang') ?? '';
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppBar(S.of(context).language),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          LanguageContainerWidget(
              lable: S.of(context).arabic_language,
              onTap: () {
                lang = 'ar';
                setState(() {});
              },
              isSelected: lang == 'ar',
              image: Assets.imagesLang),
          LanguageContainerWidget(
            lable: S.of(context).english_language,
            onTap: () {
              lang = 'en';
              setState(() {});
            },
            isSelected: lang == 'en',
            image: Assets.imagesEn,
          ),
          LanguageContainerWidget(
            lable: S.of(context).device_language,
            onTap: () {
              lang = Platform.localeName;
              setState(() {});
            },
            isSelected: lang == Platform.localeName,
            image: getEnlish() == 'en' ? Assets.imagesEn : Assets.imagesLang,
          ),
          Expanded(
            child: SizedBox(
              width: width * 0.8,
              child: Image.asset(
                Assets.imagesLanguage,
                color: appColor.withOpacity(0.2),
              ),
            ),
          ),
          if (lang != cachedLang) CustomConfirmLangButtonWidget(lang: lang),
        ],
      ),
    );
  }
}
