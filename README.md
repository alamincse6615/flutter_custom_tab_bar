# 🚀 Flutter Custom TabBar with CustomPainter 🎨

**একটি Pure Flutter Project** — এখানে **CustomPainter** দিয়ে বানানো একটি Flexible TabBar আছে যা ১, ২ অথবা ৩টি Tab এর জন্য compatible!

---

## 📌 Features

✅ Fully **CustomPainter** TabBar  
✅ Supports **1, 2, or 3 Tabs**  
✅ Each Tab has unique shape (Left, Center, Right, Single)  
✅ Smooth state management — **StatefulWidget**  
✅ No extra dependencies  
✅ Hot reload friendly  
✅ Clean UI — Active tab gets painter, inactive tabs stay simple

---

## 📸 Screenshots

| 1 Tab | 2 Tabs | 3 Tabs |
|-------|--------|--------|
| ![1 Tab](assets/1_tab.png) | ![2 Tabs](assets/2_tabs.png) | ![3 Tabs](assets/3_tabs.png) |


---

## ⚙️ How it works

- `TabPainter5` class handles all shapes using **Path & Bezier curves**
- `MyTabBar` dynamically sets `TabStyle` based on number of tabs
- `MyTab` only paints active tab — inactive tabs are simple clickable TextButtons
- `TabController` manages tab state smoothly

---

## 🏗️ Installation

```bash
git clone https://github.com/alamincse6615/flutter_custom_tab_bar
cd custom_tabbar_flutter
flutter pub get
flutter run
```

---

## 🧩 Project Structure

```
lib/
 ├── main.dart
 ├── tab_painter.dart
 ├── my_tab_bar.dart
```

*(এই structure চাইলে আরও ভাগ করে রাখতে পারো)*

---

## 🫶 Contribution

Pull requests are welcome!  
Bug/feature idea থাকলে issue খুলে জানাও 🚀

---

## 📚 License

MIT License © 2024 Your Name

---

## 🔗 Connect with Me

- 💼 [LinkedIn](https://www.linkedin.com/in/alamincse6615/)
- 📧 alamincse6615@gmail.com

---

**Made with ❤️ in Flutter**