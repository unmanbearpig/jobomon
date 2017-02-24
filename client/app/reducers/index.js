import { routerReducer as routing } from 'react-router-redux';
import { combineReducers } from 'redux';
import * as types from '../actions/types';

const feeds = (state = [], action) => {
  switch (action.type) {
  case types.RECEIVED_FEEDS:
    return action.feeds;
  default:
    return state;
  }
};

const rootReducer = combineReducers({
  feeds,
  routing
});

export default rootReducer;
