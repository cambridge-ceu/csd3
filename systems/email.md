---
sort: 4
---

# email

## mutt

This can be done with `mutt` from the console, which leads to a menu-driven session.

Alternatively, to send a message one can follow these steps,

```bash
mail <your email address>
Subject: test
This is another test.
```

The message is furnished with a "Ctrl-D" from the console.

For an attachment, this is done similarly

```bash
mutt <your email address> -s "Test" -a /path/to/file
```

## thunderbird

An attempt was made with this,

```bash
module load ceuadmin/thunderbird
```

The package is from <https://www.thunderbird.net/en-US/thunderbird/all>.

It is necessary to follow instructions here, <https://help.uis.cam.ac.uk/service/collaboration/365/exchange-online/how-access-your-mailbox/set-thunderbird-exchange-online>.
