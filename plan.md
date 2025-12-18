# MQTT Explorer Development Roadmap
*A comprehensive plan for building a cross-platform MQTT client*

---

## 🎯 PHASE 0 — Vision & Scope Definition

### 0.1 Project Vision
Build a **professional-grade MQTT exploration tool** that's:
- Cross-platform (Desktop → Mobile → Web)
- Intuitive for beginners, powerful for experts
- Open source and community-driven
- Privacy-focused (no telemetry without consent)

### 0.2 Explicit Non-Goals
Being clear about what you're NOT building prevents scope creep:

❌ **Not building:**
- IoT device provisioning/management
- Cloud-specific integrations (AWS IoT, Azure IoT Hub)
- MQTT broker hosting
- Complex rule engines or automation
- Enterprise authentication (LDAP, OAuth initially)

✅ **We are building:**
- Universal MQTT client for exploration
- Cross-platform (Desktop + Mobile priority)
- Local-first with optional cloud sync
- **Full MQTT 3.1.1 AND 5.0 support from day one**
- Protocol version auto-detection and fallback

### 0.3 Target Platform Priority
1. **Linux** (primary development)
2. **Windows** 
3. **macOS**
4. **Android** (unique value proposition)
5. **iOS** (if resources allow)
6. **Web** (progressive enhancement)

### 0.4 Success Metrics
- Feature parity with MQTT Explorer (desktop) by Phase 8
- Functional mobile app by Phase 9
- 500+ GitHub stars within 6 months of launch
- Performance: Handle 10,000+ topics smoothly

---

## 🏗️ PHASE 1 — Project Foundation

### 1.1 Repository Setup

**Naming options** (check availability):
- `mqtt-lens` (visual inspection metaphor)
- `mqtt-scout` (exploration metaphor)
- `topicspy` (playful, memorable)
- `flutter-mqtt-studio`

**Initial structure:**
```
mqtt-explorer/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── workflows/
│   └── CONTRIBUTING.md
├── docs/
│   ├── architecture.md
│   ├── mqtt-basics.md
│   └── screenshots/
├── assets/
├── lib/
├── test/
├── LICENSE (MIT)
├── README.md
└── CHANGELOG.md
```

### 1.2 Flutter Project Initialization

```bash
# Create project
flutter create --org com.yourname mqtt_explorer
cd mqtt_explorer

# Enable all platforms
flutter config --enable-linux-desktop
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --enable-web

# Verify setup
flutter doctor -v
flutter devices
```

### 1.3 Core Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # MQTT - Support both versions
  mqtt_client: ^10.11.3          # MQTT 3.1.1
  mqtt5_client: ^4.2.0           # MQTT 5.0
  typed_data: ^1.3.2             # For binary handling

  # State Management
  riverpod: ^2.5.1
  flutter_riverpod: ^2.5.1

  # Storage
  drift: ^2.16.0
  drift_flutter: ^0.1.0
  sqlite3_flutter_libs: ^0.5.24
  path_provider: ^2.1.3
  shared_preferences: ^2.2.3

  # UI Components
  split_view: ^3.2.1
  flutter_treeview: ^1.1.0
  code_text_field: ^1.1.0
  flutter_highlight: ^0.7.0
  json_view: ^0.3.0

  # Utilities
  collection: ^1.18.0
  intl: ^0.19.0
  uuid: ^4.4.0
  equatable: ^2.0.5
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0

  # Icons & UI
  lucide_icons: ^0.1.0
  google_fonts: ^6.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.9
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  drift_dev: ^2.16.0
  flutter_lints: ^4.0.0
  mockito: ^5.4.4
```

### 1.4 Development Tools Setup

```bash
# Code generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode during development
flutter pub run build_runner watch
```

---

## 🧠 PHASE 2 — Architecture & Project Structure

### 2.1 Enhanced Folder Structure

```
lib/
├── app/
│   ├── app.dart
│   ├── router.dart
│   ├── theme.dart
│   └── constants.dart
│
├── core/
│   ├── mqtt/
│   │   ├── mqtt_service.dart
│   │   ├── mqtt_connection_manager.dart
│   │   ├── mqtt_subscription_manager.dart
│   │   ├── models/
│   │   │   ├── mqtt_connection_state.dart
│   │   │   └── mqtt_event.dart
│   │   └── exceptions/
│   │       └── mqtt_exceptions.dart
│   │
│   ├── parsing/
│   │   ├── payload_parser.dart
│   │   ├── payload_formatter.dart
│   │   ├── json_diff_calculator.dart
│   │   └── topic_matcher.dart
│   │
│   └── utils/
│       ├── logger.dart
│       ├── validators.dart
│       └── extensions.dart
│
├── domain/
│   ├── models/
│   │   ├── broker_profile.dart
│   │   ├── topic_node.dart
│   │   ├── mqtt_message.dart
│   │   ├── publish_template.dart
│   │   └── subscription.dart
│   │
│   └── repositories/
│       ├── broker_repository.dart
│       ├── message_repository.dart
│       └── settings_repository.dart
│
├── features/
│   ├── connection/
│   │   ├── presentation/
│   │   │   ├── connect_screen.dart
│   │   │   ├── broker_form.dart
│   │   │   └── connection_status_widget.dart
│   │   ├── providers/
│   │   │   └── connection_provider.dart
│   │   └── widgets/
│   │
│   ├── explorer/
│   │   ├── presentation/
│   │   │   ├── explorer_screen.dart
│   │   │   ├── topic_tree_view.dart
│   │   │   └── message_viewer.dart
│   │   ├── providers/
│   │   │   ├── topic_tree_provider.dart
│   │   │   └── message_filter_provider.dart
│   │   └── widgets/
│   │
│   ├── publish/
│   │   ├── presentation/
│   │   ├── providers/
│   │   └── widgets/
│   │
│   ├── history/
│   │   ├── presentation/
│   │   ├── providers/
│   │   └── widgets/
│   │
│   └── settings/
│       ├── presentation/
│       ├── providers/
│       └── widgets/
│
├── storage/
│   ├── database.dart
│   ├── database.g.dart
│   ├── daos/
│   │   ├── broker_dao.dart
│   │   ├── message_dao.dart
│   │   └── template_dao.dart
│   └── migrations/
│
└── shared/
    ├── widgets/
    │   ├── buttons/
    │   ├── inputs/
    │   └── layouts/
    └── dialogs/
