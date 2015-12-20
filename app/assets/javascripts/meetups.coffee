DOM = React.DOM

window.CreateNewMeetupForm = React.createClass
  displayName: "CreateNewMeetupForm"
  getInitialState: ->
    {
      meetup: {
        title: "",
        description: "",
        date: new Date(),
        technology: @props.technologies[0].name,
        guests: [""]
      },
      warnings: {
        title: null
      }
    }

  dateChanged: (newDate) ->
    @state.meetup.date = newDate
    @forceUpdate()

  titleChanged: (event) ->
    @state.meetup.title = event.target.value
    @validateTitle()
    @forceUpdate()

  descriptionChanged: (event) ->
    @state.meetup.description = event.target.value
    @forceUpdate()

  seoChanged: (seoText) ->
    @state.meetup.seoText = seoText
    @forceUpdate()

  guestEmailChanged: (number, event) ->
    guests = @state.meetup.guests
    guests[number] = event.target.value

    lastEmail        = guests[guests.length-1]
    #penultimateEmail = guests[guests.length-2]

    if(lastEmail != "")
      guests.push("")
    #if(guests.length >= 2 && lastEmail == "" && penultimateEmail == "")
    #  guests.pop()
    if(number < guests.length-1 && event.target.value == "")
      guests.splice(number, 1)

    @forceUpdate()

  technologyChanged: (event) ->
    @state.meetup.technology = event.target.value
    @forceUpdate()

  computeDefaultSeoText: ->
    words = @state.meetup.title.toLowerCase().split(/\s+/)
    words.push(dateUtils.monthName(@state.meetup.date.getMonth()))
    words.push(@state.meetup.date.getFullYear().toString())
    words.filter( (string) -> string.trim().length > 0).join("-").toLowerCase()

  validateTitle: () ->
    @state.warnings.title = if /\S/.test(@state.meetup.title) then null else "Cannot be blank"

  formSubmitted: (event) ->
    event.preventDefault()
    meetup = @state.meetup

    @validateTitle()
    @forceUpdate()

    for own key of meetup
      return if @state.warnings[key]

    $.ajax
      url: "/meetups.json"
      type: "POST"
      dataType: "JSON"
      contentType: "application/json"
      processData: false
      data: JSON.stringify({meetup: {
        title: meetup.title,
        description: meetup.description,
        date: "#{meetup.date.getFullYear()}-#{meetup.date.getMonth()+1}-#{meetup.date.getDate()}",
        seo: @state.meetup.seoText || @computeDefaultSeoText(),
        guests: @state.meetup.guests,
        technology: @state.meetup.technology
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
          warning: @state.warnings.title

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
          DOM.label
            htmlFor: "technology"
            className: "col-lg-2 control-label"
            "Technology"
          DOM.div
            className: "col-lg-10"
            DOM.select
              className: "form-control"
              onChange: @technologyChanged
              value: @state.meetup.technology
              DOM.option(value: tech.name, key: tech.id, tech.name) for tech in @props.technologies

        formInputWithLabelAndReset
          id: "seo"
          value: if @state.meetup.seoText? then @state.meetup.seoText else @computeDefaultSeoText()
          onChange: @seoChanged
          plaaceholder: "SEO text"
          labelText: "SEO"

      DOM.fieldset null,
        DOM.legend null, "Guests"
        separator null,
          for guest, n in @state.meetup.guests
            ((i) =>
              formInputWithLabel
                id: "email-#{i}"
                key: "guest-#{i}"
                value: guest
                onChange: (event) =>
                  @guestEmailChanged(i, event)
                placeholder: "Email address of an invitee"
                labelText: "Email"
          )(n)

        DOM.div
          className: "form-group"
          DOM.div
            className: "col-lg-10 col-lg-offset-2"
            DOM.button
              type: "submit"
              className: "btn btn-primary"
              "Save"

createNewMeetupForm = React.createFactory(CreateNewMeetupForm)
