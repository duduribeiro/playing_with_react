DOM = React.DOM

window.CreateNewMeetupForm = React.createClass
  displayName: "CreateNewMeetupForm"
  getInitialState: ->
    {
      meetup: {
        title: "",
        description: "",
        date: new Date()
      }
    }

  dateChanged: (newDate) ->
    @state.meetup.date = newDate
    @forceUpdate()

  titleChanged: (event) ->
    console.log "titleChanged triggered"
    @state.meetup.title = event.target.value
    @forceUpdate()

  descriptionChanged: (event) ->
    @state.meetup.description = event.target.value
    @forceUpdate()

  formSubmitted: (event) ->
    event.preventDefault()
    meetup = @state.meetup
    $.ajax
      url: "/meetups.json"
      type: "POST"
      dataType: "JSON"
      contentType: "application/json"
      processData: false
      data: JSON.stringify({meetup: {
        title: meetup.title,
        description: meetup.description,
        date: "#{meetup.date.getFullYear()}-#{meetup.date.getMonth()+1}-#{meetup.date.getDate()}"
      }})

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

        dateWithLabel
          onChange: @dateChanged
          date: @state.meetup.date

        DOM.div
          className: "form-group"
          DOM.div
            className: "col-lg-10 col-lg-offset-2"
            DOM.button
              type: "submit"
              className: "btn btn-primary"
              "Save"

createNewMeetupForm = React.createFactory(CreateNewMeetupForm)