```

### 2.2 Domain Models (with Freezed)

**Broker Profile:**
```dart
@freezed
class BrokerProfile with _$BrokerProfile {
  const factory BrokerProfile({
    required String id,
    required String name,
    required String host,
    @Default(1883) int port,
    @Default(false) bool useTls,
    String? username,
    String? password,
    required String clientId,
    @Default(60) int keepAlive,
    @Default(true) bool cleanSession,
    
    // Protocol version
    @Default(MqttProtocolVersion.v5) MqttProtocolVersion protocolVersion,
    @Default(true) bool autoDetectProtocol, // Try 5.0, fallback to 3.1.1
    
    // Last Will Testament (both versions)
    String? lastWillTopic,
    String? lastWillMessage,
    @Default(0) int lastWillQos,
    @Default(false) bool lastWillRetain,
    
    // MQTT 5.0 specific
    int? sessionExpiryInterval,
    int? maxPacketSize,
    int? topicAliasMaximum,
    Map<String, String>? userProperties,
    
    DateTime? lastConnected,
  }) = _BrokerProfile;

  factory BrokerProfile.fromJson(Map<String, dynamic> json) =>
      _$BrokerProfileFromJson(json);
}

enum MqttProtocolVersion { v3_1_1, v5 }
```

**Topic Node:**
```dart
class TopicNode {
  final String name;
  final String fullPath;
  final Map<String, TopicNode> children;
  
  MqttMessage? lastMessage;
  int messageCount;
  bool isRetained;
  DateTime? lastActivity;
  
  // For UI state
  bool isExpanded;
  bool isSubscribed;
  
  // Computed properties
  int get totalMessageCount => 
      messageCount + children.values.fold(0, (sum, child) => sum + child.totalMessageCount);
  
  bool get hasChildren => children.isNotEmpty;
}
```

**MQTT Message:**
```dart
@freezed
class MqttMessage with _$MqttMessage {
  const factory MqttMessage({
    required String id,
    required String topic,
    required String payload,
    required DateTime timestamp,
    @Default(0) int qos,
    @Default(false) bool retained,
    @Default(false) bool duplicate,
    PayloadType? detectedType,
    
    // MQTT version
    required MqttProtocolVersion protocolVersion,
    
    // MQTT 5.0 specific properties
    String? contentType,
    String? responseTopic,
    List<int>? correlationData,
    int? messageExpiryInterval,
    Map<String, String>? userProperties,
    List<String>? subscriptionIdentifiers,
  }) = _MqttMessage;
}

enum PayloadType { json, xml, text, number, boolean, binary, empty }
```

### 2.3 Architecture Principles

**Clean Architecture:**
- Domain layer: Pure Dart, no Flutter dependencies
- Features: One feature = one folder with presentation/providers/widgets
- Repository pattern: Abstract data access behind interfaces
- Provider pattern: Riverpod for state management

**Key patterns:**
- Single Responsibility Principle per class
- Repository pattern for data access
- Provider pattern for dependency injection
- Stream-based reactive programming
- Immutable state with Freezed

---

## 🔌 PHASE 3 — MQTT Core Implementation

### 3.1 Unified MQTT Service Architecture

**Design goals:**
- Support both MQTT 3.1.1 AND 5.0 from a single API
- Automatic protocol version detection and fallback
- Stream-based API (no callbacks)
- Automatic reconnection
- Connection lifecycle management
- Thread-safe operations

```dart
abstract class IMqttClient {
  Stream<MqttMessage> get messageStream;
  Stream<ConnectionState> get connectionStateStream;
  Stream<String> get errorStream;
  
  Future<void> connect(BrokerProfile profile);
  Future<void> disconnect();
  Future<void> subscribe(String topic, {int qos = 0});
  Future<void> unsubscribe(String topic);
  Future<void> publish(String topic, String payload, {
    int qos = 0, 
    bool retain = false,
    Map<String, String>? userProperties, // MQTT 5 only
  });
  
  ConnectionState get currentState;
  bool get isConnected;
  MqttProtocolVersion get negotiatedVersion;
}

class MqttService implements IMqttClient {
  mqtt_client.MqttClient? _clientV3;
  mqtt5_client.MqttClient? _clientV5;
  
  MqttProtocolVersion? _activeVersion;
  
  @override
  Future<void> connect(BrokerProfile profile) async {
    if (profile.autoDetectProtocol) {
      await _connectWithFallback(profile);
    } else {
      await _connectWithVersion(profile, profile.protocolVersion);
    }
  }
  
  Future<void> _connectWithFallback(BrokerProfile profile) async {
    // Try MQTT 5.0 first
    try {
      await _connectWithVersion(profile, MqttProtocolVersion.v5);
      _activeVersion = MqttProtocolVersion.v5;
      _log.info('Connected using MQTT 5.0');
    } catch (e) {
      _log.warning('MQTT 5.0 failed, falling back to 3.1.1: $e');
      
      // Fallback to MQTT 3.1.1
      try {
        await _connectWithVersion(profile, MqttProtocolVersion.v3_1_1);
        _activeVersion = MqttProtocolVersion.v3_1_1;
        _log.info('Connected using MQTT 3.1.1');
      } catch (e) {
        throw MqttConnectionException('Failed to connect with both protocols: $e');
      }
    }
  }
  
  Future<void> _connectWithVersion(
    BrokerProfile profile, 
    MqttProtocolVersion version,
  ) async {
    switch (version) {
      case MqttProtocolVersion.v5:
        await _connectV5(profile);
        break;
      case MqttProtocolVersion.v3_1_1:
        await _connectV3(profile);
        break;
    }
  }
  
  Future<void> _connectV5(BrokerProfile profile) async {
    _clientV5 = mqtt5_client.MqttClient(profile.host, profile.clientId);
    _clientV5!.port = profile.port;
    _clientV5!.secure = profile.useTls;
    _clientV5!.keepAlivePeriod = profile.keepAlive;
    
    // MQTT 5.0 specific properties
    final connectProperties = mqtt5_client.MqttConnectProperties();
    if (profile.sessionExpiryInterval != null) {
      connectProperties.sessionExpiryInterval = profile.sessionExpiryInterval;
    }
    if (profile.maxPacketSize != null) {
      connectProperties.maximumPacketSize = profile.maxPacketSize;
    }
    if (profile.topicAliasMaximum != null) {
      connectProperties.topicAliasMaximum = profile.topicAliasMaximum;
    }
    if (profile.userProperties != null) {
      profile.userProperties!.forEach((key, value) {
        connectProperties.userProperty.add(
          mqtt5_client.MqttUserProperty(key, value),
        );
      });
    }
    
    _setupV5Streams();
    
    await _clientV5!.connect(
      profile.username,
      profile.password,
      connectProperties: connectProperties,
    );
  }
  
  Future<void> _connectV3(BrokerProfile profile) async {
    _clientV3 = mqtt_client.MqttServerClient(profile.host, profile.clientId);
    _clientV3!.port = profile.port;
    _clientV3!.secure = profile.useTls;
    _clientV3!.keepAlivePeriod = profile.keepAlive;
    
    _setupV3Streams();
    
    await _clientV3!.connect(profile.username, profile.password);
  }
  
