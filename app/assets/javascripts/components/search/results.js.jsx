window.Components = window.Components || {};
window.Components.Search = Components.Search || {};
window.Components.Search.Results = React.createClass({

  render: function() {
    if (this.props.data && this.props.data.length > 0) {
      result = <window.Components.Search.VkGroupList {...this.props}/>;
    } else {
      result = <p>Enter query in search box to see suggested groups. Eg: Политика</p>;
    }
    return (
      <div className="search-results">
        { result }
      </div>
    );
  }
});
