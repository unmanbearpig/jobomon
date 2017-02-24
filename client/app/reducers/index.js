import { routerReducer as routing } from 'react-router-redux';
import { combineReducers } from 'redux';
import * as types from '../actions/types';

const arrayToObjectById = (array) =>
      array.reduce((acc, object) => {
        acc[object.id] = object;
        return acc;
      }, {});

const extractIdsFromArrayOfObjects = (arrayOfObjects) => {
  return arrayOfObjects.map((object) => object.id);
};

const jobOffers = (state = {}, action) => {
  const feed = action.feed || { job_offers: [] };

  switch (action.type) {
  case types.RECEIVED_FEED:
    return Object.assign({}, state, arrayToObjectById(feed.job_offers));
  default:
    return state;
  }
};

const receivedFeed = (state = {}, feed) => {
  const stateUpdate = {};
  stateUpdate[feed.id] = feed;
  stateUpdate[feed.id].job_offers = extractIdsFromArrayOfObjects(feed.job_offers);

  return Object.assign({}, state, stateUpdate);
};

const feeds = (state = {}, action) => {
  switch (action.type) {
  case types.RECEIVED_FEEDS:
    return arrayToObjectById(action.feeds);
  case types.RECEIVED_FEED:
    return receivedFeed(state, action.feed);
  default:
    return state;
  }
};

const rootReducer = combineReducers({
  jobOffers,
  feeds,
  routing
});

export default rootReducer;
