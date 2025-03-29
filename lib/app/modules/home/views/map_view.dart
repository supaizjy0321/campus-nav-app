import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../controllers/home_controller.dart';
import '../../../data/models/floor_model.dart';

class MapView extends GetView<HomeController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: Stack(
            children: [
              _buildFloorMap(),
              Positioned(
                right: 16,
                top: 16,
                child: _buildFloorSelector(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: controller.updateSearchQuery,
        decoration: InputDecoration(
          hintText: 'Search for a room or person...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildFloorMap() {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              PhotoView(
                imageProvider: AssetImage(
                  controller.currentFloorData.imageUrl,
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              ..._buildRoomMarkers(controller.currentFloorData),
            ],
          ),
        ),
      );
    });
  }

  List<Widget> _buildRoomMarkers(Floor floor) {
    return floor.rooms.map((room) {
      return Positioned(
        left: room.x,
        top: room.y,
        child: GestureDetector(
          onTap: () {
            Get.snackbar(
              'Room Selected',
              'You selected ${room.name}',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.primary.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              room.id,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildFloorSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: controller.floors.reversed.map((floor) {
          return _buildFloorButton(floor);
        }).toList(),
      ),
    );
  }

  Widget _buildFloorButton(Floor floor) {
    return Obx(() {
      final isSelected = controller.currentFloorData.level == floor.level;
      return InkWell(
        onTap: () => controller.changeFloor(floor.level),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(Get.context!).colorScheme.primary : Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              floor.label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    });
  }
} 