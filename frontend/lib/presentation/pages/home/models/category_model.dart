class CategoryModel {
  final String name;
  final String imagePath;
  final String route;

  CategoryModel({
    required this.name,
    required this.imagePath,
    required this.route,
  });

  static List<CategoryModel> getCategories() {
    const String basePath = 'assets/images/home';

    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
      name: 'Skincare',
      imagePath: '$basePath/cat_skincare.png',
      route: '/',
    ));

    categories.add(CategoryModel(
      name: 'Ingredients',
      imagePath: '$basePath/cat_ingredients.png',
      route: '/',
    ));

    categories.add(CategoryModel(
        name: 'Recommend',
        imagePath: '$basePath/cat_skincare_rec.png',
        route: '/'));

    return categories;
  }
}
