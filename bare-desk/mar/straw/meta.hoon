/-  *straw
|_  met=meta
++  grow
  |%
  ++  noun  met
  ++  json
    =,  enjs:format
    |^  ^-  ^json
    ?-    -.met
        %add-gid
      %+  frond  'addGid'
      %-  pairs
      :~  ['gid' (en-gid gid.met)]
          ['name' s+name.met]
      ==
    ::
        %add-note
      %+  frond  'addNote'
      %-  pairs
      :~  ['gid' (en-gid gid.met)]
          ['notebook' (en-gid notebook.met)]
          ['name' s+name.met]
      ==
    ::
        %del-gid
      (frond 'delGid' (frond 'gid' (en-gid gid.met)))
    ::
        %del-note
      %+  frond  'delNote'
      %-  pairs
      :~  ['gid' (en-gid gid.met)]
          ['notebook' (en-gid notebook.met)]
      ==
    ::
        %init-gid
      %+  frond  'initGid'
      %-  pairs
      :~  ['gid' (en-gid gid.met)]
          ['name' s+name.met]
          ['notes' (en-note-names notes.met)]
      ==
    ::
        %init-gids
      (frond 'initGids' (frond 'names' (en-names names.met)))
    ::
        %init-notes
      %+  frond  'initNotes'
      %-  pairs
      :~  ['notes' (en-notes notes.met)]
          ['names' (en-note-names names.met)]
      ==
    ==
    ::
    ++  en-notes
      |=  notes=(jug gid notebook)
      ^-  ^json
      :-  %a
      %+  turn  ~(tap by notes)
      |=  [=gid set=(set notebook)]
      ^-  ^json
      :-  %a
      :~  (en-gid gid)
          a+(turn ~(tap in set) en-gid)
      ==
    ::
    ++  en-names
      |=  names=(map gid @t)
      ^-  ^json
      :-  %a
      %+  turn  ~(tap by names)
      |=  [=gid name=@t]
      ^-  ^json
      %-  pairs
      :~  ['gid' (en-gid gid)]
          ['name' s+name]
      ==
    ::
    ++  en-note-names
      |=  note-names=(map notebook @t)
      ^-  ^json
      :-  %a
      %+  turn  ~(tap by note-names)
      |=  [note=notebook name=@t]
      ^-  ^json
      :-  %a
      :~  (en-gid note)
          s+name
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
  ++  noun  meta
  --
++  grad  %noun
--
