import * as types from './types';

function requestFeeds() {
    return {
        type: types.REQUESTED_FEEDS
    };
}

function receivedFeeds(data) {
    return {
        type: types.RECEIVED_FEEDS,
        feeds: data.feeds
    };
}

export function fetchFeeds() {
    return(dispatch) => {
        dispatch(requestFeeds());

        return fetch('/api/feeds.json').
            then(response => response.json())
            .then(json =>
                  dispatch(receivedFeeds(json))
                 );
    };
}
