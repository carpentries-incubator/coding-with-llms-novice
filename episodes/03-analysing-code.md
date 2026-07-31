---
title: "Analysing a Real Program"
teaching:  # teaching time in minutes
exercises:  # exercise time in minutes
---

::::::::::::::::::::::::::::::::::::::: objectives

_After following this episode, learners will be able to..._

- Run a block of code.
- Trace the flow of a block of code.
- Make small modifications to a block of code and observe how its behaviour changes.
- Prompt a chatbot for an explanation of a line or block of code.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- FIXME

::::::::::::::::::::::::::::::::::::::::::::::::::

## Understanding Existing Code
The code below generates a set of line plots showing how average life expectancy has changed over time in countries in the Americas, which are then saved to image files in an output directory.

```R
library(ggplot2)

plot_life_expectancy <- function(df, country, outdir="results") {
  lifeExp_plot <- ggplot(data = americas[americas$country == country,], mapping = aes(x = year, y = lifeExp)) +
    geom_line()
  ggsave(filename = paste0(outdir, "/", country, "_lifeExp.png"), plot = lifeExp_plot, width = 12, height = 10, dpi = 300, units = "cm")
}

gapminder <- read.csv('gapminder_data.csv')
americas <- gapminder[gapminder$continent == "Americas",]

for (country in unique(americas$country)) {
  plot_life_expectancy(gapminder, country)
}
```

There is a lot to understand in these eleven lines and, if you have never written any code before, it can feel overwhelming to be presented with a program like this.
If we are going to generate our code with AI instead of writing it line-by-line, inspecting a lot of code is the trade we make in exchange for the increased speed of writing.
It may be tempting to assume that AI-generated code is correct.
But we have a responsibility to ensure that the results produced by our code are correct.
A key skill we need to develop is the ability to trace the execution of code, to understand how information flows through the program and what might be done to it along the way.
By practicing this skill, we can develop our ability to review code that has been generated.

### Reverse-Engineering
Time worn strategies for understanding what a chunk of code is doing are to a) run it, and b) mess around with it!
It is helpful to spend some time doing this even if you plan to generate all of your code with AI.

If the code we want to understand is part of a larger program, we can copy out a line or chunk and run it.

:::::::::::::::::::::::::::::::::::::::::: callout

### Think before you run the code
A good habit to get into, to help you learn how to read code, is to try to predict what the output of some code will be before you run it.
Comparing the results against your prediction will help you spot and correct any misconceptions you might have picked up.

::::::::::::::::::::::::::::::::::::::::::::::::::

```R 
unique(americas$country)
```

```output
 [1] "Argentina"           "Bolivia"             "Brazil"              "Canada"              "Chile"              
 [6] "Colombia"            "Costa Rica"          "Cuba"                "Dominican Republic"  "Ecuador"            
[11] "El Salvador"         "Guatemala"           "Haiti"               "Honduras"            "Jamaica"            
[16] "Mexico"              "Nicaragua"           "Panama"              "Paraguay"            "Peru"               
[21] "Puerto Rico"         "Trinidad and Tobago" "United States"       "Uruguay"             "Venezuela"   
```

:::::::::::::::::::::::::::::::::::::::::: callout

### R Studio Makes This Easier
Working in R Studio, you can also select some of the code and press the "Run" button to run only that selection.
This works for multiple lines, a single line, or even part of a line.

::::::::::::::::::::::::::::::::::::::::::::::::::

Making a small adjustment to the code before running it again is another good way to build and test your understanding.

```R
unique(americas$continent)
```

```output
[1] "Americas"
```

As long as you do this on a copy, you can always recover the original version.
And you can learn a lot about how a program works through this kind of reverse-engineering.

Let's do this again to explore what the `paste0(...)` part is doing:

```R
paste0(outdir, "/", country, "_lifeExp.png")
```

```error
Error: object 'outdir' not found
```

This error message tells us that we cannot run that section of the code on its own: 
`outdir` is a _variable_ that gets assigned a value in the code, and that value is then used in the `paste0` _function_ in some way (`country` is another variable).
When we run the whole program, these variables are being created and assigned a value.
But when we try to run the function in isolation, they are not.
So we need to also define the variables, or replace them with values directly.

```R
# option 1: assign values to the variables
outdir <- "output_directory"
country <- "germany"
paste0(outdir, "/", country, "_lifeExp.png")
```

```output
[1] "output_directory/germany_lifeExp.png"
```

```R
# option 2: replace the variables with literal values

paste0("output_directory", "/", "germany", "_lifeExp.png")
```

```output
[1] "output_directory/germany_lifeExp.png"
```

:::::::::::::::::::::::::::::::::::::::::: callout

### Comments
The lines beginning with `#` above are _comments_: notes we can add to the code that are ignored when it is executed.
As well as using them to annotate code as we did above, we can add `#` at the start of any lines we want to temporarily deactivate.
This is another quick way of isolating particular line(s) of the code that we want to run: "comment out" the other lines then run the program.

Most text editors provide a keyboard shortcut to quickly comment out/in lines, and getting used to this can be a great time-saver.
(Look under the `Code` dropdown menu for the keyboard shortcut in R Studio on your system.)

::::::::::::::::::::::::::::::::::::::::::::::::::

## Paths
In our program, the output of this `paste0` function call is used as the name of the image file created to store the data visualisation.
`output_directory/germany_lifeExp.png` is the _relative path_ of the image file that will be created.
Paths are the way that programs describe locations on the computer's filesystem, and there are two types: _relative paths and absolute paths_.
A relative path defines a location on the filesystem _relative to your current location_, whereas an absolute path describes its location from the _root_ of the filesystem.

The filesystem is a tree-like structure branching out from the root:

