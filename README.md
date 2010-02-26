#Throttle

Throttle is a small OS X app that lets you throttle bandwidth on port 80 of your Mac.

My number-one use case for Throttle is this: when I'm waiting for a (totally legal, what's up) video to finish downloading, I sometimes like to go and do other things -- things that involve an internet connection. Thing is, if my Mac's sitting there downloading a video, it'll hog all the bandwidth. Throttle limits how much bandwidth your Mac can use. That's all there is to it.

At this point, Throttle is fairly sparse -- there's no icon yet, nor is there any error checking. There are also a few easy ways to break it.

##If, at any time, something goes wrong:

Go to Terminal.app and run `sudo ipfw delete 1`. That will stop any bandwidth-throttling caused by Throttle.