import 'package:flutter/widgets.dart';

List<InlineSpan>? childrenUseAr = [
  const TextSpan(
    text: '1- الشاشة الرئيسية\n\n',
  ),
  const TextSpan(
    text:
        '- البانر الإعلاني يقدم لك إعلانات من قبل شركات رياضية يتم استبدال الإعلان بشكل تلقائي كل 5 ثوان وفي حال اعجبك الإعلان اضغط على الصور وسوف يتم تحويلك لموقع الإعلان \n',
  ),
  const TextSpan(
    text:
        '-	تمارين متنوعة وفي هذا القسم تضهر لك التمارين الموجوده بقسم ابحث عن تمرينك وبشكل عشوائي عند الضغط على التمرين سوف يتم عرض لك التمرين مشروح بالصورة والصوت والكتابة  ولتفصح جميع التمارين اضغط على كلمة المزيد \n',
  ),
  const TextSpan(
    text:
        '- آخر المقالات  هو مختصر لقسم المقالات ولعرض جميع المقالات اضغط على كلمة المزيد \n',
  ),
  const TextSpan(
    text:
        '- منتجات متنوعة يتم عرض فيها المنتجات الرياضية الموجودة في قسم المتجر ولعرض جميع المنتجات اضغط على كلمة المزيد \n',
  ),
  const TextSpan(
    text:
        '-	اقرب جم من هنا يضهر لك اقرب جم على منزلك ولتفصح جميع النوادي الرياضية اضغط على كلمة المزيد  \n',
  ),
  const TextSpan(
    text:
        '-	في اعلى الصفحة الرئيسية يوجد زر الجرس وفي هذا الزر يوجد قائمة الاشعارات \n\n\n',
  ),
  const TextSpan(
    text:
        '2- القائمة الجانبية وهي موجودة في الجزء العلوي للشاشة الرئيسية على جهة اليمين \n\n',
  ),
  const TextSpan(
    text:
        '-	الكورسات هذا القسم المخصص لكورساتك التدريبية تستطيع عرضه وأداء تمارينك من خلاله \n',
  ),
  const TextSpan(
    text:
        '-	منبه شرب الماء  ومن خلاله تقدر تضيف الكميه او أوقات شرب الماء ويقوم التطبيق بتذكريك\n',
  ),
  const TextSpan(
    text:
        '-	المكملات الغذائية وهذا القسم تستطيع عرض المكملات المكتوبه لك من قبل المدرب ومعرفة طريقة استخدامها ومكوناتها \n',
  ),
  const TextSpan(
    text: '-	النظام الغذائي هنا ستجد نظامك الغذائي المكتوب لك من قبل المدرب \n',
  ),
  const TextSpan(
    text:
        '-	المتابعه  هنا ستجد صورك ووزنك وطولك التي تم مشاركتها مع المدرب حتى تعرف مستوى تقدمك والتغييرات التي حصلت معك \n',
  ),
  const TextSpan(
    text:
        '-	الاعدادات 1 – الوضع المظلم تفعيل الدارك مود وتعطيله 2- الملف الشخصي لتفعيل وتعديل بياناتك او حذف حسابك 3- تغيير كلمة المرور الخاصة بك 4- تغيير رقم هاتفك \n',
  ),
  const TextSpan(
    text: '-	عن التطبيق يقدم لك هذا القسم تفاصيل عن التطبيق \n',
  ),
  const TextSpan(
    text:
        '-	تواصل معنا ستجد هنا جميع وسائل التواصل معنا في حال لديك استفسار \n',
  ),
  const TextSpan(
    text: '-	تقييم التطبيق ادخل على هذا القسم وادعمنا بتقييم التطبيق \n',
  ),
  const TextSpan(
    text:
        'تسجيل خروج في حال تريد تسجيل الخروج لتبديل حسابك او عمل حساب جديد \n\n\n',
  ),
  const TextSpan(
    text:
        '3- الصحة والتغدية وهي موجود في البار اسفل الشاشة اول ايقونه على جهة اليمين \n\n',
  ),
  const TextSpan(
    text:
        '-	القيم الغذائية من هنا اختار الاكلة التي تريد معرفة سعراتها الحرارية والقيم الغذائية الخاصه بها وذلك من خلال تفصح الاكلات او البحث عنها \n',
  ),
  const TextSpan(
    text:
        '-	حاسبة البروتينات هنا تدخل معلوماتك كاملة للحصول على احتياجك للسعرات اليومي حسب هدفك ونشاطك الخ.. \n',
  ),
  const TextSpan(
    text:
        '-	المكملات الغذائية هذا القسم يوجد جميع المكملات الغذائية تقدر من خلاله البحث عن أي مكمل لمعرفة طريقة استخدامه ومكوناته \n\n\n',
  ),
  const TextSpan(
    text:
        '4- التمارين واللياقة وهوه موجود في البار اسفل الصفحة الرئيسية الايقونة الثانية من جهة اليمين \n\n',
  ),
  const TextSpan(
    text:
        '-	ابحث عن تمرينك في هذا القسم تقدر تشوف اكثر من 1200 تمرين ومقسمين قسم لكل عضله تقدر تختار التمرين او تبحث عن اسمه وسوف يظهر لك التمرين مشروح صورة وصوت وكتابه \n',
  ),
  const TextSpan(
    text:
        '-	التمارين المنزلية نفس فكرة قسم ابحث عن تمرينك ولاكن مخصص للتمارين المنزلية \n',
  ),
  const TextSpan(
    text:
        '-	صالات الجيم هنا ستجد النوادي الرياضية الأقرب لمكانك ستتعرف على صورها وأسعار الاشتراك واوقات الدوام وأرقام التواصل مع الجم \n',
  ),
  const TextSpan(
    text:
        '-	المدربين اختر مدربك من خلال هذا القسم سوف تجد مدربين مخصصين لطلبك مع معرض أعمالهم وانجازاتهم وتقدر تتواصل معهم من خلال التطبيق والاشتراك معهم  ,, وفي حال كنت مدرب تقدر من خلال هذا القسم كتابه الكورسات التدريبيه للاعبيك واختيار  التمارين بكل سهولة فلديك قاعدة بيانات تحتوي على اكثر من 1200 تمرين صوره وصوت وكتابه بمجرد ضغطة سوف يحصل لاعبك على كورس الكتروني يحتوي على النظام الغذائي والتمارين المصورة والمكملات الغذائية \n\n\n',
  ),
  const TextSpan(
    text:
        '5- المتجر وهو موجود في البار اسفل الشاشة الرئيسية رابع ايقونه من جهة اليمين \n\n',
  ),
  const TextSpan(
    text:
        '-	توجد به مكملات غذائية لجميع احتياجاتك وهدفك مقسمة حسب هدف المكمل تقدر تشتري المكمل من افضل الوكالات المخصصة لهذا المجال مع حرية الدفع بواسطة الدفع الالكتروني او عند الاستلام والتوصيل لأي مكان \n\n\n',
  ),
  const TextSpan(
    text: '-	6 ثقف نفسك اول قسم من جهة اليسار \n',
  ),
  const TextSpan(
    text: '-	1 المقالات هنا تنشر مقالات رياضية من قبل مدربين محترفين \n',
  ),
  const TextSpan(
    text:
        '-	2 اكلات دايت هنا ننشر اكلات دايت وطريقه عملها وتقدر تبحث عن اكلة معينه \n',
  ),
  const TextSpan(
    text:
        '- الأسئلة اذا كان لديك أي سؤال قم بنشره بهذا القسم وسيتم الرد عليك من قبل المختصين وذو المعرفة وتقدر أيضا تبحث عن سؤال معين في بالك \n',
  ),
  const TextSpan(
    text:
        '7- يومي في هذا القسم المهم سوف تجد احتياجك للسعرات الحرارية والبروتين والكربوهيدرات والدهون الصحية اليومية وعند اضافه الوجبه التي اكلتها سوف تطرح القيمة الغذائية للاكلة من مجموع احتياجك اليومي وبهذا تعرف كم تبقى لك من احتياجك وتعرف تنظم وجباتك اليومية بمقدار محسوب بشكل ممتاز \n',
  ),
];

