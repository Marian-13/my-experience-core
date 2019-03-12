var ReactRailsUJS = require('react_ujs');

var context = require.context('front', true);

ReactRailsUJS.useContext(context);
