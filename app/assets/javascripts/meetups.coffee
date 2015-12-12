DOM = React.DOM

window.CreateNewMeetupForm = React.createClass
  displayName: "CreateNewMeetupForm"
  getInitialState: ->
    {
      meetup: {
        title: "",
        description: ""
      }
    }

  titleChanged: (event) ->
    console.log "titleChanged triggered"
    @state.meetup.title = event.target.value
    @forceUpdate()

  descriptionChanged: (event) ->
    @state.meetup.description = event.target.value
    @forceUpdate()

  formSubmitted: (event) ->
    event.preventDefault()
    $.ajax
      url: "/meetups.json"
      type: "POST"
      dataType: "JSON"
      contentType: "application/json"
      processData: false
      data: JSON.stringify({meetup: @state.meetup})

  render: ->
    DOM.form
      className: "form-horizontal"
      onSubmit: @formSubmitted
      DOM.fieldset null,
        DOM.legend null, "New Meetup"

        formInputWithLabel
          id: "title"
          value: @state.meetup.title
          onChange: @titleChanged
          placeholder: "Meetup title"
          labelText: "Title"

        formInputWithLabel
          id: "description"
          value: @state.meetup.description
          onChange: @descriptionChanged
          placeholder: "Meetup description"
          labelText: "Description"
          elementType: "textarea"

        DOM.div
          className: "form-group"
          DOM.div
            className: "col-lg-10 col-lg-offset-2"
            DOM.button
              type: "submit"
              className: "btn btn-primary"
              "Save"

createNewMeetupForm = React.createFactory(CreateNewMeetupForm)
