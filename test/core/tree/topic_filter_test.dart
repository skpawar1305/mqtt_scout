import 'package:flutter_test/flutter_test.dart';
import 'package:mqtt_scout/core/tree/topic_node.dart';
import 'package:mqtt_scout/core/tree/topic_filter.dart';

void main() {
  group('TopicNode Filtering', () {
    late TopicNode root;
    late TopicNode childA;
    late TopicNode childB;
    late TopicNode childAB;

    setUp(() {
      root = TopicNode(name: 'root', fullPath: '');
      childA = TopicNode(name: 'a', fullPath: 'a');
      childB = TopicNode(name: 'b', fullPath: 'b');
      childAB = TopicNode(name: 'b', fullPath: 'a/b'); // child of a
      
      root.children['a'] = childA;
      root.children['b'] = childB;
      childA.children['b'] = childAB;
    });

    test('Empty filter returns normal nodes', () {
      final nodes = root.getVisibleNodes();
      // Only immediate children are visible by default if collapsed?
      // Wait, _collectVisibleNodes logic: root(empty path) -> always expand.
      // a and b are visible.
      // a is not expanded, so a/b is not visible.
      expect(nodes.map((n) => n.name), containsAll(['a', 'b']));
      expect(nodes.map((n) => n.name), isNot(contains('b '))); // Just checking unique
      expect(nodes.length, 2);
    });

    test('Filter matches node name', () {
      // Filter 'a' matches childA and childAB (parent 'a' matches, childAB has 'a' in path too?)
      // Filter matches name or path.
      
      final filter = TopicFilter(query: 'a');
      final result = root.getVisibleNodes(filter: filter);
      
      // Expected:
      // a matches.
      // b doesn't match.
      // a/b (childAB) fullpath 'a/b' matches 'a'.
      
      // Since 'a' matches, we show it.
      // Since childAB matches, we show it too?
      // Yes, if descendant matches or self matches.
      
      // Wait, if parent matches, do we show ALL children?
      // My logic: selfMatches || anyChildMatches.
      // if selfMatches, we return TRUE.
      // But do we add children to result if ONLY self matches?
      // Logic: 
      // Iterate children. Recurse.
      // If child returns true, add child.
      // If self matches OR anyChildMatches, add self.
      
      // So if 'a' matches, but childAB (name 'b') doesn't...
      // wait, 'a/b' contains 'a'. So childAB matches.
      
      // Let's test specific name match. 'b'.
      // root -> b (childB). Match.
      // root -> a (no match on name 'b', path 'a').
      // root -> a -> b (childAB). Match.
      
      // So 'a' should be included because 'childAB' matches.
      // 'childB' should be included.
      
      // Result: a, childAB, b.
      // Order: a, childAB, b (because 'a' < 'b' in root children).
      // Note: childAB is child of a.
      
      final filterB = TopicFilter(query: 'b');
      final resultB = root.getVisibleNodes(filter: filterB);
      
      final names = resultB.map((n) => n.fullPath).toList();
      expect(names, containsAll(['a', 'a/b', 'b']));
    });

    test('Filter regex', () {
        final filter = TopicFilter(query: '^b\$', isRegex: true);
        // Should match only 'b' (childB) and 'a/b' (name 'b')?
        // Logic checks name OR fullPath.
        // childB name 'b', fullpath 'b'. Match.
        // childAB name 'b', fullpath 'a/b'. Name match.
        // childA name 'a'. No match.
        // But childAB matches, so childA is included as parent.
        
        final result = root.getVisibleNodes(filter: filter);
        final names = result.map((n) => n.fullPath).toList();
        expect(names, containsAll(['a', 'a/b', 'b']));
    });

    test('Filter retained only', () {
      childAB.isRetained = true;
      final filter = TopicFilter(showRetainedOnly: true);
      
      final result = root.getVisibleNodes(filter: filter);
      // Expected: a (parent), childAB (retained).
      // b (not retained) excluded.
      
      final names = result.map((n) => n.fullPath).toList();
      expect(names, containsAll(['a', 'a/b']));
      expect(names, isNot(contains('b')));
    });
  });
}
