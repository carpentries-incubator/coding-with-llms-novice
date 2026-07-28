---
title: "Analysing a Real Program"
teaching:  # teaching time in minutes
exercises:  # exercise time in minutes
---

::::::::::::::::::::::::::::::::::::::: objectives

- FIXME
-

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- FIXME

::::::::::::::::::::::::::::::::::::::::::::::::::

## Understanding Existing Code

* introduce some messy script
    * important to also (briefly) discuss the way scripts are used: typically run on the command line by an interpreter program. that means learning a bit about file paths.

* a good (AI-free) strategy is to copy out chunks of code and run them, adjust them and run again.
* as long as you do this on a copy, you can always recover the original version
* you will often need to include variables from further up the script.
    * with practice, it becomes faster to comment out lines you do not want to run. Most text editors/IDEs provide a keyboard shortcut for this (often Ctrl+/).
    * it can be very helpful to insert `print` statements at chosen points throughout the code to give a quick indication of the state of variable(s) during execution. Comment them out as needed and remove them altogether when you are done.
    * if you need to, add comments as you go to make note of what's going on.
    * (later on in the lesson: when you have a chunk behaving how you want it to, it might be good to capture that as a function.)
* this will help you trace the execution of code, an essential skill for evaluating whether code is doing what you want/need it to even if the code itself is AI-generated (or written by somebody else -- or by yourself three months ago!)

EXERCISE here giving learners a chance to practice isolating and interrogating a section of code.

EXERCISE: draw a flow chart describing the code.

* when you get stuck, cannot figure out what a particular block of code is doing, ask somebody.
* paste the code into your chatbot, ask it to explain the code. Include information about your level of expertise.
* if the response includes words you do not understand, ask for a definition (Glosario can be a good source of these too). More on this in the next episode.
* check your understanding and the veracity of the explanation that was generated.
* based on your interpretation of the response, adjust the code, predict what will change in the output/behaviour, then run it and check whether you were right.

EXERCISE or activity here for learners to try identifying a small change to a chunk of code, based on the explanation provided.

* if you get an unexpected result, refer back to the explanation you received and the output you observed, and try to identify your misconception. if you cannot find it, explain to the chatbot what you changed, what you expected to see, what you actually got, and ask for clarification. "what am I missing?" rather than "fix it for me".
* bear in mind: sometimes the chatbot will make mistakes! if you don't seem to be making any progress after trying this for a while, try to find a human to ask, or fire up a new chatbot session to get a "second opinion".
* all of the above is a good strategy if you are getting help from a human too!

* what about providing the entire code base all at once? wouldn't that be quicker than analysing it line-by-line, section-by-section?
* it will be harder for you to build you own understanding of the code -- it is easier to trace execution through a handful of lines than through hundreds
* the explanation you receive may be too high-level, e.g. explaining _what_ the script does but not helping you understand _how_
* or it may be so long that it becomes overwhelming
* managing cognitive load by keeping explanations short and taking regular opportunities to test your understanding will aid your learning
* this will seem slow at first, bnut you will be able to move increasingly quickly as you continue to learn
