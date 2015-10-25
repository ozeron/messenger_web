window.Components = window.Components || {};
Components.Search = Components.Search || {};
Components.Search.VkAvatar = React.createClass({
  _name: function() {
    this.props.name + '_avatar'
  },
  render: function() {
    return (
      <div className="avatar">
        <img src={this.props.src} alt={this._name()} width="50" height="50" className="img-thumbnail"/>
      </div>
    );
  }
});
