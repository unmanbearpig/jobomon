import React, { PropTypes } from 'react';
import { Link } from 'react-router';
import { footer } from '../styles/footer.scss';

const App = ({ children }) =>
    <div>
        { children }
        <footer className={footer}>
            <Link to="/">Feeds</Link>
        </footer>
    </div>;

App.propTypes = {
    children: PropTypes.object
};

export default App;
