import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final VoidCallback? onFilterTap;

  const SearchAppBar({super.key, required this.controller, this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffF2F2F2),
      automaticallyImplyLeading: false,
      title: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          hintText: 'Search character...',
          hintStyle: TextStyle(color: Color(0xffBDBDBD)),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Color(0xff5B6975)),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list, color: Color(0xff5B6975)),
          onPressed: onFilterTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
