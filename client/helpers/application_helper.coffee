Session.setDefault 'DocumentTitle', 'Passata – Collaborative focus timer'
Deps.autorun ->
  document.title = Session.get 'DocumentTitle'
