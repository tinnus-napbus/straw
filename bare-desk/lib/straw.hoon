/-  *group, *resource, gs=graph-store
|%
++  post-poke
  |=  [our=@p now=@da =resource who=@p title=@t body=@t]
  ^-  card:agent:gall
  ?.  =(our entity.resource)
    ~|  %notebook-must-be-ours  !!
  :+  %pass  /add
  :^  %agent  [our %graph-store]  %poke
  :-  %graph-update-3
  !>  ^-  update:gs
  :-  now
  ^-  action:gs
  :+  %add-nodes
    resource
  %+  ~(put by *(map index:gs node:gs))
    [now ~]
  ^-  node:gs
  ::  root
  :-  [%& who [now ~] now ~ ~ ~]
  :-  %graph
  %+  gas:orm:store  *graph:gs
  :~
  ::  post container
    :-  1
    :+  [%& who [now 1 ~] now ~ ~ ~]
      %graph
    %^  put:orm:store  *graph:gs  1
    ::  post
    [[%& who [now 1 1 ~] now ~[text+title text+body] ~ ~] %empty ~]
  ::  comment container
    :-  2
    [[%& who [now 2 ~] now ~ ~ ~] %empty ~]
  ==
--