  @override
  Future<void> publish(
    String topic, 
    String payload, {
    int qos = 0,
    bool retain = false,
    Map<String, String>? userProperties,
  }) async {
    if (_activeVersion == MqttProtocolVersion.v5 && _clientV5 != null) {
      final builder = mqtt5_client.MqttPayloadBuilder();
      builder.addString(payload);
      
      final properties = mqtt5_client.MqttPublishProperties();
      if (userProperties != null) {
        userProperties.forEach((key, value) {
          properties.userProperty.add(mqtt5_client.MqttUserProperty(key, value));
        });
      }
      
      _clientV5!.publishMessage(
        topic,
        mqtt5_client.MqttQos.values[qos],
        builder.payload!,
        retain: retain,
        properties: properties,
      );
    } else if (_activeVersion == MqttProtocolVersion.v3_1_1 && _clientV3 != null) {
      final builder = mqtt_client.MqttPayloadBuilder();
      builder.addString(payload);
      
      _clientV3!.publishMessage(
        topic,
        mqtt_client.MqttQos.values[qos],
        builder.payload!,
        retain: retain,
      );
    }
  }
  
  @override
  MqttProtocolVersion get negotiatedVersion => 
      _activeVersion ?? MqttProtocolVersion.v3_1_1;
}
```

### 3.2 Connection State Machine

```dart
enum ConnectionState {
  disconnected,
  connecting,
  connected,
  disconnecting,
  reconnecting,
  error,
}

@freezed
class MqttConnectionEvent with _$MqttConnectionEvent {
  const factory MqttConnectionEvent.connected() = Connected;
  const factory MqttConnectionEvent.disconnected() = Disconnected;
  const factory MqttConnectionEvent.error(String message) = Error;
  const factory MqttConnectionEvent.reconnecting(int attempt) = Reconnecting;
}
```

### 3.3 Reconnection Strategy

**Exponential backoff with jitter:**
```dart
class ReconnectionStrategy {
  final int maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;
  
  Duration getDelay(int attempt) {
    final exponential = initialDelay * pow(2, attempt);
    final capped = min(exponential, maxDelay);
    final jitter = Random().nextDouble() * 0.3; // 30% jitter
    return capped * (1 + jitter);
  }
}

// Default: 1s → 2s → 4s → 8s → 16s → 30s (max)
```

### 3.4 Subscription Management

**Features:**
- Batch subscribe/unsubscribe
- Automatic resubscribe on reconnect
- Wildcard support (`+`, `#`)
- Subscription persistence
- **MQTT 5.0: Subscription options (no local, retain as published)**

```dart
@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required String topic,
    @Default(0) int qos,
    
    // MQTT 5.0 subscription options
    @Default(false) bool noLocal,
    @Default(false) bool retainAsPublished,
    @Default(RetainHandling.sendAtSubscribe) RetainHandling retainHandling,
  }) = _Subscription;
}

enum RetainHandling {
  sendAtSubscribe,
  sendAtSubscribeIfNew,
  doNotSend,
}

class SubscriptionManager {
  final Set<Subscription> _subscriptions = {};
  final MqttService _mqttService;
  
  Future<void> subscribe(Subscription subscription) async {
    _subscriptions.add(subscription);
    
    if (_mqttService.negotiatedVersion == MqttProtocolVersion.v5) {
      await _subscribeV5(subscription);
    } else {
      await _subscribeV3(subscription);
    }
  }
  
  Future<void> _subscribeV5(Subscription sub) async {
    final options = mqtt5_client.SubscriptionOptions();
    options.noLocal = sub.noLocal;
    options.retainAsPublished = sub.retainAsPublished;
    options.retainHandling = _convertRetainHandling(sub.retainHandling);
    
    await _mqttService._clientV5!.subscribe(
      sub.topic,
      mqtt5_client.MqttQos.values[sub.qos],
      subscriptionOptions: options,
    );
  }
  
  Future<void> _subscribeV3(Subscription sub) async {
    await _mqttService._clientV3!.subscribe(
      sub.topic,
      mqtt_client.MqttQos.values[sub.qos],
    );
  }
  
  Future<void> restoreSubscriptions() async {
    for (final sub in _subscriptions) {
      await subscribe(sub);
    }
  }
}
```

### 3.5 Discovery Mode

**Auto-subscribe to all topics:**
```dart
Future<void> enableDiscoveryMode() async {
  await subscribe('#', qos: 0);
  // This enables:
  // ✅ Real-time topic discovery
  // ✅ Retained message loading
  // ✅ Complete broker overview
  
  // MQTT 5.0 bonus: Use subscription identifiers
  if (_activeVersion == MqttProtocolVersion.v5) {
    final options = mqtt5_client.SubscriptionOptions();
    options.subscriptionIdentifier = 1; // Track discovery subscription
    
    await _clientV5!.subscribe(
      '#',
      mqtt5_client.MqttQos.atMostOnce,
      subscriptionOptions: options,
    );
  }
}
```

### 3.6 Protocol Version Indicator UI

**Show active protocol to user:**
```dart
class ProtocolVersionBadge extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(mqttServiceProvider.select(
      (service) => service.negotiatedVersion,
    ));
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: version == MqttProtocolVersion.v5 
            ? Colors.blue 
            : Colors.orange,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        version == MqttProtocolVersion.v5 ? 'MQTT 5.0' : 'MQTT 3.1.1',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
```

---

## 🌳 PHASE 4 — Topic Tree Engine

### 4.1 Tree Builder Algorithm

**Efficient insertion with path caching:**
```dart
class TopicTree {
  final TopicNode root = TopicNode(name: 'root', fullPath: '');
  final Map<String, TopicNode> _pathCache = {};
  
  void insertMessage(MqttMessage message) {
    final parts = message.topic.split('/');
    TopicNode current = root;
    final pathBuilder = StringBuffer();
    
    for (int i = 0; i < parts.length; i++) {
      final part = parts[i];
      pathBuilder.write(part);
      final currentPath = pathBuilder.toString();
      
      // Check cache first
      if (_pathCache.containsKey(currentPath)) {
        current = _pathCache[currentPath]!;
      } else {
        // Create new node
        if (!current.children.containsKey(part)) {
          current.children[part] = TopicNode(
            name: part,
            fullPath: currentPath,
          );
        }
        current = current.children[part]!;
        _pathCache[currentPath] = current;
      }
      
      pathBuilder.write('/');
    }
    
    // Update leaf node
    current.lastMessage = message;
    current.messageCount++;
    current.isRetained = message.retained;
    current.lastActivity = message.timestamp;
  }
}
```

