import React from 'react';
import { Route, IndexRoute } from 'react-router';
import App from './components/App';
import FeedList from './containers/FeedList';

export default (
	<Route path="/" component={App}>
		<IndexRoute component={FilterableTable} />
    <Route path="/feeds" component={FeedList} />
	</Route>
);
