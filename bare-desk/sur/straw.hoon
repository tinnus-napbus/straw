/-  *resource
|%
+$  gid        resource
+$  pid        @
+$  notebook   resource
+$  yea        (set @p)
+$  nay        (set @p)
+$  quorum     @ud
+$  config     [=notebook =quorum]
+$  entry      [who=@p title=@t body=@t]
+$  proposal   [=entry expires=@da =yea =nay passed=(unit ?)]
::
+$  proposals  ((mop pid proposal) gth)
++  orm        ((on pid proposal) gth)
+$  by-group   (map gid proposals)
+$  settings   (map gid config)
::
+$  action
  $%  [%watch =gid]
      [%add =gid =pid expires=@da entry]
      [%del =gid =pid]
      [%vote =gid =pid who=@p vote=?]
      [%config =gid =config]
  ==
+$  update
  $%  [%all =by-group =settings]
      [%init =gid config=(unit config) =proposals]
      [%closed =gid =pid passed=?]
      action
  ==
+$  meta
  $%  [%init-gids names=(map gid @t)]
      [%init-notes notes=(jug gid notebook) names=(map notebook @t)]
      [%add-gid =gid name=@t]
      [%add-note =gid =notebook name=@t]
      [%del-gid =gid]
      [%del-note =gid =notebook]
      [%init-gid =gid name=@t notes=(map notebook @t)]
  ==
--
