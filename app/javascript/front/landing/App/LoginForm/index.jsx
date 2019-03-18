import React from 'react';

import axios from 'axios';
import {
  Button,
  Card,
  Input,
  Row
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
    axios.get('http://localhost:3000')
         .then(navigateToRootPath);
         .then((response) => {
           navigateTo('/', { token: response.data.token });
         });
         .catch(error => {

         });

         // window.location = '/';
         navigateAsLoggedInUserTo('/');
         navigateToRootPath();
         // turbolinks:request-start
         addEventListener with option once
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
