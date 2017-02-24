import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import { fetchFeed } from '../actions';
import JobOffer from '../components/JobOffer';

const getFeed = (feeds, feedId) => {
  const defaultFeed = {
    id: feedId,
    title: 'Loading...',
    fetched: null
  };

  return feeds[feedId] || defaultFeed;
};

const getJobOffer = (jobOffers = {}, jobOfferId) => {
  return jobOffers[jobOfferId];
};

class FeedPage extends React.Component {
  componentDidMount() {
    this.props.fetchFeed(this.feed().id);
  }

  feed() {
    return getFeed(this.props.feeds, parseInt(this.props.params.feedId, 10));
  }

  jobOffers() {
    const arrayOfIds = this.feed().job_offers || [];

    return arrayOfIds
      .map((id) => getJobOffer(this.props.jobOffers, parseInt(id, 10)))
      .map(JobOffer);
  }

  render() {
    return (
        <div className={'feed'}>
        <h1>{this.feed().title}</h1>
        { this.jobOffers() }
      </div>
    );
  }
}

FeedPage.propTypes = {
  feeds: PropTypes.object,
  params: PropTypes.object,
  fetchFeed: PropTypes.func,
  jobOffers: PropTypes.object
};

const mapStateToProps = (state) => {
  return {
    feeds: state.feeds,
    jobOffers: state.jobOffers
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    fetchFeed: (feedId) => dispatch(fetchFeed(feedId))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(FeedPage);
