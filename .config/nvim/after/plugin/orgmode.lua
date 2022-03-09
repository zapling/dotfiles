require('orgmode').setup({
  org_agenda_files = {'~/Documents/org/*', '~/Documents/org/calendars/*'},
  org_default_notes_file = '~/Documents/org/refile.org',
  org_agenda_span = 'day',
  org_agenda_templates = {
      t = { description = 'Task', template = '* TODO %?\n %u', target = '~/Documents/org/personal.org'},
      w = { description = 'Work task', template = '* TODO %?\n %u', target = '~/Documents/org/work.org'}
  },
  org_todo_keywords = {
      'TODO(t)', 'WAITING(w)', '|', 'DONE(d)'
  },
})
