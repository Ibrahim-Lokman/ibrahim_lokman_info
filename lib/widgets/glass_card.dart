import 'dart:ui';

import 'package:flutter/material.dart';

///G L A S S   E F E C T   C A R D
// class GlassCard extends StatelessWidget {
//   final Widget child;

//   const GlassCard({Key? key, required this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: Colors.white.withOpacity(0.2)),
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }

/// G L A S S  E F F E C T  C A R D  W I T H  D A R K  M O D E
// class GlassCard extends StatelessWidget {
//   final Widget child;
//   final bool isDarkMode;

//   const GlassCard({Key? key, required this.child, required this.isDarkMode})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: isDarkMode
//                 ? Colors.white.withOpacity(0.1)
//                 : Colors.white.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: isDarkMode
//                   ? Colors.white.withOpacity(0.1)
//                   : Colors.white.withOpacity(0.2),
//             ),
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }

/// Glass card with dark mode and selection
class GlassCard extends StatelessWidget {
  final Widget child;
  final bool isDarkMode;
  final bool isSelected;

  const GlassCard({
    super.key,
    required this.child,
    required this.isDarkMode,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? (isDarkMode ? Colors.white : Colors.blue)
                  : (isDarkMode
                      ? Colors.white.withOpacity(0.1)
                      : Colors.white.withOpacity(0.2)),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
