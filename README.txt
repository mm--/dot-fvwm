                  _           _     __  __ __  __ _
                 | | ___  ___| |__ |  \/  |  \/  ( )___
              _  | |/ _ \/ __| '_ \| |\/| | |\/| |// __|
             | |_| | (_) \__ \ | | | |  | | |  | | \__ \
              \___/ \___/|___/_| |_|_|  |_|_|  |_| |___/

                       (terrible and outdated)
                  _______     ____        ____  __
                 |  ___\ \   / /\ \      / /  \/  |
                 | |_   \ \ / /  \ \ /\ / /| |\/| |
                 |  _|   \ V /    \ V  V / | |  | |
                 |_|      \_/      \_/\_/  |_|  |_|
                                       __
                       ___ ___  _ __  / _|
                      / __/ _ \| '_ \| |_
                     | (_| (_) | | | |  _|
                      \___\___/|_| |_|_|


This was my old config file for the F(?) Virtual Window Manager, which
was my primary window manager in Debian for most of my college
years. I used FVWM from sometime around or before 2009 to 2013, around
which point I switched to using Sawfish, another highly extensible
window manager.

This repository is stored here mostly for historical interest, as a
kind of a personal time capsule. This README will briefly describe how
I got into FVWM, things I liked and disliked about it, and just some
oddities I implemented here using FVWM's configuration pseudo-language
(which only becomes Turing complete due to its "PipeRead" directive).

                  How I got started with FVWM
                  ---------------------------

I can't remember the original impetus for me wanting to switch window
managers, which I assume I was probably using GNOME on Debian
Squeeze. I had been using GNU Emacs for a long time already and
probably got to thinking "Man, I wish I had this extensibility for my
desktop". Either that or I googled "best unix hacker window manager"
out of some egotistical need to prove to myself that I had some
respectable level of CS street-cred at Berkeley. In retrospect, this
was more-or-less pointless as I basically didn't talk to other CS
students out of my own social ineptitude at the time. I think only
time did another guy notice my WM config in the basement of Soda Hall
and strike up a conversation about it.

Anyway, I ended up finding IronPhoenix's awesome webpage detailing her
quest for the perfect window manager. (http://ironphoenix.org/fvwm/)
It's a great read. Read it if you can. It's got screenshots and
everything, not like this repo.
I think it really sold me on the configurability of FVWM, and the
creativity one can have when they're allowed to twiddle and tweak
things in an open-sandbox like way. It was software that allowed you
to have your own vision outside of whatever the original author might
even imagine someone wanting. There's a lot of open-source free/libre
software that are *theoretically* free in that, yes, you can recompile
software to change stuff. But they don't make it easy. The friction's
too high for any real user-freedom to take place. Yeah, you "could"
make GNOME have wonky key bindings, window styles and placements,
panels or whatever, but you *won't* because it's not designed to let
you. It's like GNOME was a coloring book whereas FVWM was a piece of
paper. GNOME will generally look better (and my FVWM was *UGLY*), but
you can't change the outline of a dolphin into a giraffe.

The other selling points of FVWM for me was I once heard it described
as the "Emacs of WMs", and that it was so configurable that even the
"F" in "FVWM" was configurable. (Historically, at some point people
had forgotten what the "F" originally stood for. Years later people
dug up that it originally stood "feeble", but at that point people
just adopted the "F" as "F(?)".)

                   Things I liked about FVWM
                   -------------------------

Desktops/Pages

Virtual desktops (or "pages" ["viewports" in Sawfish terms]) with
mouse edge scrolling. You could instantly flip back and forth between
pages on the same desktop by flicking your mouse over the edge.  The
spatial metaphor here is great. Instead of having to Alt-tab until I
found the window I wanted, I just had to move my mouse "left and up"
for something like Firefox (although it was still Iceweasel in Debian
back then), "down" for Emacs, and "right" for whatever graphs or
output from Emacs I was working on.

     +-----------+-------------+
     |           |             |
     |  Firefox  |             |
     |           |             |
     +-----------+-------------+
     | Emacs     |  "Output"   |
     |   +       | like graphs,|
     |   Xterm   | compilation.|
     +-----------+-------------+

The FVWM Pager made it easy to see where things were laid out.

With some scripting, different desktops could have different
backgrounds (basically by calling either "feh" or "fvwm-root"), which
made it easy to associate different applications with different
cognitive contexts.

SloppyFocus

FVWM got me really liking SloppyFocus (focus follows the mouse
pointer). Unlike keyboard purists I found that flicking my mouse with
my touchpad was a quick and easy way to switch between windows, which
I probably did a lot when I had Emacs and some xterms side by side.

Panels/FVWM Buttons

FVWM buttons was this weird but awesome configurable panel that was
basically able to "absorb" a bunch of small windows into one large
panel. I basically used it to absorb the desktop pager, a system tray
(stalonetray), a clock, and a conky instance that showed stats like
CPU usage, memory, internet, and so forth. I also had a
Quake-console-style panel that could auto-hide that had three
terminals (two were just constantly tailing some log files).

Application-specific hotkeys

It wasn't exactly built in, but you could easily make a hotkey to "go
to your default Emacs instance on its designated desktop". And if it
wasn't started (no windows matched), it would automatically start it.
I had keys to automatically go to Emacs, Icedove, Pidgin, and whatever
I was using to play music (probably either banshee or mpd).

Configs that the community shared

One thing that sticks out in my mind was that this guy "taviso" had
some pretty cool FVWM snippets. I think he had stuff like iconifying
windows with a screenshot as a mini thumbnail (or maybe I got that
from someone else). Also I either got the code for Packing/Moving
windows from a post from him or Thomas Adam. Years later when I saw
lots of security vulnerabilities by Tavis Ormandy, I was like "whoah!
that's the same guy who had those great FVWM snippets!". Other famous
FVWM users include Donald Knuth, but I never saw any cool .fvwmrc from
the guy so whatever. :P

Tiling without a tiling WM

Speaking of packing/moving windows. One of the great things about FVWM
was that you had a stacking window manager that you could add some
tiling-like hotkeys to. It was important to me to not use a tiling WM
because GIMP at the time would spawn like 5 different windows of
different sizes that it positioned weirdly. And there's no way that
would have worked well in a strictly tiling WM.

                  Weird things about FVWM
                  -----------------------

The weirdest thing about FVWM is that despite its flexibility its
configuration *isn't* a programming language. This kind of lead to a
lot of pain points.

You basically don't have FVWM-internal variables. You could set
environment variables but that would start to show up in all your
subprocesses you spawned. If you set variables this way, people would
generally scold you on the forums.

What you *could* do, though, is dynamically define or append to
functions (using "AddToFunc"). I abused the hell out of this. I had
functions that created functions to show or hide windows by
application class or window id. I had a function called
"MakeWeirdFunc" (because I suck at names and it *is* weird) that made
it possibly to dynamically add hotkeys to specific windows (like
quickly pulling up a specific Emacs frame, no matter which desktop or
page you were on).

This was written in something that wasn't a "functional language" both
in the sense functions aren't values (and I don't think functions even
*return* anything, they just execute statements) and in the sense that
it isn't really a programming language. Any time you had to do stuff
like add screen coordinates, you had to use "PipeRead" to calculate it
with some bash one-liner or a shell script.

Other miscellaneous stuff in my FVWM config
-------

Animated edge scrolling. Normally flipping edges is done
instantaneously. This disorients a lot of people, so I added some
functions to "scroll" along the side so they'd understand what's going
on. Normally I wouldn't use it though because it was slow.

Hotkeys to bring a menu to read the clipboard using espeak
text-to-speech. I basically used this to read Kafka's Metamorphosis
sometime in 2010.

Some tiling-like capabilities.

Random transparency hotkey stuff. Nothing special. Everyone was doing
it to look cool at the time though.

                Moving away from FVWM
                ---------------------

At some point for some reason I started using Sawfish. I always saw
comparisons between FVWM and Sawfish as being the two most extensible
window managers. I don't remember exactly when or why I started using
Sawfish. Maybe I had upgraded my laptop and was trying something
new. Maybe the fear of using environment variables in FVWM was getting
to me. But eventually, sometime near the end of college I tried
Sawfish and basically instantly loved it.

Probably the nicest thing was actually being able to use
variables without being shamed for polluting the environment
variables. You could store not just global variables but
window-specific variables as well. Documentation for Sawfish was
actually incredibly good, too, being laid out in two "info" manuals
(one for librep [Sawfish's lisp language] and one for Sawfish
itself). FVWM's documentation was mostly really long man pages that
were a bit unwieldly for me to navigate. Both were great in that they
had REPLs (which is super important for easy extensibility), but
Sawfish had the advantage of being better integrated into Emacs.

I think I kept using FVWM and Sawfish interchangeably for a while. If
you look in my dot-sawfish repository, you'll notice that the links to
all the wallpapers are still in my "~/.fvwm/wallpaper/". :)

That being said, FVWM is still a great window manager, and I miss my
old config from time to time. I wish I made it more portable instead
of using absolute paths to files outside the repository. (Mostly shell
scripts.) FVWM's desktop pager was a lot more configurable (I believe)
than Sawfish's was. FvwmButtons is something that I've *never* found
anywhere else, and I find I occasionally miss my Quake console.

FVWM taught me a lot about the value and joy of user-accessible
extensibility. If you give your users building blocks instead of just
twisty-knobs, they can make really cool things.

Would I recommend FVWM today? Yeah, I think so. Since we're not all
Wayland yet, you might as well have a nice personalized X Window
Manager. Considering that most computer time is spent in a WM, it
might as well be cozy, comfortable, and ergonomic. And FVWM is a great
and incredibly easy way to get started in that.

FVWM I think still far outweighs Sawfish in terms of popularity,
despite the latter actually having been the official GNOME WM for a
short while. Maybe the fact that it's not using a full-fledged lisp is
actually one of its biggest features. You don't think "oh, I'm not a
programmer I can't use this", you think "Oh, it's just a text config,
this is easy". And then gradually as your config changes over time you
realize... you never needed to *be* a "programmer", you were
programming all along!

(Written 2020.Jan.24)
