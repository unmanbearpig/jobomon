import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import { fetchFeeds } from '../actions';
import FeedListElements from '../components/FeedListElements';

const FeedList = ({ feeds, onClick }) => {
    return (
        <div className={'feeds'}>
            <button onClick={() => onClick() }>ClickMe</button>
            <ul>
                { FeedListElements(feeds) }
            </ul>
        </div>
    );
};

FeedList.propTypes = {
    feeds: PropTypes.array,
    onClick: PropTypes.func

};

const mapStateToProps = (state) => {
    return {
        feeds: state.feeds
    };
};

const mapDispatchToProps = (dispatch) => {
    return {
        onClick: () => dispatch(fetchFeeds())
    };
};

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(FeedList);