### 4.2 Topic Expiration

**Remove inactive topics to prevent memory bloat:**
```dart
class TopicExpiration {
  final Duration inactivityThreshold;
  Timer? _cleanupTimer;
  
  void startCleanup(TopicTree tree) {
    _cleanupTimer = Timer.periodic(Duration(seconds: 30), (_) {
      _cleanupInactiveTopics(tree.root);
    });
  }
  
  void _cleanupInactiveTopics(TopicNode node) {
    final now = DateTime.now();
    node.children.removeWhere((name, child) {
      final inactive = child.lastActivity != null &&
          now.difference(child.lastActivity!) > inactivityThreshold;
      
      if (!inactive && child.hasChildren) {
        _cleanupInactiveTopics(child); // Recurse
      }
      
      return inactive && child.messageCount == 0;
    });
  }
}
```

### 4.3 Tree Virtualization

**Critical for performance with 10k+ topics:**
```dart
class VirtualizedTreeView extends StatelessWidget {
  final TopicNode root;
  final int maxVisibleDepth;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _calculateVisibleNodes(),
      itemBuilder: (context, index) {
        final node = _getVisibleNode(index);
        return TopicNodeTile(
          node: node,
          depth: _getDepth(node),
          onExpand: () => _toggleExpansion(node),
        );
      },
    );
  }
  
  // Only render expanded nodes and their immediate children
  List<TopicNode> _getVisibleNodes() {
    final visible = <TopicNode>[];
    _traverseVisible(root, visible, 0);
    return visible;
  }
}
```

### 4.4 Tree Statistics

```dart
class TreeStatistics {
  int totalTopics;
  int totalMessages;
  int retainedMessages;
  Map<int, int> qosDistribution;
  DateTime? oldestMessage;
  DateTime? newestMessage;
  
  static TreeStatistics calculate(TopicNode root) {
    // Traverse and compute stats
  }
}
```

---

## 👁️ PHASE 5 — Message Viewer

### 5.1 Intelligent Payload Parser

```dart
class PayloadParser {
  static PayloadType detectType(String payload) {
    if (payload.isEmpty) return PayloadType.empty;
    
    // Try JSON
    try {
      jsonDecode(payload);
      return PayloadType.json;
    } catch (_) {}
    
    // Try number
    if (double.tryParse(payload) != null) {
      return PayloadType.number;
    }
    
    // Try boolean
    if (payload.toLowerCase() == 'true' || payload.toLowerCase() == 'false') {
      return PayloadType.boolean;
    }
    
    // Try XML
    if (payload.trimLeft().startsWith('<')) {
      return PayloadType.xml;
    }
    
    // Check for binary (non-printable characters)
    if (_hasBinaryContent(payload)) {
      return PayloadType.binary;
    }
    
    return PayloadType.text;
  }
  
  static String format(String payload, PayloadType type) {
    switch (type) {
      case PayloadType.json:
        return _formatJson(payload);
      case PayloadType.xml:
        return _formatXml(payload);
      default:
        return payload;
    }
  }
}
```

### 5.2 Advanced JSON Viewer

**Features:**
- Collapsible tree structure
- Copy JSON path (e.g., `data.users[0].name`)
- Search within JSON
- Syntax highlighting
- **Display MQTT 5.0 properties if present**

```dart
class JsonViewerWidget extends StatelessWidget {
  final Map<String, dynamic> json;
  final MqttMessage? message;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show MQTT 5.0 metadata if available
        if (message?.protocolVersion == MqttProtocolVersion.v5) ...[
          _buildMqtt5Properties(message!),
          Divider(),
        ],
        
        // JSON content
        Expanded(
          child: JsonView.map(
            json,
            theme: JsonViewTheme(
              backgroundColor: Theme.of(context).cardColor,
              stringColor: Colors.green,
              numberColor: Colors.blue,
              boolColor: Colors.purple,
              nullColor: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildMqtt5Properties(MqttMessage message) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MQTT 5.0 Properties', 
              style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (message.contentType != null)
              _propertyRow('Content Type', message.contentType!),
            if (message.responseTopic != null)
              _propertyRow('Response Topic', message.responseTopic!),
            if (message.messageExpiryInterval != null)
              _propertyRow('Expires In', 
                '${message.messageExpiryInterval}s'),
            if (message.userProperties?.isNotEmpty ?? false) ...[
              Text('User Properties:', 
                style: TextStyle(fontSize: 12, color: Colors.grey)),
              ...message.userProperties!.entries.map((e) =>
                _propertyRow('  ${e.key}', e.value),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _propertyRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
```

### 5.3 Message Diff Engine

**Highlight what changed between messages:**
```dart
class MessageDiff {
  final List<DiffChunk> chunks;
  
  static MessageDiff compute(String oldPayload, String newPayload) {
    // Use Myers diff algorithm
    final diffs = diff(oldPayload.split('\n'), newPayload.split('\n'));
    
    return MessageDiff(
      chunks: diffs.map((d) => DiffChunk(
        type: d.operation,
        content: d.text,
      )).toList(),
    );
  }
}

class DiffViewer extends StatelessWidget {
  final MessageDiff diff;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: diff.chunks.length,
      itemBuilder: (context, index) {
        final chunk = diff.chunks[index];
        return Container(
          color: chunk.type == DiffType.added
              ? Colors.green.withOpacity(0.2)
              : chunk.type == DiffType.removed
                  ? Colors.red.withOpacity(0.2)
                  : Colors.transparent,
          child: Text(chunk.content),
        );
      },
    );
  }
}
```

### 5.4 Binary Payload Viewer

**Hex + ASCII view:**
```dart
class BinaryViewer extends StatelessWidget {
  final Uint8List bytes;
  
  String _toHexView() {
    final buffer = StringBuffer();
    for (int i = 0; i < bytes.length; i += 16) {
      // Address
      buffer.write('${i.toRadixString(16).padLeft(8, '0')}  ');
      
      // Hex bytes
      final chunk = bytes.sublist(i, min(i + 16, bytes.length));
      buffer.write(chunk.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' '));
      buffer.write('  ');
      
      // ASCII
      buffer.write(chunk.map((b) => b >= 32 && b < 127 ? String.fromCharCode(b) : '.').join());
      buffer.write('\n');
    }
    return buffer.toString();
  }
}
```

---

## 📨 PHASE 6 — Publish Panel

### 6.1 Publishing UI

**Components:**
- Topic input with autocomplete (from discovered topics)
- Multi-line payload editor with syntax highlighting
- QoS selector (0, 1, 2)
- Retain flag
- Template selector
- **MQTT 5.0 properties editor (conditional)**

