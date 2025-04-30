import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final VoidCallback? onFilterTap;

  const SearchAppBar({super.key, required this.controller, this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xffF2F2F2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xff5B6975)), // Иконка поиска
            SizedBox(width: 8), // Отступ между иконкой и текстом
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Search character...',
                  hintStyle: TextStyle(color: Color(0xffBDBDBD)),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.filter_alt_outlined,
                color: Color(0xff5B6975),
              ),
              onPressed: onFilterTap,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
