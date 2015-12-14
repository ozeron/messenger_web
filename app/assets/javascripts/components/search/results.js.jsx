window.Components = window.Components || {};
window.Components.Search = Components.Search || {};
window.Components.Search.Results = React.createClass({

  render: function() {
    var prompt = I18n.t('nodes.vk.search_form.blank');
    if (this.props.data && this.props.data.length > 0) {
      result = <window.Components.Search.VkGroupList {...this.props}/>;
    } else {
      result = <p>{prompt}</p>;
    }
    return (
      <div className="search-results">
        { result }
      </div>
    );
  }
});
