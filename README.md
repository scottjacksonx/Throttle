#Throttle

Throttle is a small OS X app that lets you throttle bandwidth on port 80 of your Mac.

My number-one use case for Throttle is this: while I'm waiting for a video to finish downloading to my Mac, I sometimes like to go and do other things -- play with my iPhone, play some computer games -- things that involve an internet connection. Thing is, if my Mac's sitting there downloading a video, it'll hog all of what little bandwidth I have. Throttle limits how much bandwidth your Mac can use. That's all there is to it.

At this point, Throttle is fairly sparse -- there's no pretty icon yet, nor is there a lot of error checking. There are also a few easy ways to break it.

The easiest way I can think of to break Throttle is to start throttling and then close the application before turning throttling off.

**If that happens or anything else goes wrong:**

Open Terminal.app and run `sudo ipfw delete 1`. That will stop any bandwidth-throttling caused by Throttle.

##How To Use Throttle

If you want to be a nerd, download the project and compile it yourself from source. If you want to be a civilian, download the project and look in `build/Debug/` and you'll find a premade Throttle.app there.