```dart
class PublishPanel extends ConsumerStatefulWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final protocolVersion = ref.watch(mqttServiceProvider.select(
      (s) => s.negotiatedVersion,
    ));
    
    return Column(
      children: [
        // Topic input with autocomplete
        Autocomplete<String>(
          optionsBuilder: (textEditingValue) {
            return ref.read(topicTreeProvider)
                .getAllTopics()
                .where((topic) => topic.contains(textEditingValue.text));
          },
        ),
        
        // Payload editor
        CodeTextField(
          controller: _payloadController,
          language: json,
        ),
        
        // Basic options (both versions)
        Row(
          children: [
            DropdownButton<int>(
              value: _qos,
              items: [0, 1, 2].map((qos) => DropdownMenuItem(
                value: qos,
                child: Text('QoS $qos'),
              )).toList(),
              onChanged: (qos) => setState(() => _qos = qos!),
            ),
            Checkbox(
              value: _retain,
              onChanged: (retain) => setState(() => _retain = retain!),
            ),
            Text('Retain'),
          ],
        ),
        
        // MQTT 5.0 specific options
        if (protocolVersion == MqttProtocolVersion.v5) ...[
          Divider(),
          Text('MQTT 5.0 Properties', 
            style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            decoration: InputDecoration(labelText: 'Content Type'),
            onChanged: (v) => setState(() => _contentType = v),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Response Topic'),
            onChanged: (v) => setState(() => _responseTopic = v),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Message Expiry (seconds)',
            ),
            keyboardType: TextInputType.number,
            onChanged: (v) => setState(() => 
              _messageExpiry = int.tryParse(v)),
          ),
          
          // User properties
          ExpansionTile(
            title: Text('User Properties'),
            children: [
              ..._userProperties.entries.map((e) => ListTile(
                title: Text('${e.key}: ${e.value}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => setState(() => 
                    _userProperties.remove(e.key)),
                ),
              )),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Property'),
                onTap: _showAddPropertyDialog,
              ),
            ],
          ),
        ],
        
        // Publish button
        ElevatedButton(
          onPressed: _publish,
          child: Text('Publish'),
        ),
      ],
    );
  }
  
  Future<void> _publish() async {
    await ref.read(mqttServiceProvider).publish(
      _topicController.text,
      _payloadController.text,
      qos: _qos,
      retain: _retain,
      userProperties: _userProperties.isNotEmpty ? _userProperties : null,
    );
  }
}
```

### 6.2 Retained Message Management

**Clear retained messages:**
```dart
Future<void> clearRetainedMessage(String topic) async {
  await mqttService.publish(
    topic,
    '', // Empty payload
    retain: true,
  );
  
  // Update UI to reflect deletion
  topicTreeProvider.removeRetainedFlag(topic);
}
```

### 6.3 Publish Templates

**Save and reuse common publishes:**
```dart
@freezed
class PublishTemplate with _$PublishTemplate {
  const factory PublishTemplate({
    required String id,
    required String name,
    required String topic,
    required String payload,
    @Default(0) int qos,
    @Default(false) bool retain,
    
    // MQTT 5.0 properties
    String? contentType,
    String? responseTopic,
    int? messageExpiryInterval,
    Map<String, String>? userProperties,
    
    DateTime? createdAt,
  }) = _PublishTemplate;
}

class TemplateManager extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(publishTemplatesProvider);
    final protocolVersion = ref.watch(mqttServiceProvider.select(
      (s) => s.negotiatedVersion,
    ));
    
    return ListView.builder(
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        
        // Show warning if template has MQTT 5 props but connected as 3.1.1
        final hasV5Props = template.contentType != null ||
            template.responseTopic != null ||
            template.messageExpiryInterval != null ||
            (template.userProperties?.isNotEmpty ?? false);
        
        return ListTile(
          title: Text(template.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(template.topic),
              if (hasV5Props && 
                  protocolVersion == MqttProtocolVersion.v3_1_1)
                Text(
                  'Warning: MQTT 5.0 properties will be ignored',
                  style: TextStyle(color: Colors.orange, fontSize: 11),
                ),
            ],
          ),
          leading: Icon(
            hasV5Props ? Icons.filter_5 : Icons.filter_3,
            color: hasV5Props ? Colors.blue : Colors.orange,
          ),
          onTap: () => _loadTemplate(template),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteTemplate(template.id),
          ),
        );
      },
    );
  }
}
```

---

## 🔍 PHASE 7 — Search & Filtering

### 7.1 Topic Search

**Multi-mode search:**
```dart
enum SearchMode { plain, wildcard, regex }

class TopicSearch {
  final SearchMode mode;
  final String query;
  
  bool matches(String topic) {
    switch (mode) {
      case SearchMode.plain:
        return topic.toLowerCase().contains(query.toLowerCase());
      
      case SearchMode.wildcard:
        return _matchesWildcard(topic, query);
      
      case SearchMode.regex:
        return RegExp(query, caseSensitive: false).hasMatch(topic);
    }
  }
  
  bool _matchesWildcard(String topic, String pattern) {
    // Convert MQTT wildcards to regex
    // + matches one level, # matches multiple levels
    final regexPattern = pattern
        .replaceAll('+', '[^/]+')
        .replaceAll('#', '.*');
    return RegExp('^$regexPattern\$').hasMatch(topic);
  }
}
```

### 7.2 Payload Search

**Search across message history:**
```dart
class PayloadSearchProvider extends StateNotifier<AsyncValue<List<MqttMessage>>> {
  Future<void> search(String query, {bool caseSensitive = false}) async {
    state = const AsyncValue.loading();
    
    try {
      final results = await ref.read(messageRepositoryProvider)
          .searchPayloads(query, caseSensitive: caseSensitive);
      
      state = AsyncValue.data(results);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
```

### 7.3 Advanced Filters

**Composite filtering:**
```dart
class MessageFilter {
  final String? topicPattern;
  final PayloadType? payloadType;
  final DateTimeRange? timeRange;
  final List<int>? qosLevels;
  final bool? retainedOnly;
  
  bool matches(MqttMessage message) {
    if (topicPattern != null && !_topicMatches(message.topic)) {
      return false;
    }
    
    if (payloadType != null && message.detectedType != payloadType) {
      return false;
    }
    
    if (timeRange != null && !timeRange!.contains(message.timestamp)) {
      return false;
    }
    
    if (qosLevels != null && !qosLevels!.contains(message.qos)) {
      return false;
    }
    
    if (retainedOnly == true && !message.retained) {
      return false;
    }
    
    return true;
  }
}
```

---

## 📊 PHASE 8 — Visualization & Analytics

### 8.1 Numeric Value Detection

