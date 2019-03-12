// Rails packages
require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

// External styles and javascripts
require('materialize-css/dist/css/materialize.css');
require('materialize-css/dist/js/materialize.js');

require('react-materialize');

// Context configuration
var ReactRailsUJS = require('react_ujs');

var context = require.context('front', true, /^\.\/(front|common)/);

ReactRailsUJS.useContext(context);
