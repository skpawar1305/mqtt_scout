import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Binary payload viewer with hex and ASCII representation
class BinaryViewer extends StatelessWidget {
  final Uint8List bytes;

  const BinaryViewer({
    super.key,
    required this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with size info
        _buildHeader(context),

        // Hex/ASCII view
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                _toHexView(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        children: [
          Icon(
            Icons.memory,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8.0),
          Text(
            'Binary Data (${bytes.length} bytes)',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () => _copyHexToClipboard(context),
            tooltip: 'Copy hex dump',
          ),
        ],
      ),
    );
  }

  String _toHexView() {
    final buffer = StringBuffer();

    // Header
    buffer.writeln('Address  00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F  ASCII');
    buffer.writeln('-------- -----------------------------------------------  ----------------');

    for (int i = 0; i < bytes.length; i += 16) {
      // Address
      buffer.write('${i.toRadixString(16).padLeft(8, '0')}  ');

      // Hex bytes
      final chunk = bytes.sublist(i, i + 16 > bytes.length ? bytes.length : i + 16);
      for (int j = 0; j < 16; j++) {
        if (j < chunk.length) {
          buffer.write('${chunk[j].toRadixString(16).padLeft(2, '0')} ');
        } else {
          buffer.write('   ');
        }
      }

      // ASCII representation
      buffer.write(' ');
      for (int j = 0; j < chunk.length; j++) {
        final byte = chunk[j];
        if (byte >= 32 && byte < 127) {
          buffer.write(String.fromCharCode(byte));
        } else {
          buffer.write('.');
        }
      }

      buffer.writeln();
    }

    return buffer.toString();
  }

  void _copyHexToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _toHexView()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Hex dump copied to clipboard')),
    );
  }
}