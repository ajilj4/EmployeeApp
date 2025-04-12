import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
// import '../../../../core/app_icons.dart';

class ClockCard extends StatefulWidget {
  final bool use24HourFormat;
  
  const ClockCard({
    super.key,
    this.use24HourFormat = false, // Default to 12-hour format
  });
  
  @override
  State<ClockCard> createState() => _ClockCardState();
}

class _ClockCardState extends State<ClockCard> {
  late DateTime _currentTime;
  late Timer _timer;
  
  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    
    // Update time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }
  
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  
  String get formattedTime {
    if (widget.use24HourFormat) {
      return DateFormat('HH:mm').format(_currentTime);
    } else {
      return DateFormat('hh:mm').format(_currentTime);
    }
  }
  
  String get formattedAmPm {
    return DateFormat('a').format(_currentTime);
  }
  
  String get formattedDate {
    return DateFormat('d MMMM yyyy').format(_currentTime);
  }
  
  String get dayName {
    return DateFormat('EEEE').format(_currentTime);
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width to make sizing responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1), // Light yellow background color
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background SVG is commented out as per your code
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 20, 
              vertical: isSmallScreen ? 16 : 24
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Use LayoutBuilder to get available width
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left side with time display
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Time display with responsive font size
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                formattedTime,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: isSmallScreen ? 30 : 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              if (!widget.use24HourFormat) 
                                Text(
                                  " $formattedAmPm",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: isSmallScreen ? 14 : 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Spacer for small screens
                    SizedBox(width: isSmallScreen ? 8 : 16),
                    
                    // Right side with shift info and button
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Shift Info - use FittedBox for text that might be too long
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "$dayName | General shift", 
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.w600, 
                                color: Colors.black87
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formattedDate, 
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isSmallScreen ? 12 : 14,
                              color: Colors.black54
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 16 : 25),
                          
                          // Clock-In Button - responsive width
                          SizedBox(
                            width: isSmallScreen ? 100 : 120,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Clock-In", 
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: isSmallScreen ? 16 : 18,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}