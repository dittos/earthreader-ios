from libearth.feed import Link
from libearth.parser.heuristic import get_format

def parse_feed(feed_xml, feed_url, content_type):
    parser = get_format(feed_xml)
    feed, crawler_hints = parser(feed_xml, feed_url)
    self_uri = None
    for link in feed.links:
        if link.relation == 'self':
            self_uri = link.uri
    if not self_uri:
        feed.links.append(Link(relation='self', uri=feed_url,
                               mimetype=content_type))
    feed.entries = sorted(feed.entries, key=lambda entry: entry.updated_at,
                          reverse=True)
    return feed_url, feed, crawler_hints