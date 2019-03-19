import React from 'react';

import axios from 'axios';
import {
  Button,
  Card,
  Input,
  Row,
  Toast
} from 'react-materialize';

export default class LoginForm extends React.Component {
  state = {
    email: '',
    password: ''
  }

  handleEmailChange = (_event, email) => {
    this.setState({ email });
  }

  handlePasswordChange = (_event, password) => {
    this.setState({ password });
  }

  handleLogin = (_, $) => {
    const { email, password } = this.state;
    const data = { auth: { email, password } };

    axios.post('/user_token', data)
      .then((response) => {
        document.addEventListener('turbolinks:request-start', event => {
          const xhr = event.data.xhr;

          xhr.setRequestHeader('Authorization', `Bearer ${response.data.data.token}`);
        }, { once: true });

        Turbolinks.visit('/');
      })
      .catch((error) => {
        M.toast({ html: 'Invalid email and/or password.' })
      });
  }

  render() {
    return (
      <React.Fragment>
        <Card>
          <Row>
            <h5 className="center-align">Log in to <i>My Experience</i></h5>
            <Input type="email" label="Email" s={12} onChange={this.handleEmailChange} />
            <Input type="password" label="password" s={12} onChange={this.handlePasswordChange} />
            <Button waves='light' s={12} onClick={this.handleLogin}>Log in</Button>
          </Row>
        </Card>
      </React.Fragment>
    );
  }
}
