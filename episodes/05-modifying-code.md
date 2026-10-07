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
- Validate that the generated code does what is needed
- Document the changes made
- Reflect on what they are learning and what the chatbot is and is not helping with.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- FIXME

::::::::::::::::::::::::::::::::::::::::::::::::::

## Using What We Have Learned
It is time to move on from analysing code that has already been written, and begin generating new code with the help of a chatbot.
The knowledge you have gained so far will help with this.

A conceptual understanding of how code works and how it describes what the computer should do, the ability to break down a task into a series of actions and decisions (often referred to as computational or algorithmic thinking), and some familiarity with technical terminology will all help you write a prompt that is more likely to generate the code you want.
As you continue to practice these skills, you will become more capable of anticipating what the code needed to perform a new task will look like.
And your ability to trace the flow of the generated code and test or query the parts you do not understand, will help you evaluate the usefulness of the output you receive from your chatbot (more on this in the next episode).

## Modifying a script
Before we start generating whole programs, let's spend some time modifying some existing code.
It is fairly common to need to adapt or extend some code written by somebody else, and the experience here will help prepare you for generating new sections of code and whole programs from scratch later.

[`plotting_script.R`](files/plotting_script.R) loads a CSV file of data from Gapminder and creates two figures, showing how life expectancy has changed over time in countries on Africa and the Americas.

