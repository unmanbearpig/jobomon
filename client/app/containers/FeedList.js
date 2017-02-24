import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import { fetchFeeds } from '../actions';
import FeedListElements from '../components/FeedListElements';

class FeedList extends React.Component {
  componentDidMount() {
    this.props.fetchFeeds();
  }

  render() {
    return (
      <div className={'feeds'}>
            <button onClick={() => this.props.fetchFeeds() }>Refresh</button>
            <ul>
                { FeedListElements(this.props.feeds) }
            </ul>
        </div>
    );
  }
}

FeedList.propTypes = {
    feeds: PropTypes.array,
    fetchFeeds: PropTypes.func
};

const mapStateToProps = (state) => {
    return {
      feeds: Object.values(state.feeds)
    };
};

const mapDispatchToProps = (dispatch) => {
    return {
      fetchFeeds: () => dispatch(fetchFeeds())
    };
};

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(FeedList);
