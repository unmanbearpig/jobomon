import React from 'react';
import { Link } from 'react-router';

const FeedListElement = (feed) => (
  <li key={feed.id}>
    <Link to={`/feed/${feed.id}`}>{feed.title}</Link>
  </li>
);

const FeedListElements = (feeds) => {
  if (typeof(feeds) === 'undefined') {
    return [];
  }

  return feeds.map(FeedListElement);
};

export default FeedListElements;
