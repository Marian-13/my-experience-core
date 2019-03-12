var frontContext = require.context('front', true);

var ReactRailsUJS = require('react_ujs');

ReactRailsUJS.useContext(frontContext);