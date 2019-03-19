// Rails packages
require('@rails/ujs').start();
require('turbolinks').start();

// External global styles and javascripts
require('materialize-css/dist/css/materialize.css');
require('materialize-css/dist/js/materialize.js');

// Context configuration
var ReactRailsUJS = require('react_ujs');

var context = require.context('front', true, /^\.\/(landing|common)/);

ReactRailsUJS.useContext(context);
