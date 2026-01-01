# MQTT Scout

**MQTT Scout** is a professional-grade, cross-platform MQTT client built with Flutter. It is designed to be intuitive for beginners while offering powerful features for experts, serving as a comprehensive tool for exploring and debugging MQTT environments.

![MQTT Scout Banner](https://placeholder-banner-url.com) <!-- Replace with actual banner if available, or remove -->

## 🚀 Key Features

- **Cross-Platform Support**: Runs smoothly on Linux, Windows, macOS, Android, and Web.
- **Dual Protocol Support**: Seamlessly supports both **MQTT 3.1.1** and **MQTT 5.0**.
  - Automatic protocol version detection and fallback.
- **Advanced Topic Visualization**:
  - Interactive **Topic Tree** to visualize broker structure.
  - Efficient handling of thousands of topics.
- **Robust Connection Management**:
  - Secure connections (TLS/SSL).
  - Configurable keep-alive, clean session, and LWT (Last Will and Testament).
  - Reconnection strategies with exponential backoff.
- **Message Inspection**:
  - Real-time message monitoring.
  - **Numeric Charts**: Visualize numeric data over time per topic.
  - Support for various payload formats (JSON, Text, Binary, etc.).
  - **Retained Message Management**: Inspect and clear retained messages directly from the UI.
- **Advanced Navigation**:
  - **Search & Filter**: Filter topics by name, regex, or retained status.
- **Privacy Focused**: No telemetry tracking. usage details stay local.

## 🛠️ Getting Started

### Prerequisites

- **Flutter SDK**: Ensure you have Flutter installed (version 3.10.4 or higher recommended).
- **Dart SDK**: Included with Flutter.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/mqtt_scout.git
    cd mqtt_scout
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run code generation (for Riverpod/Drift/Freezed):**
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

### Running the App

- **Linux (Desktop)**:
  ```bash
  flutter run -d linux
  ```

- **Windows (Desktop)**:
  ```bash
  flutter run -d windows
  ```

- **Android (Mobile)**:
  ```bash
  flutter run -d android
  ```

## 📖 Usage

1.  **Launch the Application**: Open MQTT Scout on your preferred device.
2.  **Add a Broker**:
    - Navigate to the connection screen.
    - Enter your broker details (Host, Port, Client ID).
    - Select Protocol Version (or leave Auto-Detect).
    - Click **Connect**.
3.  **Explore**:
    - Once connected, the **Topic Tree** will populate as messages arrive.
    - **Filter**: Use the search bar to filter by name/path. Toggle `.*` for regex or `Save Icon` for retained-only topics.
    - **Inspect**: Click on topics. If the topic has numeric data, a **Chart** will automatically display.
    - **Manage**: If a topic has a retained message, click the **Clear** button to remove it from the broker.
4.  **Publish**:
    - Use the Publish tool to send messages to specific topics with custom payloads and QoS settings.

## 🗺️ Roadmap

- [x] Core MQTT 3.1.1 & 5.0 Implementation
- [x] Basic Topic Tree Visualization
- [x] Cross-Platform UI (Desktop/Mobile)
- [x] Advanced Filters & Search
- [x] Numeric Charts & Visualizations
- [x] Retained Message Management
- [ ] Session Restoration (Persistence)

## 🤝 Contributing

Contributions are welcome! Please check out the [CONTRIBUTING.md](CONTRIBUTING.md) (coming soon) for guidelines.

1.  Fork the project.
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`).
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4.  Push to the branch (`git push origin feature/AmazingFeature`).
5.  Open a Pull Request.

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
