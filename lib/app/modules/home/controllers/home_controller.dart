import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/floor_model.dart';

class HomeController extends GetxController {
  final currentFloor = 0.obs;
  final searchQuery = ''.obs;
  final selectedTab = 0.obs;
  final isLoading = false.obs;

  final List<Floor> floors = [
    Floor(
      level: 0,
      label: 'G',
      imageUrl: 'assets/images/ground-floor.jpg',
      rooms: [],
    ),
    Floor(
      level: 1,
      label: 'F1',
      imageUrl: 'assets/images/first-floor.jpg',
      rooms: [],
    ),
    Floor(
      level: 2,
      label: 'F2',
      imageUrl: 'assets/images/second-floor.jpg',
      rooms: [],
    ),
  ];

  Floor get currentFloorData => floors[currentFloor.value];

  final List<String> tabLabels = [
    'Map',
    'Search',
    'Navigation',
    'Settings',
  ];

  void changeFloor(int floor) {
    if (floor >= 0 && floor < floors.length) {
      currentFloor.value = floor;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    // TODO: Implement search functionality
  }

  void changeTab(int index) {
    selectedTab.value = index;
    // TODO: Implement tab-specific functionality
  }

  @override
  void onInit() {
    super.onInit();
    // Simulate loading time
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }
} 