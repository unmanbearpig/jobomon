import React from 'react';
import { Route, IndexRoute } from 'react-router';
import App from './components/App';
import FeedList from './containers/FeedList';
import FeedPage from './containers/FeedPage';

export default (
	<Route path="/" component={App}>
		<IndexRoute component={FeedList} />
    <Route path="/feed/:feedId" component={FeedPage} />
	</Route>
);
