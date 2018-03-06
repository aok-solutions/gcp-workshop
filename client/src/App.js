import React, { Component } from "react";
import "./App.css";

class App extends Component {
  state = {
    response: ""
  };

  componentDidMount() {
    this.callApi()
      .then(res => this.setState({ response: res }))
      .catch(err => console.log(err));
  }

  callApi = async () => {
    const response = await fetch("/api/info");
    const body = await response.json();

    if (response.status !== 200) throw Error(body.message);

    return body;
  };

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img
            src="https://www.thoughtworks.com/imgs/run_sustainable_business.png"
            className="App-logo"
            alt="logo"
          />
          <h1 className="App-title">Welcome to GCP Workshop V2</h1>
        </header>
        <p className="App-intro">hostname: {this.state.response.hostname}</p>
        <p className="App-intro">gitsha: {this.state.response.gitsha}</p>
      </div>
    );
  }
}

export default App;
