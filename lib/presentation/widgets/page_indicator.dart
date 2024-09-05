import 'package:flutter/material.dart';

class CustomNumberPagination extends StatefulWidget {
  final int totalPages;
  final int currentPage;
  final Function(int) onPageChanged;

  const CustomNumberPagination({
    super.key,
    required this.totalPages,
    required this.onPageChanged,
    required this.currentPage,
  });

  @override
  State<CustomNumberPagination> createState() => _CustomNumberPaginationState();
}

class _CustomNumberPaginationState extends State<CustomNumberPagination> {
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget
        .currentPage; // Initialize with the currentPage passed from the parent
  }

  @override
  void didUpdateWidget(covariant CustomNumberPagination oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update _currentPage if the parent changes it during runtime like setState
    if (widget.currentPage != oldWidget.currentPage) {
      setState(() {
        _currentPage = widget.currentPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _currentPage > 1 ? _previousPage : null,
        ),
        ...List.generate(widget.totalPages, (index) {
          final pageNumber = index + 1;
          return _buildPageButton(pageNumber);
        }),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: _currentPage < widget.totalPages ? _nextPage : null,
        ),
      ],
    );
  }

  Widget _buildPageButton(int pageNumber) {
    final isCurrentPage = pageNumber == _currentPage;
    final isWithinRange = (pageNumber - _currentPage).abs() <= 1 ||
        pageNumber <= 2 ||
        pageNumber >= widget.totalPages - 1;

    if (!isWithinRange &&
        pageNumber != 2 &&
        pageNumber != widget.totalPages - 1) {
      return pageNumber == 3 || pageNumber == widget.totalPages - 2
          ? const Text('...', style: TextStyle(fontSize: 20))
          : const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isCurrentPage ? const Color(0xff6359e8) : Colors.grey[200],
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
        ),
        child: Text(
          pageNumber.toString(),
          style: TextStyle(
            color: isCurrentPage ? Colors.white : Colors.black,
          ),
        ),
        onPressed: () => _onPageButtonPressed(pageNumber),
      ),
    );
  }

  void _onPageButtonPressed(int pageNumber) {
    setState(() {
      _currentPage = pageNumber;
    });
    widget.onPageChanged(_currentPage);
  }

  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      widget.onPageChanged(_currentPage);
    }
  }

  void _nextPage() {
    if (_currentPage < widget.totalPages) {
      setState(() {
        _currentPage++;
      });
      widget.onPageChanged(_currentPage);
    }
  }
}
