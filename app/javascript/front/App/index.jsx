import React from 'react';

import { Col, Row } from 'react-materialize';

import LoginForm from '../forms/LoginForm';

export default class App extends React.Component {
  render() {
    return (
      <Row>
        <Col s={12} m={6} l={4} offset="m3 l4">
          <LoginForm />
        </Col>
      </Row>
    );
  }
}
