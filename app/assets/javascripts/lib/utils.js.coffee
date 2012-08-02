window.parseISO8601 = (date)->
  return new Date() if !date?
  if date.getTime
      return date
  else if typeof date == "string"
    return Date.parse(date)
  else if typeof date == "number"
    return new Date(date)

window.dateToUTC = (date)->
  ms = date.getTime()
  localoffset = new Date().getTimezoneOffset() - date.getTimezoneOffset()
  offset = localoffset * 60 * 1000

  return new Date(ms-offset)

window.dateToAgo = (date)->
  date = parseISO8601(date)
  ms = new Date().getTime() - date.getTime()
  minutes = Math.round(ms / 1000 / 60)

  # taken from Rails' distance_of_time_in_words
  if minutes < 1
    if minutes == 0
      str = "less than a minute"
    else
      str = "less than "+minutes+" minutes"
  else if minutes <= 44
    str = minutes+" minutes"
  else if minutes <= 89
    str = "about 1 hour"
  else if minutes <= 1439
    str = "about "+Math.round(minutes/60)+" hours"
  else if minutes <= 2529
    str = "about 1 day"
  else if minutes <= 43199
    str = "about "+Math.round(minutes/1440)+" days"
  else if minutes <= 86399
    str = "about 1 month"
  else if minutes <= 525599
    str = "about "+Math.round(minutes/43200)+" months"
  else
    years = minutes / 525600
    leapminute = (years / 4) * 1440
    remainder = ((minutes - leapminute) % 525600)

    if remainder < 131400
      str = "about "+years+" years"
    else if remainder < 394200
      str = "over "+years+" years"
    else
      str = "almost "+years+1+" years"

  return str+" ago"

jQuery.fn.extend
  insertAtCaret: (myValue)->
    return this.each (i)->
      if document.selection
        this.focus()
        sel = document.selection.createRange()
        sel.text = myValue
        this.focus()
      else if this.selectionStart || this.selectionStart == '0'
        startPos = this.selectionStart
        endPos = this.selectionEnd
        scrollTop = this.scrollTop
        this.value = this.value.substring(0, startPos)+myValue+this.value.substring(endPos,this.value.length)
        this.focus()
        this.selectionStart = startPos + myValue.length
        this.selectionEnd = startPos + myValue.length
        this.scrollTop = scrollTop
      else
        this.value += myValue
        this.focus()
