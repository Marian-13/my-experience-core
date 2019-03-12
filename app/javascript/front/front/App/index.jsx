import React from 'react';

export default class App extends React.Component {
  render() {
    return (
      <React.Fragment>
        <div>Hello from Front</div>

        <button className="btn waves-effect waves-light" type="submit" name="action">Submit
          <i className="material-icons right">send</i>
        </button>
      </React.Fragment>
    );
  }
}
