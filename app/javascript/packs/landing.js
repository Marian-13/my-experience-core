require('@rails/ujs').start();
require('turbolinks').start();

var frontRequireContext = require.context('front', true);

var ReactRailsUJS = require('react_ujs');

ReactRailsUJS.useContext(frontContext);
