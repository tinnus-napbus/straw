/-  *straw
|_  upd=update
++  grow
  |%
  ++  noun  upd
  ++  json
    =,  enjs:format
    |^  ^-  ^json
    ?-    -.upd
        %watch
      (frond 'watch' (frond 'gid' (en-gid gid.upd)))
    ::
        %add
      %+  frond  'add'
      %-  pairs
      :~  ['gid' (en-gid gid.upd)]
          ['pid' s+(crip (a-co:co pid.upd))]
          ['expires' (time expires.upd)]
          ['who' s+(scot %p who.upd)]
          ['title' s+title.upd]
          ['body' s+body.upd]
      ==
    ::
        %del
      %+  frond  'del'
      %-  pairs
      :~  ['gid' (en-gid gid.upd)]
          ['pid' s+(crip (a-co:co pid.upd))]
      ==
    ::
        %vote
      %+  frond  'vote'
      %-  pairs
      :~  ['gid' (en-gid gid.upd)]
          ['pid' s+(crip (a-co:co pid.upd))]
          ['who' s+(scot %p who.upd)]
          ['vote' b+vote.upd]
      ==
    ::
        %config
      %+  frond  'config'
      %-  pairs
      :~  ['gid' (en-gid gid.upd)]
          ['notebook' (en-gid notebook.config.upd)]
          ['quorum' (numb quorum.config.upd)]
      ==
    ::
        %closed
      %+  frond  'closed'
      %-  pairs
      :~  ['gid' (en-gid gid.upd)]
          ['pid' s+(crip (a-co:co pid.upd))]
          ['passed' b+passed.upd]
      ==
    ::
        %all
      %+  frond  'all'
      %-  pairs
      :~  ['byGroup' (en-by-group by-group.upd)]
          ['settings' (en-settings settings.upd)]
      ==
    ::
        %init
      %+  frond  'init'
      %-  pairs
      :~  ['gid' (en-gid gid.upd)]
          ['config' ?~(config.upd ~ (en-config u.config.upd))]
          ['proposals' (en-proposals proposals.upd)]
      ==
    ==
    ::
    ++  en-config
      |=  =config
      ^-  ^json
      %-  pairs
      :~  ['notebook' (en-gid notebook.config)]
          ['quorum' (numb quorum.config)]
      ==
    ::
    ++  en-settings
      |=  =settings
      ^-  ^json
      :-  %a
      %+  turn  ~(tap by settings)
      |=  [=gid =config]
      ^-  ^json
      :-  %a
      :~  (en-gid gid)
          %-  pairs
          :~  ['notebook' (en-gid notebook.config)]
              ['quorum' (numb quorum.config)]
          ==
      ==
    ::
    ++  en-by-group
      |=  =by-group
      ^-  ^json
      :-  %a
      %+  turn  ~(tap by by-group)
      |=  [=gid =proposals]
      ^-  ^json
      %-  pairs
      :~  ['gid' (en-gid gid)]
          ['proposals' (en-proposals proposals)]
      ==
    ++  en-proposals
      |=  =proposals
      ^-  ^json
      :-  %a
      %+  turn
        %+  sort  (tap:orm proposals)
        |=  [[* a=proposal] [* b=proposal]]
        (lte expires.a expires.b)
      |=  [=pid =proposal]
      ^-  ^json
      :-  %a
      :~  s+(crip (a-co:co pid))
          (en-proposal proposal)
      ==
    ::
    ++  en-proposal
      |=  =proposal
      ^-  ^json
      %-  pairs
      :~  ['entry' (en-entry [entry passed]:proposal)]
          ['expires' (time expires.proposal)]
          ['yea' (en-ships yea.proposal)]
          ['nay' (en-ships nay.proposal)]
          ['passed' ?~(passed.proposal ~ b+u.passed.proposal)]
      ==
    ::
    ++  en-ships
      |=  ships=(set @p)
      ^-  ^json
      a+(turn ~(tap in ships) |=(=@p s+(scot %p p)))
    ::
    ++  en-entry
      |=  [=entry passed=(unit)]
      ^-  ^json
      %-  pairs
      :~  ['who' s+(scot %p who.entry)]
          ['title' s+title.entry]
          ['body' ?~(passed s+body.entry ~)]
      ==
    ::
    ++  en-gid
      |=  =gid
      ^-  ^json
      [%s :((cury cat 3) (scot %p entity.gid) '/' name.gid)]
    --
  --
++  grab
  |%
  ++  noun  update
  --
++  grad  %noun
--
