# Automated Super Mario World Project Template

This repository is a template or "baserom" for Super Mario World hacking projects focused on automation and [Git](https://www.git-scm.com/) compatibility, 
though it can also be used just fine without git.

The template is completely style-agnostic, as it includes no resources, but only tools. The point is to provide a 
convenient template that can be used for *any* hack.

In addition, this template could also serve as a "baserom for baserom" of sorts. Since it contains no resources, any type of baserom could be built from this template, as all it provides is a convenient pipeline for building, organizing and version-controlling projects.

This project template comes with the following tools:

- [Callisto v0.2.15](https://github.com/Underrout/callisto/releases/tag/v0.2.15)
- [Lunar Magic 3.40](https://dl.smwcentral.net/35121/)
- [FLIPS](https://dl.smwcentral.net/11474/)
- [AddmusicK 1.0.10](https://dl.smwcentral.net/35333/)
- [GPS V1.4.4](https://dl.smwcentral.net/31515/)
- [PIXI v1.41](https://github.com/JackTheSpades/SpriteToolSuperDelux/releases/download/1.41/pixi_v1.41.zip)
- [UberASMTool 2.0](https://github.com/Fernap/UberASMTool)

In addition, it comes pre-patched with SA-1 Pack v1.40 and includes a handy `.gitignore` file that 
contains ignore rules for common build artifacts.

If you have any suggestions or run into bugs with this template, please feel free to open an issue or ask in the [Discord server](https://discord.gg/SbRM8mUjdE) and I will do 
my best to assist, as long as the problem is directly related to this template project specifically and not one 
of the included tools or how to use them.

If you are unsure of how to use an included tool see if there is a tutorial available elsewhere (there is also a list of [available tutorials](https://github.com/Underrout/callisto/wiki#what-should-i-know-before-reading-this)).


# Setup 

## From ZIP file

I would recommend using this template with GitHub (or a different repository host) and [Git](https://www.git-scm.com/), but 
if you want you can also download the template as a ZIP file by clicking on `Code` and choosing 
`Download ZIP` from the dropdown menu and use it as-is.

Once you have downloaded it, you can simply unpack the ZIP archive wherever you would like to set up your 
project and continue reading at [Setting up Callisto](#setting-up-callisto).

## With GitHub and git

To create a new repository from this template using GitHub and git, first click the `Use this template`
button at the top of this repository's GitHub page. 

Afterwards, simply give your repository a name and, optionally, a description. You can choose to make 
the repository public for everyone to see or keep it private so only you can see it. I would recommend 
keeping it private since re-distributing essentially any hacking resource (sprites, patches, blocks, etc.) 
without a license is technically illegal. There is nothing technically preventing you from hosting a public 
repository, but you would be doing so at your own risk.

Now you can simply clone the repository to your local machine using `git clone`, like you would 
with any other repository, then keep reading to find out how to set up Callisto (if you haven't previously done so).

## Setting up Callisto

Now, open `callisto/callisto.exe`. You might get an antivirus popup, you can just dismiss it. Afterwards, a new folder will be created at `%appdata%/callisto`. This folder can store system-wide configuration for Callisto, meaning it lets us globally define where to find a clean Super Mario World ROM, as well as any emulators you want to use, so you only have to do this step once! In the `%appdata%/callisto` folder, create a new file and call it `user.toml`. Put the following text in it, replacing `"C:/Users/User/Documents/clean_rom.smc"` with a path to a clean Super Mario World ROM on your PC that you expect to stay at that path indefinitely:

```toml
[settings]
clean_rom = "C:/Users/User/Documents/clean_rom.smc"
```

And that's all the necessary setup. As previously stated, you only have to do this `clean_rom` part once as long as the ROM doesn't move from the path you specified. Any time from now on that you use Callisto for any project, it will already know where to find the ROM.

Now, go ahead and press `R` in Callisto's menu, which will build the ROM you will be working on. A script will ensure that all tools needed are downloaded automatically. This script might screw up the console font, but this should only happen on the initial downloads, if it's bothersome you can just restart Callisto.

If the build succeeded, great! You can keep reading below.

Otherwise, if you ran into issues, feel free to reach out in the [Discord server](https://discord.gg/SbRM8mUjdE).

## Git after First Build

(If you're not using git, you can skip this part.)

After the first build, a lot of new files will have been added to your project. You can now commit them with
```
git add .
git commit -m "Initialize project"
```
or, if you want to get rid of the first commit that contains the 
state of the repository before all the tools have been downloaded, you can do
```
git checkout --orphan temp main
git add .
git commit -m "Initial commit"
git branch -M temp main
git push -f
```

## Using Callisto

Callisto is the main tool you will be interfacing with when using this template. It is responsible for building and packaging your hack.

If you want the output ROM's and BPS patch's names to be something other than `my_hack`, just change the `project_name` setting in `callisto/variables.toml`.

If you want to insert a patch, just add it to the `resources/patches` folder and add it to the list in `callisto/patches.toml`, like so:

```toml
[resources]
patches = [
    "resources/patches/your_patch_here.asm",
    "resources/patches/another_patch_here.asm"
]
```

Adding sprites, blocks, music, etc. all work like normal, except instead of running the tool that would usually insert the sprite, block, music, etc. Callisto will do this for you! Just press `R` in Callisto's menu and it will build the ROM from scratch, applying all tools to it freshly. Alternatively, you can also use `U` to "update" the ROM, which will only apply the tools that have actually had any files changed since the last time you built. `Update` is usually much faster than `Rebuild`, but can sometimes be less accurate. I would thus recommend usually using `Update` and only using `Rebuild` when something is wrong or when you want to make sure that your hack can still be built from scratch without issues.

To edit your hack in Lunar Magic, use `Edit` in Callisto's menu. This will launch your ROM in Lunar Magic or bring an existing Lunar Magic window to the foreground if there already is one. If you launch your ROM this way, Callisto will automatically export resources from it in the background whenever you save a level, map16 or the overworld. In addition, Callisto will also automatically reload the ROM in Lunar Magic for you when a `Rebuild` or `Update` finishes successfully. Note that this *only* works if you launch Lunar Magic through `Edit`, not if you launch Lunar Magic yourself!

Once you're ready to release your hack, package it with `Package`! This will just create a BPS patch from your current built ROM, that's all it does.

## Removing the only Conflict

Callisto has a conflict detection feature which can detect when multiple steps of the build write to the same location in the ROM. With the configuration that is in use for this template, there should be only one conflict in total which you can see at the end of your `Rebuild`. This conflict is between PIXI and UberASMTool and is easily resolved, if you want to.

Just go to `tools/uberasm_tool/asm/base/main.asm`, locate the following lines:

```
ORG $05D8B7
    BRA +
    NOP #3        ;the levelnum patch goes here in many ROMs, just skip over it
+
    REP #$30
```

and change the `NOP #3` to a `skip 3`, like so:

```
ORG $05D8B7
    BRA +
    skip 3        ;the levelnum patch goes here in many ROMs, just skip over it
+
    REP #$30
```

That's all you have to do! There is nothing problematic about this conflict, it's just a small change you can make if you want to make sure you don't have any conflicts when starting out, which will also help make it more apparent when more conflicts come up as you add more patches and resources.


## A Note on asar 1.9

This template uses asar 1.81 by default, but customized versions of both 32-Bit and 64-Bit asar 1.9 DLLs are included at `callisto/asar` for your convenience. To use asar 1.9 instead of asar 1.81, just replace any `asar.dll` you want with the corresponding one from the `callisto/asar/v1.9` folder (make sure you use the correct one, it could be 32-Bit or 64-Bit depending on the tool). Note that while Callisto should work fine with asar 1.9, other tools may or may not.


## More Callisto Information

Callisto has many more features, including:

- Launching emulators
- Detection of conflicts between patches and tools
- Modules, which are a mechanism for globally shareable code and data between all tools/resources
- Profiles, which let you quickly switch between different ways of building your project
- Command-line usage
- Customizable color scheme

which you can read more about [here](https://github.com/Underrout/callisto/wiki) if you're interested!

I hope you will enjoy working with this template, happy hacking!
