---
title: "Modifying Code"
teaching: 20 # teaching time in minutes
exercises: 2 # exercise time in minutes
---

::::::::::::::::::::::::::::::::::::::: objectives

_After following this episode, learners will be able to..._

- Describe what a simple existing script does
- Specify how the function of the script should change to meet a need
- Generate a modified script by interacting with an LLM chat bot
- Validate that the generated code what is needed
- Document the changes made
- Reflect on what they are learning and what the chatbot is and is not helping with.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- FIXME

::::::::::::::::::::::::::::::::::::::::::::::::::

## Using What We Have Learned

* it is time to move on from analysing code that has already been written, and begin generating new code
* the knowledge you have gained so far will help:
    * conceptual understanding, "computational thinking", and familiarity with technical terminology will help you write a prompt that is more likely to generate the code you want
    * you may be more capable now of anticipating what code you will get back
    * ability to trace the flow of the generated code and test+query parts you do not understand will help you evaluate the usefulness of the output (more on this in the next episode)
* back to our messy script: upload whole script to chatbot and prompt for:
    * a plan: what can be cleaned up and how?
        * discuss each of these suggestions. are they all useful, relevant? if the chatbot output includes a long list and makes a distinction between recommended and optional steps -- do you agree with these suggestions?
    * ask the chatbot to execute one of the proposed steps, e.g. clean up variable names
    * now re-run the script: is it doing the same thing as it was before?

Then an EXERCISE, giving learners the chance to try it out again on their own, e.g. refactor code into functions
    * (opportunity when looking at functions to call back to earlier "analysing code" episode, where we pulled out chunks and tried them out -- often, when you have finished tweaking some code and getting it to do what you want, you should capture it as a function)

* now that the script is clean, we can think about extending the functionality.
    * ask the audience how they would modify the script -- what would they want it to do? e.g. adjust the script to use wildcard to capture all \*.tsv files in the working directory
    * spend some time writing prompt together as a group: 
        * what info should we include?
        * how should we describe the change we want made?
        * ask participants what they expect to see in the changes produced?
    
EXERCISE to allow participants to experiment some more

Follow-up discussion EXERCISE to find out what people learned, where they got stuck, any weird behaviour observed from the chatbot, etc?

Toby: I found myself wondering about version control as I worked on this outline: as learners get more and more into this, they are increasingly going to benefit from viewing diffs of changes being made. the commit history also helps the model (then agent) keep track of what's been done and why, which facilitates experimentation and work spread across multiple sessions. Where and how can we gracefully introduce this stuff?
