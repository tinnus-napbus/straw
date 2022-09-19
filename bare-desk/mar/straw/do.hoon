/-  *straw
|_  act=action
++  grow
  |%
  ++  noun  act
  --
++  grab
  |%
  ++  noun  action
  ++  json
    =,  dejs:format
    |=  jon=json
    |^  ^-  action
    %.  jon
    %-  of
    :~  [%watch (ot gid+de-gid ~)]
        [%del (ot gid+de-gid pid+(su dem) ~)]
        [%vote (ot gid+de-gid pid+(su dem) who+(se %p) vote+bo ~)]
        [%config (ot gid+de-gid notebook+de-gid quorum+ni ~)]
        :-  %add
        %-  ot
        :~  [%gid de-gid]
            [%pid di]
            [%expires di]
            [%who (se %p)]
            [%title so]
            [%body so]
        ==
    ==
    ++  de-gid  (su ;~((glue fas) ;~(pfix sig fed:ag) sym))
    --
  --
++  grad  %noun
--