```r
library(ggplot2)

fpath <- "~/Desktop/gapminder_data.csv"

gapminder <- read.csv(fpath)

summary(gapminder)

ggplot(data = gapminder, mapping = aes(x=year, y=lifeExp, group=country, color=continent)) +
  geom_line()

americas <- gapminder[gapminder$continent == "Americas",]
ggplot(data = americas, mapping = aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

africa <- gapminder[gapminder$continent == "Africa",]
ggplot(data = africa, mapping = aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

The script can be opened and run in R Studio.
As long as the associated data file, `gapminder_data.csv`, is present on the Desktop, the code will produce three figures.

:::::::::::::::::::::::::::::::: warning

### Looking for the data?
If you do not already have the data downloaded and saved on your system, follow [the lesson setup instructions](../index.md#setup) to obtain it.

::::::::::::::::::::::::::::::::::::::::

![Life expectancy over time in countries on Africa](fig/lifeExp_plot_Africa.png){alt="multi-panel figure of line plots, one per country, showing a trend of broadly increasing life expectancy between FIXME and FIXME observed in countries on Africa."}

![Life expectancy over time in countries on the Americas](fig/lifeExp_plot_Americas.png){alt="multi-panel figure of line plots, one per country, showing a trend of broadly increasing life expectancy between FIXME and FIXME observed in countries on the Americas."}

This code works -- it runs without errors and produces plots -- but definitely has room for improvement.

:::::::::::::::::::::::::::::: challenge

### How Could The Script Be Improved?
With a partner or in small groups, and **without consulting your chatbot**, discuss how this example script could be improved.
At this stage, focus on improvements that would make the code easier to read, easier to maintain, easier to adapt to another data set, or produce better output plots.
Do not spend time discussing what additional functionality might enhance the script. 
This will be discussed in the next section.

Expand the hint below to reveal some principles of good software engineering that might be applicable here.


::::::::::::::::::::::::: hint

Two relevant principles of software engineering:

1. **DRY: Don't Repeat Yourself**.
   Make code more easily maintainable by avoiding multiple copies of identical or very similar code.
   These can usually be removed by capturing the repeated elements as functions, which can then be called each time you want to perform those actions.
   This way, the code can be changed in one place (the function definition) for that change to be applied everywhere the function is used.
2. **Make code configurable**.
   Avoid "hard coding" inputs that will affect how the code operates or what it operates on, e.g. the values of important parameters in an analysis or the locations of input files.
   This will make your code more adaptable e.g. when you want to perform the same analysis on a new data file with a different name, or on different subsets of the same data.

You may also find it helpful to review the points under "Software" in Box 1 of [_Good Enough Practices for Scientific Computing_ (Wilson et al, 2014)](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510), and the explanations of these points further down the article.

> 2. Software
> 
> a) Place a brief explanatory comment at the start of every program.
> b) Decompose programs into functions.
> c) Be ruthless about eliminating duplication.
> d) Always search for well-maintained software libraries that do what you need.
> e) Test libraries before relying on them.
> f) Give functions and variables meaningful names.
> g) Make dependencies and requirements explicit.
> h) Do not comment and uncomment sections of code to control a program's behavior.
> i) Provide a simple example or test data set.
> j) Submit code to a reputable DOI-issuing repository.

::::::::::::::::::::::::::::::

::::::::::::::::::::: solution

The script could be improved by:

* providing the user with a way to specify the location of the input data file (`gapminder_data.csv`)
* capturing the code that produces the multi-panel figures for the countries on a continent in a function, then calling that function twice to produce the figures.
* providing a way for the user to specify the title of the figures being produced, or for those titles to be set based on some relevant information e.g. the name of the given continent.

Did you find any other potential improvements?

::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::: instructor

### Gather these suggestions
You may find it helpful to gather and de-duplicate the suggestions generated from learners' discussions in this exercise.
You can return to this list in the next section, comparing it to the reponses generated by chatbots.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

What suggestions does the chatbot have for how this short program could be improved?
Provide the script to the chatbot along with the prompt quoted below: most chatbots provide a way to upload a file but you can copy/paste the whole code block above if not.

> I have inherited this R script from a colleague and would like to tidy it up and ensure that the code follows good practices that will make it easy to maintain and adapt in the future. 
> Review section 2, Software, of Good Enough Practices for Scientific Computing, available at https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510 then give me a short list of ways that the script could be improved. 
> Describe the potential improvements in terms that will be understandable for a novice programmer, and include examples where necessary.
> Do not make any changes to the script I have provided.

How does the response generated from this prompt compare to the points you identified in the previous discussion?
One difference you might observe is the chatbot producing a longer list than you were able to do as a pair or a group.
Do not let this bring you down: recognising opportunities to improve the structure and organisation of code is a skill that develops alongside expertise in other aspects of programming, and it should be expected that those new to coding cannot identify many opportunities in a short space of time.

Was the chatbot's response understandable? If not, ask clarifying follow-up questions.

### Making a plan

::::::::::::::::::::::::::::::::::::::::::::::::: instructor

### Leading this discussion
It is unlikely that an audience of novice programmers will be able to answer the discussion prompts completely, and learners may lack confidence to contribute to this discussion when they do have ideas.
You should lead this discussion, drawing on your own experience to review and comment on the suggestions generated by your chatbot and any additional points raised in the responses that learners received.
Be explicit about your thought process: insight into how an expert thinks about and approaches the evaluation of chatbot output will be highly valuable to learners.
Be judicious about which suggestions you recommend that learners pursue and which they put aside to potentially follow up on later: adjusting variable names and file paths is more likely to be understandable to a novice than pinning package versions.

Some suggestions for how you could facilitate this discussion:

* Share the response you received from the same prompt. 
  Ask learners if their responses included any suggestions that do not appear in yours.
  If so, gather the additional suggestions in the shared notes so that you ahve a single list to work through.
* Work through the complete list of suggestions, evaluating them one at a time. 
  Invite learners to share their thoughts, but expect to do most of the talking since you are the expert.
* Encourage learners to reflect on this mismatch between your ability to evaluate the suggestions and theirs, and emphasise that they will continue to develop their skills as they gain more experience through practice.
* After you have completed this group discussion, you could share your screen while asking the chatbot, in a new chat/session, to review the suggestions and provide feedback on them/prioritise them. 
  Then, discuss how the chatbots response compares to the conclusions drawn from your evaluation.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

At this point in the episode, the Instructor should lead a discussion of the suggestions for improvement that the group has gathered so far.

* Did anyone in the learner group identify any potential improvements that were not mentioned in the chatbot's response?
* Are all of the suggestions in the chatbots' responses good? Should all of the proposed improvements be made to the code? 
* Did the chatbot's response distinguish between recommended and optional improvements? If so, does that distinction match your assessment?
* Are any of the suggestions out of scope, or lower priority changes that could be saved for later? Are any of them spurious suggestions that can be ignored altogether?

Based on this discussion, construct a list of 3-5 improvements you want to make to the code first.
Then, ask the chatbot to make one of those improvements, producing a new version of the script.
For example, we might ask the chatbot to modify the code to use more meaningful variable names:

> Modify the code to use more meaningful variable names.
> Do not apply any of the other suggested improvements.

Examine the code generated in response to this prompt.
What has changed?
How does this compare to what you expected?
Run the modified version of the script. 
Does it still do what it did before, or have the modifications changed the outputs or behaviour of the program?

:::::::::::::::::::::::::::::::::::::::: challenge

### Apply another suggestion
Prompt your chatbot to modify the code, to replace repetitive code with functions.
Before you submit this prompt, _think_ about what you expect it to change.
Now _execute_ the prompt and _review_ the generated response.
_Reflect_ on how that response -- and especially the modified code included in it -- compares to your expectations.

Run the modified code again, and check whether the outputs or behaviour of the script have changed.

::::::::::::::::::::::::::::::::::::::::::::::::::

If everything has gone well so far, execute one or two more of the planned improvements to the script.
Now that the script has been cleaned up, we can move on to the next step: extending its functionality.

* now that the script is clean, we can think about extending the functionality.
    * ask the audience how they would modify the script -- what would they want it to do? e.g. adjust the script to use wildcard to capture all \*.tsv files in the working directory
    * spend some time writing prompt together as a group: 
        * what info should we include?
        * how should we describe the change we want made?
        * ask participants what they expect to see in the changes produced?
    
EXERCISE to allow participants to experiment some more

Follow-up discussion EXERCISE to find out what people learned, where they got stuck, any weird behaviour observed from the chatbot, etc?

Toby: I found myself wondering about version control as I worked on this outline: as learners get more and more into this, they are increasingly going to benefit from viewing diffs of changes being made. the commit history also helps the model (then agent) keep track of what's been done and why, which facilitates experimentation and work spread across multiple sessions. Where and how can we gracefully introduce this stuff?
