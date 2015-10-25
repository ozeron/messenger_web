window.Components = window.Components || {};
window.Components.Search = Components.Search || {};
window.Components.Search.VkGroup = React.createClass({
  _members_count: function(){
    return (
      <em>{this.props.members_count} members</em>
    );
  },
  _string_props: function(){
    return JSON.stringify(this.props);
  },
  _attachHandler: function(){
    var handler = this.props.selectHandler;
    var id = this.props.id;
    $("#"+this.props.id).click(function(e){
      e.data = $('#'+id).data('props');
      return handler(e);
    });
  },
  componentDidMount: function(){
    this._attachHandler();
  },
  render: function() {
    return (
      <li className="list-group-item" id={this.props.id} data-props={this._string_props()}>
        <div className="row">
          <div className="col-md-1">
            <Components.Search.VkAvatar src={this.props.photo} name={this.props.name} />
          </div>
          <div className="col-md-9">
            <strong>{this.props.name}</strong>
            <br/>
            {this._members_count()}
            <br/>
            <p>{this.props.description}</p>
          </div>
          <div className="col-md-2">
            <a link="#" className="group-select pull-right btn btn-primary">Select</a>
          </div>
        </div>
      </li>
    );
  }
});