![Diagram of a filesystem.](
    fig/filesystem.svg
){
    alt='A file system made up of a root directory that contains sub-directories titled bin, data, users, and tmp, and three subdirectories under users'
}

The root folder is referred to as `/`, with more forward-slashes used to indicate levels of the filesystem. 
For example, `/Users/nelle` describes the absolute path of the user `nelle`'s home directory.
From Nelle's directory, a relative path to user `imhotep`'s home directory would be `../imhotep`, where `..` means "up one level".
Paths can take a bit of getting used to!
Software Carpentry's lesson [_The Unix Shell_](https://swcarpentry.github.io/shell-novice/02-filedir.html) is a good resource for learning more about them.

## Peeking Inside The Machine
While doing the kind of reverse-engineering we described above, we may want to keep track of the values that particular variables hold and how those change while the code is running.
While advanced "debugger" tools exist to do this more rigorously, a lot of beginners and experienced programmers take a less sophisticated but more accessible approach:
telling the program to report what things look like while it runs.
This is done with the `print` function:

```R
for (country in unique(americas$country)) {
  print(country)
  plot_life_expectancy(gapminder, country)
}
```

```output
[1] "Argentina"
[1] "Bolivia"
[1] "Brazil"
[1] "Canada"
[1] "Chile"
[1] "Colombia"
[1] "Costa Rica"
[1] "Cuba"
[1] "Dominican Republic"
[1] "Ecuador"
[1] "El Salvador"
[1] "Guatemala"
[1] "Haiti"
[1] "Honduras"
[1] "Jamaica"
[1] "Mexico"
[1] "Nicaragua"
[1] "Panama"
[1] "Paraguay"
[1] "Peru"
[1] "Puerto Rico"
[1] "Trinidad and Tobago"
[1] "United States"
[1] "Uruguay"
[1] "Venezuela"
```

These `print` lines can be commented out and in as needed while you experiment with your code, and you can delete them when you are done.

:::::::::::::::::::::::::::::::::::::::::::::::::: challenge

### Keep Exploring
Refering to the example code block at the top of this episode, find another part of the code that you would like to understand better.

1. What do you think it is doing?
2. How could you isolate and modify that part of the code to find out whether your prediction is correct?

Try making these changes and reflect on whether or not your expectations were correct.

::::::::::::::::::::::::::::::: solution

### An Educational Example
You might choose to look at how the name of the output file changes as the program runs.
To do that, we need to edit the `plot_life_expectancy` function that is run in loop.
Unlike built-in functions like `print` and `unique`, which exist in R by default, `plot_life_expectancy` is defined in our program.

```R
plot_life_expectancy <- function(df, country, outdir="results") {
  lifeExp_plot <- ggplot(data = americas[americas$country == country,], mapping = aes(x = year, y = lifeExp)) +
    geom_line()
  ggsave(filename = paste0(outdir, "/", country, "_lifeExp.png"), plot = lifeExp_plot, width = 12, height = 10, dpi = 300, units = "cm")
}
```

It is then run in the `for` loop, once for each country in the Americas, with the `country` parameter changing each time.

```R
for (country in unique(americas$country)) {
  plot_life_expectancy(gapminder, country)
}
```

To look at how the name of the output file used in that function changes each time, we need to tell our function to print out the result of `paste0`:

```R
plot_life_expectancy <- function(df, country, outdir="results") {
  lifeExp_plot <- ggplot(data = americas[americas$country == country,], mapping = aes(x = year, y = lifeExp)) +
    geom_line()
  print(paste0(outdir, "/", country, "_lifeExp.png"))
  ggsave(filename = paste0(outdir, "/", country, "_lifeExp.png"), plot = lifeExp_plot, width = 12, height = 10, dpi = 300, units = "cm")
}
```

This `print` will be run every time the `plot_life_expectancy` function is called, so we will see it for each country as the loop progresses:

```R
for (country in unique(americas$country)) {
  plot_life_expectancy(gapminder, country)
}
```

```output
[1] "results/Argentina_lifeExp.png"
[1] "results/Bolivia_lifeExp.png"
[1] "results/Brazil_lifeExp.png"
[1] "results/Canada_lifeExp.png"
[1] "results/Chile_lifeExp.png"
[1] "results/Colombia_lifeExp.png"
[1] "results/Costa Rica_lifeExp.png"
[1] "results/Cuba_lifeExp.png"
[1] "results/Dominican Republic_lifeExp.png"
[1] "results/Ecuador_lifeExp.png"
[1] "results/El Salvador_lifeExp.png"
[1] "results/Guatemala_lifeExp.png"
[1] "results/Haiti_lifeExp.png"
[1] "results/Honduras_lifeExp.png"
[1] "results/Jamaica_lifeExp.png"
[1] "results/Mexico_lifeExp.png"
[1] "results/Nicaragua_lifeExp.png"
[1] "results/Panama_lifeExp.png"
[1] "results/Paraguay_lifeExp.png"
[1] "results/Peru_lifeExp.png"
[1] "results/Puerto Rico_lifeExp.png"
[1] "results/Trinidad and Tobago_lifeExp.png"
[1] "results/United States_lifeExp.png"
[1] "results/Uruguay_lifeExp.png"
[1] "results/Venezuela_lifeExp.png"
```

::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

EXERCISE: draw a flow chart describing the code.

* when you get stuck, cannot figure out what a particular block of code is doing, ask somebody.
* paste the code into your chatbot, ask it to explain the code. Include information about your level of expertise.
    * always try to understand it yourself first, or at least make a guess: you will learn more if you can compare the chatbot's response with the answer you expected.
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
* this will seem slow at first, but you will be able to move more quickly as you continue to learn
