window.Components = window.Components || {};
window.Components.Search = Components.Search || {};
window.Components.Search.VkGroupList = React.createClass({
  render: function() {
    handler = this.props.selectHandler
    return (
      <ul className="list-group">
        {
          this.props.data.map(function(record) {
            return (
              <Components.Search.VkGroup key={record.id} selectHandler={handler} {...record} />
            );
          })
        }

      </ul>
    );
  }
});
