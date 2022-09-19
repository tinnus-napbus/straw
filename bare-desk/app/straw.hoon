/-  *group, *resource, gs=graph-store, ms=metadata-store, grs=group-store, *straw
/+  default-agent, dbug, store=graph-store
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
      =by-group
      =settings
      gids=(map gid @t)
      notebooks=(jug gid notebook)
      note-names=(map notebook @t)
  ==
+$  card  card:agent:gall
--
::
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  bol=bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bol)
    hc    ~(. +> bol)
::
++  on-init
  ^-  (quip card _this)
  :_  this
  :~  [%pass /group-store %agent [our.bol %group-store] %watch /groups]
      [%pass /metadata %agent [our.bol %metadata-store] %watch /all]
  ==
::
++  on-save  !>(state)
::
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  `this(state !<(state-0 old))
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?.  ?=(%straw-do mark)  (on-poke:def mark vase)
  =/  act=action  !<(action vase)
  ?-    -.act
      %watch
    ?.  =(our.bol src.bol)
      (on-poke:def mark vase)
    =/  =wire  /gid/(scot %p entity.gid.act)/[name.gid.act]
    ?:  ?|  =(our.bol entity.gid.act)
            (~(has by wex.bol) wire entity.gid.act %straw)
        ==
      `this
    :_  this
    [%pass wire %agent [entity.gid.act %straw] %watch /[name.gid.act]]~
  ::
      %add
    ?.  ?&  =(src.bol who.act)
            (gth expires.act (add ~m1 now.bol))
            (~(has by settings) gid.act)
            (~(has in (get-members:hc gid.act)) src.bol)
        ==
      (on-poke:def mark vase)
    ?.  =(our.bol entity.gid.act)
      ?.  =(our.bol src.bol)  (on-poke:def mark vase)
      :_  this
      [%pass /pokes %agent [entity.gid.act %straw] %poke mark vase]~
    =.  pid.act  (time-clean:hc pid.act)
    =/  =proposals
      (fall (~(get by by-group) gid.act) *proposals)
    =.  pid.act
      |-
      ?.  (has:orm proposals pid.act)
        pid.act
      $(pid.act (time-clean:hc (add (div ~s1 200) pid.act)))
    =.  proposals
      %^  put:orm  proposals  pid.act
      [[who.act title.act body.act] expires.act *yea *nay ~]
    :_  this(by-group (~(put by by-group) gid.act proposals))
    :~  [%give %fact ~[/our/all /[name.gid.act]] straw-did+!>(act)]
        [%pass /exp/[name.gid.act]/(scot %ud pid.act) %arvo %b %wait expires.act]
    ==
  ::
      %del
    ?.  =(our.bol entity.gid.act)
      ?.  =(our.bol src.bol)  (on-poke:def mark vase)
      :_  this
      [%pass /pokes %agent [entity.gid.act %straw] %poke mark vase]~
    ?.  ?&  (~(has by settings) gid.act)
            (~(has in (get-members:hc gid.act)) src.bol)
        ==
      (on-poke:def mark vase)
    =/  =proposals  (fall (~(get by by-group) gid.act) *proposals)
    =/  prop=(unit proposal)  (get:orm proposals pid.act)
    ?~  prop  `this
    ?.  |(=(our.bol src.bol) =(src.bol who.entry.u.prop))
      (on-poke:def mark vase)
    =/  expires=@da  expires:(got:orm proposals pid.act)
    ?.  (lth now.bol expires)  (on-poke:def mark vase)
    =.  proposals  (tail (del:orm proposals pid.act))
    :_  this(by-group (~(put by by-group) gid.act proposals))
    :~  [%give %fact ~[/our/all /[name.gid.act]] straw-did+!>(act)]
        [%pass /exp/[name.gid.act]/(scot %ud pid.act) %arvo %b %rest expires]
    ==
  ::
      %vote
    ?.  =(our.bol entity.gid.act)
      ?.  =(our.bol src.bol)  (on-poke:def mark vase)
      :_  this
      [%pass /pokes %agent [entity.gid.act %straw] %poke mark vase]~
    ?.  ?&  =(src.bol who.act)
            (~(has by settings) gid.act)
            (~(has in (get-members:hc gid.act)) src.bol)
        ==
      (on-poke:def mark vase)
    =/  =proposals  (fall (~(get by by-group) gid.act) *proposals)
    =/  prop=(unit proposal)  (get:orm proposals pid.act)
    ?:  ?|  ?=(~ prop)
            ?=(^ passed.u.prop)
            (~(has in yea.u.prop) src.bol)
            (~(has in nay.u.prop) src.bol)
        ==
      (on-poke:def mark vase)
    =.  u.prop
      ?:  vote.act
        u.prop(yea (~(put in yea.u.prop) src.bol))
      u.prop(nay (~(put in nay.u.prop) src.bol))
    =.  proposals  (put:orm proposals pid.act u.prop)
    :_  this(by-group (~(put by by-group) gid.act proposals))
    [%give %fact ~[/our/all /[name.gid.act]] straw-did+!>(act)]~
  ::
      %config
    ?.  ?&  =(our.bol src.bol)
            =(our.bol entity.gid.act)
            =(our.bol entity.notebook.config.act)
            (~(has in (get-notebooks:hc gid.act)) notebook.config.act)
        ==
      (on-poke:def mark vase)
    ?:  =([~ config.act] (~(get by settings) gid.act))
      `this
    :-  [%give %fact ~[/our/all /[name.gid.act]] straw-did+!>(act)]~
    this(settings (~(put by settings) gid.act config.act))
  ==
