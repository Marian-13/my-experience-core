import React from 'react';

import axios from 'axios';
import {
  Button,
  Card,
  Input,
  Row,
  Toast
} from 'react-materialize';

import { storeToken } from '../../lib/auth';
import client from '../../api/OwnClient';

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

  handleLogin = () => {
    const { email, password } = this.state;
    const data = { auth: { email, password } };

    client
      .post('/user_token', data)
      .then(({ data }) => {
        storeAuthToken(data.token);
      })
      .catch(() => {
        M.toast({ html: 'Invalid email and/or password.' });
      });
  }

  render() {
    return (
      <Card>
        <Row>
          <h5 className="center-align">Log in to <i>My Experience</i></h5>
          <Input type="email" label="Email" s={12} onChange={this.handleEmailChange} />
          <Input type="password" label="password" s={12} onChange={this.handlePasswordChange} />
          <Button waves='light' s={12} onClick={this.handleLogin}>Log in</Button>
        </Row>
      </Card>
    );
  }
}