List<InlineSpan>? childrenUseEn = [
  const TextSpan(
    text: '1- The main screen:\n\n',
  ),
  const TextSpan(
    text:
        '- The banner displays advertisements from sports companies. The advertisements are automatically replaced every 5 seconds. If you like an advertisement, click on the image, and you will be redirected to the advertisement website.\n',
  ),
  const TextSpan(
    text:
        '- Various exercises are displayed in this section. Search for your exercise, and when you click on it, the exercise will be explained through pictures, audio, and text. To see all exercises, click on the "More" button.\n',
  ),
  const TextSpan(
    text:
        '- "Latest Articles" is a summary of the articles section. To view all articles, click on the "More" button.\n',
  ),
  const TextSpan(
    text:
        '- Various products are displayed, showcasing sports products available in the store. To view all products, click on the "More" button.\n',
  ),
  const TextSpan(
    text:
        '- "Nearest Gym" shows the closest gym to your location. To see all sports clubs, click on the "More" button.\n',
  ),
  const TextSpan(
    text:
        '- At the top of the main screen, there is a bell icon, which contains the notifications menu.\n\n\n',
  ),
  const TextSpan(
    text:
        '2- The side menu is located at the top of the main screen on the right side.\n\n',
  ),
  const TextSpan(
    text:
        '- Courses: This section is dedicated to your training courses. You can view and perform your exercises through it.\n',
  ),
  const TextSpan(
    text:
        '- Water Reminder: You can add the quantity or times of water consumption through this feature, and the application will remind you.\n',
  ),
  const TextSpan(
    text:
        '- Nutritional Supplements: In this section, you can view the nutritional supplements recommended by your trainer, learn how to use them, and know their ingredients.\n',
  ),
  const TextSpan(
    text:
        '- Diet Plan: Here you will find your personalized diet plan written by your trainer.\n',
  ),
  const TextSpan(
    text:
        '- Progress Tracking: Here, you can find your progress photos, weight, and height shared with the trainer to track your progress and changes.\n',
  ),
  const TextSpan(
    text:
        '- Settings: 1. Dark Mode: Activate or deactivate the dark mode. 2. Profile: Activate, edit, or delete your profile. 3. Change Password: Change your password. 4. Change Phone Number: Update your phone number.\n',
  ),
  const TextSpan(
    text:
        '- About the App: This section provides details about the application.\n',
  ),
  const TextSpan(
    text:
        '- Contact Us: Here, you will find all the contact information in case you have any inquiries.\n',
  ),
  const TextSpan(
    text:
        '- App Rating: Enter this section to support us by rating the application.\n',
  ),
  const TextSpan(
    text:
        'Logout: If you want to log out to switch accounts or create a new account.\n\n\n',
  ),
  const TextSpan(
    text:
        '3. Health and Nutrition: It is located in the bottom bar, the first icon on the right side.\n\n',
  ),
  const TextSpan(
    text:
        '- Nutritional Values: Select the food item to know its calories and nutritional values. You can search for specific foods or browse through the list.\n',
  ),
  const TextSpan(
    text:
        '- Protein Calculator: Enter your complete information to calculate your daily protein needs based on your goals and activity level.\n',
  ),
  const TextSpan(
    text:
        '- Dietary Supplements: This section contains all the dietary supplements. You can search for any supplement to learn about its usage and ingredients.\n\n\n',
  ),
  const TextSpan(
    text:
        '4- Exercise and Fitness: It can be found in the bar at the bottom of the homepage, the second icon from the right.\n\n',
  ),
  const TextSpan(
    text:
        '- Search for your exercise in this section. You can find over 1200 exercises categorized by muscle groups. You can choose the exercise or search for its name, and it will be displayed with explanations, images, sound, and text.\n',
  ),
  const TextSpan(
    text:
        '- Home exercises: Similar to the previous section, you can search for your exercise, but this section is dedicated to home workouts.\n',
  ),
  const TextSpan(
    text:
        '- Gymnasiums: Here you will find the nearest sports clubs to your location. You will get to see their pictures, subscription prices, working hours, and contact numbers.\n',
  ),
  const TextSpan(
    text:
        '- Trainers: Choose your trainer through this section. You will find specialized trainers based on your requirements, along with their portfolios and achievements. You can communicate with them through the application and subscribe to their services. If you are a trainer, you can create training courses for your players and easily select exercises. You have a database of over 1200 exercises with images, sound, and text. With just a click, your players will receive an electronic course that includes a diet plan, illustrated exercises, and dietary supplements.\n\n',
  ),
  const TextSpan(
    text:
        '5- Store: It can be found in the bar at the bottom of the main screen, the fourth icon from the right.\n\n',
  ),
  const TextSpan(
    text:
        '- It offers nutritional supplements for all your needs and goals, categorized according to the supplement\'s purpose. You can purchase supplements from the best agencies specialized in this field, with the freedom to pay electronically or upon delivery, and enjoy delivery to any location.\n\n',
  ),
  const TextSpan(
    text: '6- Educate Yourself: The first section on the left side.\n',
  ),
  const TextSpan(
    text:
        '- Articles: Here, sports articles are published by professional trainers.\n',
  ),
  const TextSpan(
    text:
        '- Diet Recipes: Here, diet recipes are published along with their preparation methods. You can also search for a specific recipe.\n',
  ),
  const TextSpan(
    text:
        '- Questions: If you have any questions, you can post them in this section, and they will be answered by experts and knowledgeable individuals. You can also search for a specific question that comes to mind.\n',
  ),
  const TextSpan(
    text:
        '7- My Day: In this important section, you will find your daily needs for calories, protein, carbohydrates, and healthy fats. When you add a meal you have consumed, it will deduct the nutritional value of the meal from your daily requirements. This way, you can track your remaining needs and organize your daily meals effectively.\n',
  ),
];
