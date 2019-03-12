import React from 'react';

import Header from '../../front/components/Header';

export default class App extends React.Component {
  render() {
    return (
      <React.Fragment>
        <Header />
        <div>Hello from Front</div>
      </React.Fragment>
    );
  }
}
