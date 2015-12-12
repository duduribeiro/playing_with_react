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

  render: ->
    DOM.form
      className: "form-horizontal"
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

createNewMeetupForm = React.createFactory(CreateNewMeetupForm)
