require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

var frontContext = require.context('front', true);

var ReactRailsUJS = require('react_ujs');

ReactRailsUJS.useContext(frontContext);

function importAll (r) {
  console.log(r.keys());

  r.keys().forEach(r);
}

importAll(require.context('front', true, /^\.\/(front|common)\/.*\.(jsx)/));