**Auto-charting for numeric topics:**
```dart
class NumericValueDetector {
  final Map<String, List<DataPoint>> _timeSeriesData = {};
  
  void processMessage(MqttMessage message) {
    final value = double.tryParse(message.payload);
    if (value != null) {
      _timeSeriesData
          .putIfAbsent(message.topic, () => [])
          .add(DataPoint(timestamp: message.timestamp, value: value));
      
      // Limit buffer size
      if (_timeSeriesData[message.topic]!.length > 1000) {
        _timeSeriesData[message.topic]!.removeAt(0);
      }
    }
  }
}
```

### 8.2 Real-time Charts

**Multi-topic overlay:**
```dart
class TopicChart extends ConsumerWidget {
  final List<String> topics;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartData = ref.watch(chartDataProvider(topics));
    
    return LineChart(
      LineChartData(
        lineBarsData: topics.map((topic) {
          final color = _getColorForTopic(topic);
          return LineChartBarData(
            spots: chartData[topic]!.map((point) => FlSpot(
              point.timestamp.millisecondsSinceEpoch.toDouble(),
              point.value,
            )).toList(),
            color: color,
            dotData: FlDotData(show: false),
          );
        }).toList(),
      ),
    );
  }
}
```

### 8.3 Traffic Analytics

**Real-time metrics:**
```dart
class TrafficAnalytics {
  final _messageRates = <DateTime, int>{};
  final _bytesPerSecond = <DateTime, int>{};
  
  void recordMessage(MqttMessage message) {
    final now = DateTime.now();
    final second = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    
    _messageRates[second] = (_messageRates[second] ?? 0) + 1;
    _bytesPerSecond[second] = (_bytesPerSecond[second] ?? 0) + message.payload.length;
  }
  
  double getMessagesPerSecond() {
    final now = DateTime.now();
    final lastSecond = now.subtract(Duration(seconds: 1));
    return _messageRates[lastSecond]?.toDouble() ?? 0.0;
  }
  
  Map<int, int> getQosDistribution() {
    // Calculate from recent messages
  }
}
```

### 8.4 Statistics Dashboard

**Overview panel:**
```dart
class StatisticsDashboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statisticsProvider);
    
    return GridView.count(
      crossAxisCount: 4,
      children: [
        _StatCard(
          title: 'Messages/sec',
          value: stats.messagesPerSecond.toStringAsFixed(1),
          icon: Icons.speed,
        ),
        _StatCard(
          title: 'Total Topics',
          value: stats.totalTopics.toString(),
          icon: Icons.topic,
        ),
        _StatCard(
          title: 'Active Subscriptions',
          value: stats.activeSubscriptions.toString(),
          icon: Icons.subscriptions,
        ),
        _StatCard(
          title: 'Data Rate',
          value: '${(stats.bytesPerSecond / 1024).toStringAsFixed(1)} KB/s',
          icon: Icons.data_usage,
        ),
      ],
    );
  }
}
```

---

## 💾 PHASE 9 — Data Persistence

### 9.1 Database Schema (Drift)

```dart
@DataClassName('BrokerEntity')
class Brokers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get profileId => text().unique()();
  TextColumn get name => text()();
  TextColumn get host => text()();
  IntColumn get port => integer()();
  BoolColumn get useTls => boolean().withDefault(const Constant(false))();
  TextColumn get username => text().nullable()();
  TextColumn get password => text().nullable()();
  
  // Protocol version
  IntColumn get protocolVersion => integer().withDefault(const Constant(5))(); // 3 or 5
  BoolColumn get autoDetectProtocol => boolean().withDefault(const Constant(true))();
  
  // MQTT 5.0 properties (stored as JSON)
  TextColumn get mqtt5Properties => text().nullable()(); // JSON blob
  
  DateTimeColumn get lastConnected => dateTime().nullable()();
}

@DataClassName('MessageEntity')
class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get messageId => text().unique()();
  TextColumn get brokerId => text()();
  TextColumn get topic => text()();
  TextColumn get payload => text()();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get qos => integer()();
  BoolColumn get retained => boolean()();
  
  // Protocol version and properties
  IntColumn get protocolVersion => integer()();
  TextColumn get mqtt5Properties => text().nullable()(); // JSON blob
}

@DataClassName('TemplateEntity')
class Templates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get templateId => text().unique()();
  TextColumn get name => text()();
  TextColumn get topic => text()();
  TextColumn get payload => text()();
  IntColumn get qos => integer()();
  BoolColumn get retain => boolean()();
  
  // MQTT 5.0 properties
  TextColumn get contentType => text().nullable()();
  TextColumn get responseTopic => text().nullable()();
  IntColumn get messageExpiryInterval => integer().nullable()();
  TextColumn get userProperties => text().nullable()(); // JSON map
}

@DataClassName('SessionEntity')
class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get brokerId => text()();
  TextColumn get expandedTopics => text()(); // JSON array
  TextColumn get activeFilters => text()(); // JSON object
  IntColumn get negotiatedProtocolVersion => integer().nullable()();
  DateTimeColumn get lastRestored => dateTime()();
}
```

### 9.2 Message History Management

**Configurable retention:**
```dart
class MessageHistoryManager {
  final int maxMessages;
  final Duration retentionPeriod;
  
  Future<void> cleanup() async {
    final cutoff = DateTime.now().subtract(retentionPeriod);
    await messageDao.deleteOlderThan(cutoff);
    
    // Also enforce max count
    final count = await messageDao.count();
    if (count > maxMessages) {
      await messageDao.deleteOldest(count - maxMessages);
    }
  }
}
```

### 9.3 Session Restore

**Resume where you left off:**
```dart
class SessionManager {
  Future<void> saveSession(String brokerId) async {
    final session = SessionEntity(
      brokerId: brokerId,
      expandedTopics: jsonEncode(
        topicTreeProvider.getExpandedTopics(),
      ),
      activeFilters: jsonEncode(
        filterProvider.getCurrentFilters(),
      ),
      lastRestored: DateTime.now(),
    );
    
    await sessionDao.upsert(session);
  }
  
  Future<void> restoreSession(String brokerId) async {
    final session = await sessionDao.getByBrokerId(brokerId);
    if (session != null) {
      topicTreeProvider.expandTopics(
        (jsonDecode(session.expandedTopics) as List).cast<String>(),
      );
      filterProvider.applyFilters(
        jsonDecode(session.activeFilters),
      );
    }
  }
}
```

### 9.4 Export/Import

**Data portability:**
```dart
class DataExporter {
  Future<File> exportBrokerProfile(String brokerId) async {
    final profile = await brokerDao.getById(brokerId);
    final messages = await messageDao.getByBroker(brokerId);
    final templates = await templateDao.getByBroker(brokerId);
    
    final data = {
      'version': '1.0',
      'broker': profile.toJson(),
      'messages': messages.map((m) => m.toJson()).toList(),
      'templates': templates.map((t) => t.toJson()).toList(),
    };
    
    final json = jsonEncode(data);
    final file = File('${profile.name}_export.json');
    await file.writeAsString(json);
    return file;
  }
}
```

