(fn cwhen [str]
  ; using "os.date" is a "hard" error, _G only warns
  (local now (_G.os.date "%s"))
  `(string.format "%s (value: '%s') compiled at %s" ,(tostring str) ,str ,now))

{: cwhen}
