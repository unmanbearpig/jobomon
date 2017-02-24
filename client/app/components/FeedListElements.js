import React from 'react';

const FeedListElement = (feed) =>
      (
          <li key={feed.id}>
            {feed.title}
        </li>
      );

const FeedListElements = (feeds) => {
    if (typeof(feeds) === 'undefined') {
        return [];
    }

    return feeds.map(FeedListElement);
};

export default FeedListElements;