---

## 🎨 PHASE 10 — UI/UX Excellence

### 10.1 Adaptive Layouts

**Desktop layout:**
```dart
class DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left sidebar: Topic tree
        SizedBox(
          width: 300,
          child: TopicTreePanel(),
        ),
        
        VerticalDivider(),
        
        // Center: Message viewer
        Expanded(
          flex: 2,
          child: MessageViewerPanel(),
        ),
        
        VerticalDivider(),
        
        // Right sidebar: Publish/History
        SizedBox(
          width: 350,
          child: TabBarView(
            children: [
              PublishPanel(),
              HistoryPanel(),
              AnalyticsPanel(),
            ],
          ),
        ),
      ],
    );
  }
}
```

**Mobile layout:**
```dart
class MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        TopicListScreen(),
        MessageDetailScreen(),
        PublishScreen(),
        SettingsScreen(),
      ],
    );
  }
}
```

### 10.2 Keyboard Shortcuts

```dart
class KeyboardShortcuts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK): 
            SearchIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyP): 
            PublishIntent(),
        LogicalKeySet(LogicalKeyboardKey.f5): 
            RefreshIntent(),
      },
      actions: {
        SearchIntent: CallbackAction<SearchIntent>(
          onInvoke: (_) => _showSearch(),
        ),
        // ... more actions
      },
      child: child,
    );
  }
}
```

### 10.3 Theme System

**Complete theming:**
```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    extensions: [
      MqttThemeExtension(
        topicColor: Colors.blue.shade700,
        retainedColor: Colors.orange.shade600,
        errorColor: Colors.red.shade700,
        jsonColor: Colors.green.shade700,
      ),
    ],
  );
  
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
  );
}
```

### 10.4 Accessibility

**WCAG compliance:**
- Minimum contrast ratios (4.5:1 for text)
- Semantic labels for screen readers
- Keyboard navigation
- Focus indicators
- Resizable text

---

## 🧪 PHASE 11 — Testing Strategy

### 11.1 Test Infrastructure

```dart
// Unit tests
test('TopicTree inserts message correctly', () {
  final tree = TopicTree();
  final message = MqttMessage(/* ... */);
  
  tree.insertMessage(message);
  
  expect(tree.root.children['home']?.children['temp'], isNotNull);
});

// Test protocol version handling
test('Service falls back to MQTT 3.1.1 when 5.0 fails', () async {
  final service = MqttService();
  final profile = BrokerProfile(
    autoDetectProtocol: true,
    protocolVersion: MqttProtocolVersion.v5,
  );
  
  await service.connect(profile);
  
  // Should have attempted 5.0 first, then fallen back
  expect(service.negotiatedVersion, equals(MqttProtocolVersion.v3_1_1));
});

// Widget tests
testWidgets('PublishPanel shows MQTT 5 fields only when connected as 5.0', 
  (tester) async {
  await tester.pumpWidget(PublishPanel());
  
  // Initially no MQTT 5 fields
  expect(find.text('Content Type'), findsNothing);
  
  // Connect as MQTT 5.0
  // ... connection logic ...
  await tester.pumpAndSettle();
  
  // Now MQTT 5 fields should appear
  expect(find.text('Content Type'), findsOneWidget);
});

// Integration tests
testWidgets('Full publish-subscribe flow with both protocols', (tester) async {
  // Test with MQTT 3.1.1
  await _testPublishSubscribe(tester, MqttProtocolVersion.v3_1_1);
  
  // Test with MQTT 5.0
  await _testPublishSubscribe(tester, MqttProtocolVersion.v5);
});
```

### 11.2 Test Brokers

**Local test setup:**
```bash
# Docker Compose for test environment
version: '3'
services:
  # MQTT 3.1.1 broker
  mosquitto_v3:
    image: eclipse-mosquitto:2
    ports:
      - "1883:1883"
    volumes:
      - ./mosquitto-v3.conf:/mosquitto/config/mosquitto.conf
  
  # MQTT 5.0 broker (same Mosquitto, different config)
  mosquitto_v5:
    image: eclipse-mosquitto:2
    ports:
      - "1884:1883"
    volumes:
      - ./mosquitto-v5.conf:/mosquitto/config/mosquitto.conf
```

**mosquitto-v5.conf:**
```
listener 1883
protocol mqtt
allow_anonymous true

# MQTT 5.0 specific settings
max_packet_size 268435456
max_topic_alias 10
```

**Test scenarios:**
- Connection/reconnection (both protocols)
- QoS levels (0, 1, 2)
- Retained messages
- Large payload handling
- Wildcard subscriptions
- High message rates (100+ msg/sec)
- **MQTT 5.0 specific:**
  - Topic aliases
  - Subscription options (noLocal, retainAsPublished)
  - User properties
  - Message expiry
  - Request/response pattern
  - Shared subscriptions
- **Protocol fallback:**
  - 5.0 → 3.1.1 automatic fallback
  - Feature degradation handling

### 11.3 Performance Benchmarks

```dart
void main() {
  group('Performance tests', () {
    test('Handle 10k topics efficiently', () async {
      final tree = TopicTree();
      final stopwatch = Stopwatch()..start();
      
      for (int i = 0; i < 10000; i++) {
        tree.insertMessage(MqttMessage(
          topic: 'devices/device_$i/sensor_${i % 10}/data',
          payload: '{"value": $i}',
        ));
      }
      
      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(1000)); // < 1 second
    });
    
    test('Message processing throughput', () async {
      // Should handle 1000 msg/sec
    });
  });
}
```

---

## 🚀 PHASE 12 — Release & Distribution

### 12.1 Build Configuration

**Desktop builds:**
```bash
# Linux
flutter build linux --release
# Creates build/linux/x64/release/bundle/

# Windows
flutter build windows --release
# Creates build/windows/runner/Release/

# macOS
flutter build macos --release
# Creates build/macos/Build/Products/Release/
```

