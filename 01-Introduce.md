# <img src="./Images/img-xcode.png" height="30"> Introduce configuring targets and builds for an iOS application

_Written by: **Nguyen Minh Tam**_

**Menu**



## Goal

At the end of the day, we will:

- Understand these Xcode concepts:
	- Xcode Target
	- Xcode Scheme
	- Xcode Workspace
	- Build Settings
- Know how to manage these concepts in Xcode.

Sounds interesting, right? Let's go! 🔫


## Xcode Target

- A target specifies a product to build and contains the instructions for building the product from a set of files in a project or workspace. 
	- The instructions for building a product take the form of build settings and build phases.
	- A target inherits the project build settings, but you can override any of the project settings by specifying different settings at the target level. (the project build settings will be mentioned right after this part)
	- There can be only one active target at a time; the Xcode scheme specifies the active target.
- A target defines a single product; it organizes the inputs into the build system—the source files and instructions for processing those source files—required to build that product. 
- Projects can contain one or more targets, each of which produces one product.
- You can see more about dependent target in official doc [here][Target]. To keep it simple, I introduce how to manage targets it in Xcode:

<center>
	<img src="./Images/bs_buildsettings_general.png" width="600">
</center>

As you can see, we can adjust several settings for the targets in your project, such as:

- General settings: identity, signing, deployment info,...
- Capabilities settings.
- Resource tags settings.
- Info settings.
- Build settings.
- Build phases settings.
- Build rules settings.

You can find out more detail about what we can do with target in [this doc][Config]. Right now I am going to talk about Xcode project, which you saw in the Project navigator in the previous image.

## Xcode Project

- An Xcode project is a repository for all the files, resources, and information required to build one or more software products. It contains:
	- All the elements used to build your products and maintains the relationships between those elements. 
	- One or more targets. 
	- Default project build settings for all the targets in the project (each target can also specify its own build settings, which override the project build settings).

- An Xcode project file contains the following information:
	- References to source files:
		- Source code, Libraries and frameworks, Resource files, Image files, Groups used to organize the source files
		- Project-level build configurations. You can specify more than one build configuration for a project. For example: A project have debug and release build settings. We will see an example in [this project][ConfigWithXcconfig].
	- Targets.
	- The executable environments that can be used to debug or test the program. You can see more detail in this [official doc][Project].
- A project can stand alone or can be included in a workspace.
- Use Xcode schemes to specify which target, build configuration, and executable configuration is active at a given time. 

I will talk ablout Xcode scheme later in this section. Now, we go to what is build settings and what it does affect to the project and target level.