::
++  on-watch
  |=  =wire
  ^-  (quip card _this)
  ?+    wire  (on-watch:def wire)
      [%our %all ~]
    ?.  =(our.bol src.bol)  (on-watch:def wire)
    :_  this
    :~  [%give %fact ~ straw-meta+!>(`meta`[%init-gids gids])]
        [%give %fact ~ straw-meta+!>(`meta`[%init-notes notebooks note-names])]
        [%give %fact ~ straw-did+!>(`update`[%all by-group settings])]
    ==
  ::
      [@ ~]
    =/  =gid  [our.bol i.wire]
    ?.  (~(has in (get-members:hc gid)) src.bol)
      (on-watch:def wire)
    =/  =update
      :^    %init
          gid
        (~(get by settings) gid)
      (fall (~(get by by-group) gid) *proposals)
    :_  this
    [%give %fact ~ straw-did+!>(update)]~
  ==
::
++  on-leave  on-leave:def
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  (on-agent:def wire sign)
      [%metadata ~]
    ?+    -.sign  (on-agent:def wire sign)
        %kick
      :_  this
      [%pass wire %agent [our.bol %metadata-store] %watch /all]~
    ::
        %fact
      ?.  ?=(%metadata-update-2 p.cage.sign)  `this
      =/  upd=update:ms  !<(update:ms q.cage.sign)
      ?-    -.upd
          %associations
        =/  [names=_gids notes=_notebooks nb-names=_note-names]
          %-  ~(rep by associations.upd)
          |=  $:  [=md-resource:ms =association:ms]
                  names=(map gid @t)
                  notes=(jug gid notebook)
                  note-names=(map notebook @t)
              ==
          ?:  =(%groups app-name.md-resource)
            :_  [notes note-names]
            %+  ~(put by names)
              resource.md-resource
            title.metadatum.association
          ?.  ?&  =(%graph app-name.md-resource)
                  ?=(%graph -.config.metadatum.association)
                  =(%publish module.config.metadatum.association)
              ==
            [names notes note-names]
          :+  names
            (~(put ju notes) group.association resource.md-resource)
          %+  ~(put by note-names)
            resource.md-resource
          title.metadatum.association
        :_  this(gids names, notebooks notes, note-names nb-names)
        :~  [%give %fact ~[/our/all] straw-meta+!>(`meta`[%init-gids names])]
            :^  %give  %fact  ~[/our/all]
            straw-meta+!>(`meta`[%init-notes notes nb-names])
        ==
      ::
          %updated-metadata
        ?:  =(%groups app-name.resource.upd)
          :_  this(gids (~(put by gids) group.upd title.metadatum.upd))
          :~  :^  %give  %fact  ~[/our/all]
              straw-meta+!>(`meta`[%add-gid group.upd title.metadatum.upd])
          ==
        ?.  ?&  =(%graph app-name.resource.upd)
                ?=(%graph -.config.metadatum.upd)
                =(%publish module.config.metadatum.upd)
            ==
          `this
        =/  =meta
          [%add-note group.upd resource.resource.upd title.metadatum.upd]
        :-  [%give %fact ~[/our/all] straw-meta+!>(meta)]~
        %=  this
          notebooks   (~(put ju notebooks) group.upd resource.resource.upd)
          note-names  %-  ~(put by note-names)
                      [resource.resource.upd title.metadatum.upd]
        ==
      ::
          %add
        ?:  =(%groups app-name.resource.upd)
          :_  this(gids (~(put by gids) group.upd title.metadatum.upd))
          :~  :^  %give  %fact  ~[/our/all]
              straw-meta+!>(`meta`[%add-gid group.upd title.metadatum.upd])
          ==
        ?.  ?&  =(%graph app-name.resource.upd)
                ?=(%graph -.config.metadatum.upd)
                =(%publish module.config.metadatum.upd)
            ==
          `this
        =/  =meta
          [%add-note group.upd resource.resource.upd title.metadatum.upd]
        :-  [%give %fact ~[/our/all] straw-meta+!>(meta)]~
        %=  this
          notebooks   (~(put ju notebooks) group.upd resource.resource.upd)
          note-names  %-  ~(put by note-names)
                      [resource.resource.upd title.metadatum.upd]
        ==
      ::
          %remove
        ?:  =(%groups app-name.resource.upd)
          :_  this(gids (~(del by gids) group.upd))
          [%give %fact ~[/our/all] straw-meta+!>(`meta`[%del-gid group.upd])]~
        ?.  ?&  =(%graph app-name.resource.upd)
                (~(has ju notebooks) group.upd resource.resource.upd)
            ==
          `this
        =/  =meta  [%del-note group.upd resource.resource.upd]
        :-  [%give %fact ~[/our/all] straw-meta+!>(meta)]~
        %=  this
          note-names  (~(del by note-names) resource.resource.upd)
          notebooks   (~(del ju notebooks) group.upd resource.resource.upd)
        ==
      ::
          %edit
        ?.  ?=(%title -.edit-field.upd)
          `this
        ?:  =(%groups app-name.resource.upd)
          :_  this(gids (~(put by gids) group.upd title.edit-field.upd))
          :~  :^  %give  %fact  ~[/our/all]
              straw-meta+!>(`meta`[%add-gid group.upd title.edit-field.upd])
          ==
        ?.  ?&  =(%graph app-name.resource.upd)
                (~(has ju notebooks) group.upd resource.resource.upd)
            ==
          `this
        =/  =meta
          [%add-note group.upd resource.resource.upd title.edit-field.upd]
        :-  [%give %fact ~[/our/all] straw-meta+!>(meta)]~
        %=  this
          notebooks   (~(put ju notebooks) group.upd resource.resource.upd)
          note-names  %-  ~(put by note-names)
                      [resource.resource.upd title.edit-field.upd]
        ==
      ::
          %initial-group
        =/  [name=@t names=(map notebook @t)]
          %-  ~(rep by associations.upd)
          |=  $:  [=md-resource:ms =association:ms]
                  name=@t
                  names=(map notebook @t)
              ==
          ?:  =(%groups app-name.md-resource)
            [title.metadatum.association names]
          ?.  ?&  =(%graph app-name.md-resource)
                  ?=(%graph -.config.metadatum.association)
                  =(%publish module.config.metadatum.association)
              ==
            [name names]
          :-  name
          %-  ~(put by names)
          [resource.md-resource title.metadatum.association]
        =/  =meta
          :^    %init-gid
              group.upd
            ?.  =('' name)
              name
            :((cury cat 3) (scot %p entity.group.upd) '/' name.group.upd)
          names
        :-  [%give %fact ~[/our/all] straw-meta+!>(meta)]~
        %=  this
          gids        (~(put by gids) group.upd name)
          notebooks   (~(put by notebooks) group.upd ~(key by names))
          note-names  (~(uni by note-names) names)
        ==
      ==
    ==
  ::
      [%group-store ~]
    ?+    -.sign  (on-agent:def wire sign)
        %kick
      :_  this
      [%pass wire %agent [our.bol %group-store] %watch /groups]~
    ::
        %fact
      ?.  ?=(%group-update-0 p.cage.sign)  `this
      =/  upd=update:grs  !<(update:grs q.cage.sign)
      ?+    -.upd  `this
          %initial
        =/  subs=(set [ship @tas])
          %-  ~(rep by sup.bol)
          |=  [[=duct =ship =path] subs=(set [ship @tas])]
          ?:  =(our.bol ship)  subs
          ?.  ?=([@ ~] path)   subs
          (~(put in subs) [ship i.path])
        :_  this
        %-  ~(rep in subs)
        |=  [[=ship name=@tas] cards=(list card)]
        ?:  %.  ship
            %~  has  in
            =<  members
            (fall (~(get by groups.upd) [our.bol name]) *group)
          cards
        :_  cards
        [%give %kick [name ~]~ `ship]
      ::
          %initial-group
        ?.  =(our.bol entity.resource.upd)
          `this
        =/  ships=(set ship)
          %-  ~(rep by sup.bol)
          |=  [[=duct =ship =path] ships=(set ship)]
          ?:  =(our.bol ship)                ships
          ?.  =([name.resource.upd ~] path)  ships
          (~(put in ships) ship)
        :_  this
        %-  ~(rep in ships)
        |=  [=ship cards=(list card)]
        ?:  (~(has in members.group.upd) ship)
          cards
        :_  cards
        [%give %kick [name.resource.upd ~]~ `ship]
      ::
          %remove-members
        ?.  =(our.bol entity.resource.upd)
          `this
        =/  ships=(set ship)
          %-  ~(rep by sup.bol)
          |=  [[=duct =ship =path] ships=(set ship)]
          ?:  =(our.bol ship)                ships
          ?.  =([name.resource.upd ~] path)  ships
          (~(put in ships) ship)
        :_  this
        %-  ~(rep in ships)
        |=  [=ship cards=(list card)]
        ?:  (~(has in ships.upd) ship)
          cards
        :_  cards
        [%give %kick [name.resource.upd ~]~ `ship]
      ::
          %remove-group
        ?.  =(our.bol entity.resource.upd)
          `this
        :_  this
        [%give %kick [name.resource.upd ~]~ ~]~
      ==
    ==
  ::
      [%gid @ @ ~]
    =/  =gid  [(slav %p i.t.wire) i.t.t.wire]
    ?+    -.sign  (on-agent:def wire sign)
        %kick
      :_  this
      [%pass wire %agent [entity.gid %straw] %watch /[name.gid]]~
    ::
        %fact
      ?.  ?=(%straw-did p.cage.sign)  `this
      =/  upd=update  !<(update q.cage.sign)
      ?+    -.upd  `this
          %init
        ?.  =(gid gid.upd)  `this
        :-  [%give %fact ~[/our/all] cage.sign]~
        %=  this
          by-group  (~(put by by-group) gid proposals.upd)
          settings  ?~  config.upd
                      settings
                    (~(put by settings) gid u.config.upd)
        ==
      ::
          %add
        ?.  =(gid gid.upd)  `this
        =/  =proposals
          %^    put:orm
              (fall (~(get by by-group) gid) *proposals)
            pid.upd
          [[who title body]:upd expires.upd *yea *nay ~]
        :-  [%give %fact ~[/our/all] cage.sign]~
        this(by-group (~(put by by-group) gid proposals))
      ::
          %del
        ?.  =(gid gid.upd)  `this
        =/  =proposals
          %-  tail
          %+  del:orm
            (fall (~(get by by-group) gid) *proposals)
          pid.upd
        :-  [%give %fact ~[/our/all] cage.sign]~
        this(by-group (~(put by by-group) gid proposals))
      ::
          %vote
        ?.  =(gid gid.upd)  `this
        =/  props=(unit proposals)  (~(get by by-group) gid)
        ?~  props  `this
        =/  prop=(unit proposal)  (get:orm u.props pid.upd)
        ?~  prop  `this
        ?:  ?|  (~(has in yea.u.prop) who.upd)
                (~(has in nay.u.prop) who.upd)
            ==
          `this
        =.  u.prop
          ?:  vote.upd
            u.prop(yea (~(put in yea.u.prop) who.upd))
          u.prop(nay (~(put in nay.u.prop) who.upd))
        =.  u.props  (put:orm u.props pid.upd u.prop)
        :-  [%give %fact ~[/our/all] cage.sign]~
        this(by-group (~(put by by-group) gid u.props))
      ::
          %config
        ?.  =(gid gid.upd)  `this
        :-  [%give %fact ~[/our/all] cage.sign]~
        this(settings (~(put by settings) gid config.upd))
      ::
          %closed
        ?.  =(gid gid.upd)  `this
        =/  props=(unit proposals)  (~(get by by-group) gid)
        ?~  props  `this
        =/  prop=(unit proposal)  (get:orm u.props pid.upd)
        ?~  prop  `this
        ?:  ?=(^ passed.u.prop)  `this
        =.  u.props
          (put:orm u.props pid.upd u.prop(passed `passed.upd))
        :-  [%give %fact ~[/our/all] cage.sign]~
        this(by-group (~(put by by-group) gid u.props))
      ==
    ==
  ==
::
++  on-arvo
  |=  [=wire =sign-arvo]
  |^  ^-  (quip card _this)
  ?.  ?=([%exp @ @ ~] wire)          (on-arvo:def wire sign-arvo)
  ?.  ?=([%behn %wake *] sign-arvo)  (on-arvo:def wire sign-arvo)
  =/  =gid  [our.bol i.t.wire]
  =/  =pid  (slav %ud i.t.t.wire)
  =/  props=(unit proposals)  (~(get by by-group) gid)
  ?~  props  `this
  =/  prop=(unit proposal)  (get:orm u.props pid)
  ?~  prop  `this
  =/  conf=(unit config)  (~(get by settings) gid)
  ?~  conf
    =^  cards  state  (fail gid pid u.prop u.props)
    [cards this]
  ?~  error.sign-arvo
    =^  cards  state
      ?.  (did-pass gid u.prop quorum.u.conf)
        (fail gid pid u.prop u.props)
      (succeed gid pid u.prop u.props notebook.u.conf)
    [cards this]
  ?:  (gth expires.u.prop now.bol)
    :_  this
    [%pass wire %arvo %b %wait expires.u.prop]~
  =^  cards  state
    ?.  (did-pass gid u.prop quorum.u.conf)
      (fail gid pid u.prop u.props)
    (succeed gid pid u.prop u.props notebook.u.conf)
  [cards this]
  ::
  ++  succeed
    |=  [=gid =pid =proposal =proposals =notebook]
    ^-  (quip card _state)
    =.  proposals
      %^  put:orm  proposals  pid
      proposal(passed `&)
    =/  =update  [%closed gid pid &]
    :_  state(by-group (~(put by by-group) gid proposals))
    :~  [%give %fact ~[/our/all /[name.gid]] straw-did+!>(update)]
        (post-poke notebook entry.proposal)
    ==
  ::
  ++  fail
    |=  [=gid =pid =proposal =proposals]
    ^-  (quip card _state)
    =.  proposals  (put:orm proposals pid proposal(passed `|))
    =/  =update  [%closed gid pid |]
    :_  state(by-group (~(put by by-group) gid proposals))
    [%give %fact ~[/our/all /[name.gid]] straw-did+!>(update)]~
  ::
  ++  did-pass
    |=  [=gid =proposal =quorum]
    ^-  ?
    =?  quorum  (gth quorum 100)  100
    =/  yes=@ud  ~(wyt in yea.proposal)
    ?:  =(0 yes)  |
    =/  no=@ud   ~(wyt in nay.proposal)
    ?:  (gte no yes)  |
    =/  mem=@ud  ~(wyt in (get-members:hc gid))
    ?:  =(0 mem)  |
    ?:  =(0 quorum)  &
    %+  gte  (add yes no)
    %-  abs:si
    %-  need
    %-  toi:fl
    %+  mul:fl
      (sun:fl mem)
    (div:fl (sun:fl quorum) (sun:fl 100))
  ::
  ++  post-poke
    |=  [=resource who=@p title=@t body=@t]
    ^-  card:agent:gall
    :+  %pass  /add
    :^  %agent  [our.bol %graph-store]  %poke
    :-  %graph-update-3
    !>  ^-  update:gs
    :-  now.bol
    ^-  action:gs
    :+  %add-nodes
      resource
    %+  ~(put by *(map index:gs node:gs))
      [now.bol ~]
    ^-  node:gs
    ::  root
    :-  [%& who [now.bol ~] now.bol ~ ~ ~]
    :-  %graph
    %+  gas:orm:store  *graph:gs
    :~
    ::  post container
      :-  1
      :+  [%& who [now.bol 1 ~] now.bol ~ ~ ~]
        %graph
      %^  put:orm:store  *graph:gs  1
      ::  post
      :-  :^  %&  who  [now.bol 1 1 ~]
          [now.bol ~[text+title text+body] ~ ~]
      [%empty ~]
    ::  comment container
      :-  2
      [[%& who [now.bol 2 ~] now.bol ~ ~ ~] %empty ~]
    ==
  --
::
++  on-peek   on-peek:def
++  on-fail   on-fail:def
--
::
|_  bol=bowl:gall
++  time-clean
  |=  a=@
  ^-  @
  (from-unix-ms:chrono:userlib (unm:chrono:userlib a))
::
++  get-notebooks
  |=  =gid
  ^-  (set notebook)
  =/  meta-list=(list (pair md-resource:ms association:ms))
    %~  tap  by
    .^  associations:ms
      %gx
      (scot %p our.bol)  %metadata-store  (scot %da now.bol)
      /group/ship/(scot %p entity.gid)/[name.gid]/noun
    ==
  %-  ~(gas in *(set notebook))
  ^-  (list notebook)
  %+  turn
    %+  skim  meta-list
    |=  (pair md-resource:ms association:ms)
    ?&  =(%graph app-name.p)
        ?=(%graph -.config.metadatum.q)
        =(%publish module.config.metadatum.q)
    ==
  |=  [=md-resource:ms *]
  ^-  notebook
  resource.md-resource
::
++  get-members
  |=  =gid
  ^-  (set @p)
  =<  members
  %+  fall
    .^  (unit group)
      %gx
      (scot %p our.bol)  %group-store  (scot %da now.bol)
      /groups/ship/(scot %p entity.gid)/[name.gid]/noun
    ==
  *group
--
