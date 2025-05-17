import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final VoidCallback? onFilterTap;

  const SearchAppBar({super.key, required this.controller, this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff0B1E2D),
      automaticallyImplyLeading: false,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Color(0xff152A3A),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xff5B6975)),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                style: TextStyle(color: Colors.white),
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
