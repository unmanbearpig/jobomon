import React, { PropTypes } from 'react';
import { connect } from 'react-redux';

// TODO: move to selectors
const getFeed = (feeds, feedId) => {
  const defaultFeed = {
    title: 'Loading...'
  };

  return feeds[feedId] || defaultFeed;
};

const FeedPage = ({ feeds, params }) => {
  const feed = getFeed(feeds, parseInt(params.feedId, 10));

  return (
      <div className={'feed'}>
        <h1>{feed.title}</h1>
      </div>
  );
};

FeedPage.propTypes = {
  feeds: PropTypes.object,
  params: PropTypes.object
};

const mapStateToProps = (state) => {
  return {
    feeds: state.feeds
  };
};

const mapDispatchToProps = (dispatch) => {
  dispatch;
  return {

  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(FeedPage);
