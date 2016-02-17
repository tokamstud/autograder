var React = require("react")

// react-bootstrap requires
var Navbar = require("react-bootstrap").Navbar
var NavItem = require("react-bootstrap").NavItem
var Nav = require("react-bootstrap").Nav

// react-router requires
var Link = require("react-router").Link
// local requires
var Dropdown = require("./Dropdown.jsx")
var LoginForm = require("../login/LoginForm.jsx")



var pageRequest = function(request,isServed) {
  this.pageRequest = request;
  this.isServed = isServed;
}



// this class
var Topbar = React.createClass({
  getInitialState: function() {
    return {
      courses: [
        {id: 0, name:"DAT100"},
        {id: 1, name:"DAT200"},
        {id: 2, name:"DAT300"}
      ],
      connected: false

    };
  },

  chooseCourse: function(e) {
      this.setState({choosen: choosen});
      console.log(e);
  },

  // Creates a websocket connection after the react component has been mounted.
  //
  componentDidMount: function() {
    var ws = this.ws = new WebSocket("ws://localhost:8000/ws");
    ws.onmessage = this.message;
    ws.onopen = this.open;
    ws.onclose = this.close;
    
    /*
    ws.send();
    */

  },

  message: function() {
    console.log("Message from server received");
  },

  getTopBar: function() {
    var topBarRequest = new pageRequest("topbar",false);
    var json = JSON.stringify(topBarRequest);
    ws.send(json);
  },
  open: function() {
    this.setState({connected: true});
    this.getTopBar;
  },

  close: function() {
    this.setState({connected: false});
  },

  showAbout: function(e) {
    if (this.state.connected) {
      this.ws.send(e.target.href);
    }
  },

  logIn: function(e) {
    if (this.state.connected) {
      this.ws.send(e.target.href)
    }
  },

  // TODO : iterate over buttons available fo user
  render:function() {
    var self = this;
    return (
      <Navbar inverse>

        <Navbar.Header>
          <Navbar.Brand>
            <Link to="/">Autograder</Link>
          </Navbar.Brand>
          <Navbar.Toggle />
        </Navbar.Header>

        <Navbar.Collapse>
          <Nav>

            <Dropdown
            courses={self.state.courses}
            chooseCourse={self.chooseCourse}
            />

          </Nav>

          <Nav pullRight>
            <li>
              <Link to="/about" onClick={this.showAbout}>About</Link>
            </li>
            <li>
              <Link to="/login" onClick={this.logIn}>Log in</Link>
            </li>
          </Nav>

        </Navbar.Collapse>
      </Navbar>
    )
  }
})

module.exports = Topbar;