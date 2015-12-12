DOM = React.DOM

window.FormInputWithLabel = React.createClass
  getDefaultProps: ->
    elementType: "input"
    inputType: "text"

  displayName: "FormInputWithLabel"

  tagType: ->
    {
      "input": @props.inputType,
      "textarea": null
    }[@props.elementType]

  render: ->
    DOM.div
      className: "form-group"
      DOM.label
        htmlFor: @props.id
        className: "col-lg-2 control-label"
        @props.labelText

      DOM.div
        className: "col-lg-10"
        DOM[@props.elementType]
          className: "form-control"
          placeholder: @props.placeholder
          id: @props.id
          type: @tagType()
          value: @props.value
          onChange: @props.onChange
window.formInputWithLabel = React.createFactory(FormInputWithLabel)
