import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/models/mqtt_message.dart';
import '../../domain/models/broker_profile.dart';

/// Advanced JSON viewer with collapsible tree structure and MQTT 5.0 properties
class JsonViewerWidget extends StatefulWidget {
  final Map<String, dynamic> json;
  final MqttMessage? message;

  const JsonViewerWidget({
    super.key,
    required this.json,
    this.message,
  });

  @override
  State<JsonViewerWidget> createState() => _JsonViewerWidgetState();
}

class _JsonViewerWidgetState extends State<JsonViewerWidget> {
  final Set<String> _expandedNodes = {};
  String? _searchQuery;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        _buildSearchBar(),

        // MQTT 5.0 properties (if available)
        if (_shouldShowMqtt5Properties()) ...[
          _buildMqtt5Properties(),
          const Divider(),
        ],

        // JSON content
        Expanded(
          child: SingleChildScrollView(
            child: _buildJsonTree(widget.json, path: ''),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search JSON...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value.isEmpty ? null : value;
          });
        },
      ),
    );
  }

  bool _shouldShowMqtt5Properties() {
    return widget.message?.protocolVersion == MqttProtocolVersion.v5 &&
           (widget.message?.contentType != null ||
            widget.message?.responseTopic != null ||
            widget.message?.messageExpiryInterval != null ||
            (widget.message?.userProperties?.isNotEmpty ?? false));
  }

  Widget _buildMqtt5Properties() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'MQTT 5.0 Properties',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (widget.message?.contentType != null)
              _buildPropertyRow('Content Type', widget.message!.contentType!),
            if (widget.message?.responseTopic != null)
              _buildPropertyRow('Response Topic', widget.message!.responseTopic!),
            if (widget.message?.correlationData != null)
              _buildPropertyRow('Correlation Data', widget.message!.correlationData!.join(',')),
            if (widget.message?.messageExpiryInterval != null)
              _buildPropertyRow('Expires In', '${widget.message!.messageExpiryInterval}s'),
            if (widget.message?.userProperties?.isNotEmpty ?? false) ...[
              const SizedBox(height: 8.0),
              Text(
                'User Properties:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              ...widget.message!.userProperties!.entries.map(
                (entry) => _buildPropertyRow('  ${entry.key}', entry.value),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.0,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, size: 16.0),
            onPressed: () => _copyToClipboard(value),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 24.0,
              minHeight: 24.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJsonTree(dynamic data, {required String path, int depth = 0}) {
    if (data is Map<String, dynamic>) {
      return _buildJsonObject(data, path: path, depth: depth);
    } else if (data is List) {
      return _buildJsonArray(data, path: path, depth: depth);
    } else {
      return _buildJsonValue(data, path: path, depth: depth);
    }
  }

  Widget _buildJsonObject(Map<String, dynamic> obj, {required String path, required int depth}) {
    final isExpanded = _expandedNodes.contains(path);
    final hasChildren = obj.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: hasChildren ? () => _toggleExpansion(path) : null,
          child: Padding(
            padding: EdgeInsets.only(left: depth * 20.0),
            child: Row(
              children: [
                if (hasChildren)
                  Icon(
                    isExpanded ? Icons.expand_more : Icons.chevron_right,
                    size: 16.0,
                  )
                else
                  const SizedBox(width: 16.0),
                Text(
                  '{${obj.length}}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  path.isNotEmpty ? path.split('.').last : 'root',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          ...obj.entries.map((entry) {
            final childPath = path.isEmpty ? entry.key : '$path.${entry.key}';
            return _buildJsonTree(
              entry.value,
              path: childPath,
              depth: depth + 1,
            );
          }),
      ],
    );
  }

  Widget _buildJsonArray(List data, {required String path, required int depth}) {
    final isExpanded = _expandedNodes.contains(path);
    final hasChildren = data.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: hasChildren ? () => _toggleExpansion(path) : null,
          child: Padding(
            padding: EdgeInsets.only(left: depth * 20.0),
            child: Row(
              children: [
                if (hasChildren)
                  Icon(
                    isExpanded ? Icons.expand_more : Icons.chevron_right,
                    size: 16.0,
                  )
                else
                  const SizedBox(width: 16.0),
                Text(
                  '[${data.length}]',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  path.isNotEmpty ? path.split('.').last : 'array',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          ...data.asMap().entries.map((entry) {
            final childPath = '$path[${entry.key}]';
            return _buildJsonTree(
              entry.value,
              path: childPath,
              depth: depth + 1,
            );
          }),
      ],
    );
  }

  Widget _buildJsonValue(dynamic value, {required String path, required int depth}) {
    final displayValue = _formatValue(value);
    final isHighlighted = _searchQuery != null &&
                         displayValue.toLowerCase().contains(_searchQuery!.toLowerCase());

    return Container(
      color: isHighlighted ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3) : null,
      child: Padding(
        padding: EdgeInsets.only(left: depth * 20.0),
        child: Row(
          children: [
            SizedBox(
              width: 80.0,
              child: Text(
                path.isNotEmpty ? path.split('.').last : 'value',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              ': ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Expanded(
              child: Text(
                displayValue,
                style: TextStyle(
                  color: _getValueColor(value),
                  fontFamily: 'monospace',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.copy, size: 16.0),
              onPressed: () => _copyToClipboard(displayValue),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 24.0,
                minHeight: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatValue(dynamic value) {
    if (value is String) {
      return '"$value"';
    } else if (value == null) {
      return 'null';
    } else {
      return value.toString();
    }
  }

  Color _getValueColor(dynamic value) {
    if (value is String) return Colors.green;
    if (value is num) return Colors.blue;
    if (value is bool) return Colors.purple;
    if (value == null) return Colors.red;
    return Theme.of(context).colorScheme.onSurface;
  }

  void _toggleExpansion(String path) {
    setState(() {
      if (_expandedNodes.contains(path)) {
        _expandedNodes.remove(path);
      } else {
        _expandedNodes.add(path);
      }
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }
}