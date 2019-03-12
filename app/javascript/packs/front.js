require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

var ReactRailsUJS = require('react_ujs');

var context = require.context('front', true, /^\.\/(front|common)/);

ReactRailsUJS.useContext(context);