**Mobile builds:**
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS (requires Mac)
flutter build ios --release
```

### 12.2 Packaging

**Linux (AppImage):**
```bash
# Use appimagetool
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage
./appimagetool-x86_64.AppImage mqtt-explorer.AppDir mqtt-explorer-x86_64.AppImage
```

**Windows (Installer):**
- Use Inno Setup or NSIS
- Include Visual C++ redistributables
- Create Start Menu shortcuts

**macOS (DMG):**
```bash
# Create DMG with background image
hdiutil create -volname "MQTT Explorer" -srcfolder build/macos/Build/Products/Release/mqtt_explorer.app -ov -format UDZO mqtt-explorer.dmg
```

### 12.3 Distribution Channels

**Desktop:**
- GitHub Releases (primary)
- Flathub (Linux)
- Microsoft Store (Windows)
- Mac App Store (macOS)

**Mobile:**
- Google Play Store
- F-Droid (open source)
- Apple App Store

### 12.4 Release Checklist

**Pre-release:**
- [ ] All tests passing
- [ ] Performance benchmarks met
- [ ] Security audit completed
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version numbers bumped
- [ ] Licenses verified

**Release artifacts:**
- [ ] Source code (GitHub tag)
- [ ] Linux AppImage
- [ ] Windows installer (.exe)
- [ ] macOS DMG
- [ ] Android APK + AAB
- [ ] Release notes
- [ ] Screenshots/demo video

### 12.5 Documentation

**Essential docs:**

1. **README.md**
   - Feature highlights with screenshots
   - Installation instructions per platform
   - Quick start guide
   - Links to detailed docs

2. **ARCHITECTURE.md**
   - System design overview
   - Component diagrams
   - Data flow
   - Extension points

3. **CONTRIBUTING.md**
   - Development setup
   - Code style guidelines
   - PR process
   - Testing requirements

4. **User Guide**
   - Connection setup
   - Topic exploration
   - Publishing messages
   - Advanced features
   - Troubleshooting

---

## 🎯 Success Criteria & Metrics

### Success Criteria & Metrics

### Feature Completeness
- ✅ **Full MQTT 3.1.1 support** (required)
- ✅ **Full MQTT 5.0 support** (required)
- ✅ **Automatic protocol detection and fallback**
- ✅ TLS/SSL connections (both versions)
- ✅ All QoS levels (0, 1, 2)
- ✅ Retained messages
- ✅ Topic tree visualization
- ✅ Real-time updates
- ✅ Message history
- ✅ Publish functionality
- ✅ **MQTT 5.0 enhanced features:**
  - User properties
  - Content type
  - Response topics
  - Message expiry
  - Subscription options
  - Topic aliases (display only)

### Performance Targets
- Handle 10,000+ topics without lag
- Process 1,000 messages/second
- Memory usage < 500MB with 10k topics
- Startup time < 3 seconds
- UI stays responsive during high traffic

### Quality Metrics
- 80%+ code coverage
- Zero critical security vulnerabilities
- < 10 open bugs on launch
- Load time < 2 seconds
- Crash rate < 0.1%

### Adoption Goals
- 500+ GitHub stars (6 months)
- 5,000+ downloads (1 year)
- 50+ contributors
- Featured on Flutter Showcase
- Mentioned in MQTT community resources

---

## 🔮 Future Enhancements (Post-Launch)

### Phase 13 — Advanced MQTT 5.0 Features
- **Shared subscriptions**: `$share/group/topic`
- **Request-response pattern**: Automated response topic handling
- **Flow control**: Receive maximum handling
- **Enhanced auth**: SCRAM-SHA-256, extended authentication
- **Topic aliases**: Full implementation (send and receive)
- **Subscription identifiers**: Track which subscription matched

### Phase 14 — Scripting & Automation
- **JavaScript/Lua scripts**: Transform messages on publish/receive
- **Payload templates**: Dynamic variables and functions
- **Auto-republish rules**: Based on message content
- **Scheduled publishing**: Cron-like message scheduling

### Phase 15 — Enterprise Features
- **SSO/SAML**: Enterprise authentication
- **Audit logs**: Compliance tracking
- **Role-based access**: Multi-user permissions
- **HA support**: Multiple broker failover
- **Monitoring**: Prometheus metrics export
- **Cloud sync**: Optional backup to cloud storage

### Phase 16 — Developer Tools
- **Mock broker**: Built-in test broker (both 3.1.1 and 5.0)
- **Traffic recording**: Record/replay sessions with protocol info
- **Load testing**: Synthetic message generation
- **API client**: REST API for automation
- **CI/CD integration**: Command-line interface
- **Protocol analyzer**: Deep packet inspection

---

## 🧭 Development Best Practices

### Code Quality
- Follow Flutter style guide
- Use `flutter analyze` and `dart format`
- Enable all lints from `flutter_lints`
- Write dartdoc comments for public APIs
- Keep functions under 50 lines

### Git Workflow
- Feature branches: `feature/topic-tree-virtualization`
- Commit messages: Conventional Commits format
- PR template with checklist
- Require reviews for main branch
- Automated CI checks

### Performance
- Profile before optimizing
- Use `const` constructors everywhere possible
- Implement lazy loading for large lists
- Cache expensive computations
- Monitor memory leaks with DevTools

### Security
- Never store passwords in plain text (use `flutter_secure_storage`)
- Validate all user input
- Use TLS for production brokers
- Implement certificate pinning for sensitive deployments
- Regular dependency audits

---

## 📚 Learning Resources

### MQTT Protocol
- [MQTT.org specifications](https://mqtt.org/mqtt-specification/)
- HiveMQ blog and tutorials
- Eclipse Mosquitto documentation

### Flutter Desktop
- [Flutter Desktop documentation](https://docs.flutter.dev/platform-integration/desktop)
- Flutter Desktop Embedding examples
- Platform channel implementation

### Architecture Patterns
- Riverpod documentation
- Clean Architecture in Flutter
- Domain-Driven Design basics

---

## 🎬 Conclusion

This roadmap transforms your MQTT Explorer from concept to production-ready application. Key success factors:

1. **Start small, iterate quickly**: Build Phase 0-3 first, get basic MQTT working
2. **Quality over speed**: Invest time in architecture (Phase 2) to avoid rewrites
3. **Test continuously**: Don't skip Phase 11 testing
4. **Engage community early**: Share progress, gather feedback
5. **Document as you go**: Future you (and contributors) will thank you

**Estimated timeline:**
- Phases 0-6: 3-4 months (MVP with both protocols)
- Phases 7-10: 2-3 months (polish + full MQTT 5 support)
- Phases 11-12: 1-2 months (testing + release)
- **Total: 6-9 months** to production-ready v1.0

**Key differentiators:**
✅ Only mobile MQTT client with full 5.0 support
✅ Automatic protocol detection and graceful fallback
✅ Best-in-class desktop experience
✅ First Flutter app to showcase both protocols

You're not just building an MQTT client—you're creating the de facto cross-platform MQTT tool that works seamlessly with both MQTT 3.1.1 legacy systems and cutting-edge MQTT 5.0 deployments. This dual-protocol support positions MQTT Scout as the universal tool for MQTT debugging and exploration.

**Now go build it! 🚀**
