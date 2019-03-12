require('@rails/ujs').start();
require('turbolinks').start();

var ReactRailsUJS = require('react_ujs');

var context = require.context('front', true, /^\.\/(landing|common)/);

ReactRailsUJS.useContext(context);
