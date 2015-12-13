DOM = React.DOM

window.FormInputWithLabelAndReset = React.createClass
  displayName: "FormInputWithLabelAndReset"
  render: ->
    DOM.div
      className: "form-group"
      DOM.label
        className: "col-lg-2 control-label"
        htmlFor: @props.id
        @props.labelText
      DOM.div
        className: "col-lg-8"
        DOM.div
          className: "input-group col-lg-8"
          DOM.input
            className: "form-control"
            id: @props.id
            placeholder: @props.placeholder
            value: @props.value
            onChange: (event) =>
              @props.onChange(event.target.value)
          DOM.span
            className: "input-group-btn"
            DOM.button
              className: "btn btn-default"
              type: "button"
              onClick: () =>
                @props.onChange(null)
              DOM.i
                className: "fa fa-magic"
            DOM.button
              className: "btn btn-default"
              onClick: () =>
                @props.onChange("")
              type: "button"
              DOM.i
                className: "fa fa-times-circle"

window.formInputWithLabelAndReset = React.createFactory(FormInputWithLabelAndReset)
