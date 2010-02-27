#Throttle

![Throttle](http://scottjackson.org/software/img/throttle.png "Throttle")

Throttle is a small OS X app that lets you throttle bandwidth on your Mac.

My number-one use case for Throttle is this: while I'm waiting for a video to finish downloading to my Mac, I sometimes like to go and do other things -- play with my iPhone, play some computer games -- things that involve an internet connection. Thing is, if my Mac's sitting there downloading a video, it'll hog all of what little bandwidth I have. Throttle limits how much bandwidth your Mac can use. That's all there is to it.

By default, Throttle will throttle bandwidth on port 80, but which port gets throttled can be changed in the Preferences window.

##How To Use Throttle

If you want to be a nerd, download the project and compile it yourself from source. If you want to be a normal person, download the project and look in `build/Debug/` and you'll find a premade Throttle.app there.

##TODO

- Currently, Throttle gets your sudo privileges (you need to be root in order to throttle bandwidth) in a kinda hack-y way which means you have to enter your username+password way more often than you should. I'm working on that.
- If you close the application by clicking on the red X button while throttling is turned on, throttling will stay on. If you accidentally do that, open up a terminal window and run `sudo ipfw delete 1`. That will get rid of any throttling caused by Throttle.

