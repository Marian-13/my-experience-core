import React from 'react';

import {
  Button,
  Card,
  Col,
  Input,
  Row
} from 'react-materialize';

export default class App extends React.Component {
  render() {
    return (
      <Row>
        <Col s={12} m={6} l={4} offset="m3 l4">
          <Card>
            <Row>
              <h5 className="center-align">Log in to <i>My Experience</i></h5>
              <Input type="email" label="Email" s={12} />
              <Input type="password" label="password" s={12} />
              <Button waves='light' s={12}>Log in</Button>
            </Row>
          </Card>
        </Col>
      </Row>
    )
  }
}
