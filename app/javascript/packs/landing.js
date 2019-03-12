require('@rails/ujs').start();
require('turbolinks').start();

var componentRequireContext = require.context('components', true);
var ReactRailsUJS = require('react_ujs');

ReactRailsUJS.useContext(componentRequireContext);
