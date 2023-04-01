# Automated Super Mario World Project Template

This repository is a template or "baserom" for Super Mario World hacking projects focused on automation and git compatibility, 
though it can also be used just fine without git.

The template is completely style-agnostic, as it includes no resources, but only tools. The point is to provide a 
convenient template that can be used for *any* hack.

It contains all tools commonly used in hacking projects, alongside some that enable a more automated workflow, namely:

- Lunar Magic 3.33
- AddmusicK 1.0.8
- Asar 1.81
- FLIPS
- GPS 1.4.3
- PIXI 1.32
- UberASMTool 1.5
- Lunar Helper 4.0.5
- Human Readable Map16 0.2.0

In addition, it comes pre-patched with SA-1 Pack v1.40 and includes a handy `.gitignore` file that 
contains ignore rules for common build artifacts.

If you have any suggestions or run into bugs with this template, please feel free to open an issue and I will do 
my best to assist, as long as the problem is directly related to this template project specifically and not one 
of the included tools or how to use them.

If you find a problem with one of the included tools, please let the respective maintainers know and feel free to 
let me know when a newer version fixing the problem becomes available so that I can include it here.

If you are unsure on how to use an included tool, have a look through the included readme in the tool's directory
or see if there is a tutorial available elsewhere.

# Setup 

## From ZIP file

I would recommend using this template with GitHub (or a different repository host) and git, but 
if you want you can also download the template as a ZIP file by clicking on `Code` and choosing 
`Download ZIP` from the dropdown menu and use it as-is.

![](https://i.imgur.com/s8nX30l.png)

Once you have downloaded it, you can simply unpack the ZIP archive wherever you would like to set up your 
project. Make sure to run the `init.bat` script after you've extracted the archive, this file  
will download all the tools and extract them to their respective directories, afterwards it will delete itself.

The only thing left to do at this point is to delete the `REPLACE WITH 'clean.smc'` file in the root of 
the project directory and to replace it with a **clean** Super Mario World ROM named `clean.smc`.

This should be sufficient to get you going, but you can configure a few more things if you want to in 
`Tools/LunarHelper/config_user.txt`, such as the output ROM's/patch's name, emulator paths and 
your title screen movement save state if you're using one.

There are also `_gitkeep` files in a few directories that you can safely remove, 
though they should not cause any trouble if they're kept in place. 

If you want to get rid of the warnings about arbitrary dependencies when using Quick Build, 
go into `Tools/UberASMTool/other/macro_library.asm` and remove the `prot_file` and `prot_source` macros
(or comment them out).

## With GitHub and git

To create a new repository from this template using GitHub and git, first click the `Use this template`
button at the top of this repository's GitHub page. 

![](https://i.imgur.com/szo4eUX.png)

Afterwards, simply give your repository a name and, optionally, a description. You can choose to make 
the repository public for everyone to see or keep it private so only you can see it. I would recommend 
keeping it private since re-distributing essentially any hacking resource (sprites, patches, blocks, etc.) 
without a license is technically illegal. There is nothing technically preventing you from hosting a public 
repository, but you would be doing so at your own risk.

Now you can simply clone the repository to your local machine using `git clone` like you would 
with any other repository!

Once you've cloned the project, make sure to run the `init.bat` script in the root directory. The script 
will download all the aforementioned tools and delete itself afterwards. 

After the script has completed, delete the `REPLACE WITH 'clean.smc'` file in the root of the project 
directory and replace it with a **clean** Super Mario World ROM named `clean.smc`.

You can now commit these changes with
```
git add .
git commit -m "Initialize project"
```
or, if you want to get rid of the first commit that contains the 
state of the repository before the initialization script has been run, you can do
```
git checkout --orphan temp main
git add .
git commit -m "Initial commit"
git branch -M temp main
git push -f
```

This should be sufficient to get you going, but you can configure a few more things if you want to in 
`Tools/LunarHelper/config_user.txt`, such as the output ROM's/patch's name and 
your title screen movement save state if you're using one. Furthermore, you can configure different 
emulators for your `Debug` and `Release` profiles in `Tools/LunarHelper/default_profile_Release/config_emulator.txt`
and `Tools/LunarHelper/profile_Debug/config_debugger.txt` respectively, as well as insert additional 
patches when you're in the `Debug` profile in `Tools/LunarHelper/profile_Debug/config_debug_patches.txt`, but 
this is entirely optional.

There are also `_gitkeep` files in a few directories. These are there 
so that git tracks the directory they are contained in, since git will not track directories unless they 
contain at least one file. If you want to, you can safely remove these files once doing so won't lead to 
the containing directories being empty and thus no longer being tracked by git, though they shouldn't 
cause any trouble if you leave them in place.

If you want to get rid of the warnings about arbitrary dependencies when using Quick Build, 
go into `Tools/UberASMTool/other/macro_library.asm` and remove the `prot_file` and `prot_source` macros
(or comment them out).

# Usage

## Building & Packaging

`Lunar Helper` can be used to build and package your project. To build, open 
`Tools/LunarHelper/LunarHelper.exe` either by double-clicking on the file or starting it via the 
command line.

![](https://i.imgur.com/hjU2A62.png)

You will be greeted by a minimal user interface. Here, you can press `B` on your keyboard to build your 
hack. Lunar Helper will then apply all tools, insert graphics, levels, the overworld, etc. starting from 
a clean ROM (the `clean.smc` you provided during the setup step). Lunar Helper will report any errors 
encountered during the process, if there were none, it will output the resulting ROM, named `hack.smc`
by default in the project's root directory.

This is highly useful because you always have a guarantee that your project can be ported to a fresh ROM 
if needed, as well as ensuring that your ROM is built exactly the same way every single time, making 
your work fully reproducible.

`Q` aka Quick Build on the other hand will also build your ROM, but it will attempt to use a previously 
built ROM for the build, if one is available. This can save a lot of time in the long run, because 
instead of applying all tools and inserting all resources from scratch, Lunar Helper will calculate 
which tools and/or resources will have to be reapplied in order to update the ROM. You should normally
get functionally the same output ROM as if you had done a full rebuild from a clean ROM, but if it seems
like something in your hack isn't working right after doing a Quick Build, I would recommend doing a full
rebuild using the `B` option, as it's not completely impossible that the problem could be caused by Quick Build.

In the same menu, you can also press `P` to "package" your hack. This will first build your hack from scratch 
as described above and then create a BPS patch from the output ROM, which you can then share with people or 
submit to sites hosting ROM hacks.

`E` will open your ROM in the included Lunar Magic executable and can be a handy alternative to opening the 
ROM in Lunar Magic manually. It also ensures you actually use the correct Lunar Magic version that is injected
with Lunar Monitor, which is somewhat important.

There is also an `H` option which shows a short explanation for each of the menu options. Options `R` and 
`T` will not work right off the bat and require a little further configuration on your part. If you want 
to use these two options, have a look at the bottom of `Tools/LunarHelper/default_profile_Release/config_emulator.txt`
and `Tools/LunarHelper/profile_Debug/config_debugger.txt` to configure emulator paths.

The `S` option lets you switch between different profiles. Right now, you just have a `Debug` and `Release`
profile, you can see your current profile in Lunar Helper's menu. The only difference between them at the 
moment is that you can configure each of them to launch a different emulator as well as insert additional 
patches when building with the `Debug` profile (i.e. to insert debug cheats). You can edit, add or remove as well
as rename profiles.

For details on anything related to Lunar Helper and Lunar Monitor, feel free to checkout the [extensive wiki](https://github.com/Underrout/LunarHelper/wiki).

## Editing levels, overworld, etc.

To edit your ROM's contents (levels, overworld, etc.) use the Lunar Magic executable included at 
`Tools/LunarMagic/Lunar Magic.exe`. 

Lunar Monitor is included in the same directory and ensures that anything you edit is exported as 
soon as you save it, so that any changes you make will be used by Lunar Helper when you build the 
ROM in the future. You don't have to do anything special for this to happen, Lunar Monitor is 
automatically started as soon as you open a ROM using this Lunar Magic executable.

Namely, Lunar Monitor will automatically export the following resources as soon as you save them:

- levels (exported to the `Levels` directory)
- map16 (exported as the `Other/all_map16` directory)
- shared palettes (exported as `Other/shared.pal`)
- global data, overworld and title screen (exported as `Other/global_data.bps`)

Note that if you're using Global ExAnimation you will have to save the overworld or title screen 
after editing Global ExAnimation in order to make Lunar Monitor export the updated Global ExAnimation frames. 

You can tell whether Lunar Monitor is running by the presence of an extra "Export All" button in Lunar Magic's toolbar, 
there will also be an extra message pane at the bottom right corner of the editor letting you know what actions 
Lunar Monitor is performing:

![](https://i.imgur.com/FKkW0rP.png)

Note that for a new project you shouldn't ever have to use the "Export All" button, but it can be useful for porting 
existing projects to a system like this.

## Adding patches

There is already a `Patches` directory set up for your convenience. Once you have added your patch to this 
directory, note that you will have to add it to a list that can be found in `Tools/LunarHelper/config_patches.txt`
for it to actually be applied by Lunar Helper.

As explained in the file, if you were to add a `retry.asm` patch to your `Patches` directory and you wanted 
Lunar Helper to patch it to your ROM during the build process, you would add it to the list in the 
`config_patches.txt` file like this:

```
patches [
    Patches/retry.asm
]
```

for any further patches, just add them on a newline:

```
patches [
    Patches/retry.asm
    Patches/remove_statusbar.asm
]
```

and so on.

## Inserting music, sprites, blocks and UberASM code

Inserting music, sprites blocks and UberASM code is straightforward and no different from any regular 
hacking project. Just navigate to the respective folder in the `Tools` directory and you will find 
a regular setup for each respective tool that you can use like normal. 

The relevant folders for music, sprites, blocks and UberASM respectively are:

- `Tools/AddmusicK`
- `Tools/PIXI`
- `Tools/GPS`
- `Tools/UberASMTool`

You can use any of these tools on your built ROM directly if you really want to, though it is not recommended, 
since this will cause Lunar Helper's Quick Build function to not work reliably.

For example, to insert a sprite, I would add it to the `Tools/PIXI/sprites` folder, write an entry for 
it in `Tools/PIXI/list.txt` and then build my ROM by running `Tools/LunarHelper/LunarHelper.exe` and 
using the `Quick Build` or `Build` option.

Note that you can keep Lunar Helper open while you're working on stuff so you don't 
have to reopen it whenever you want to build your ROM.

## Advanced Lunar Helper features

For advanced Lunar Helper features, feel free to consult `Tools/LunarHelper/README.md`.

## Using git (optional)

As mentioned previously, you do not have to use this template with git if you don't want to. 
However, I would strongly recommend doing so if you are already familiar with git or are willing to 
learn how to use it, because it brings lots of advantages over relying on Lunar Magic's own internal 
recovery system:

- git can restore the state of *your entire project*, including sprites, patches, blocks, directory 
structure, etc. instead of just your ROM
- git repositories are generally much smaller in size than Lunar Magic's notoriously large LRP files
- git repositories can be pushed to repository hosts and thus easily be *remotely*
backed up, so even if your local copy were to become inaccessible or destroyed, you 
could restore your project including all its "backups" from the remote copy easily
- with git, you decide when to create a "restore point" and what message to include alongside the 
restore point, this means it is much easier to find a specific state to restore your project to
since you have less clutter and more information
- git allows you (and potential collaborators) to work on different aspects of your hack in isolation 
using "branches"
- `git bisect` can help you find the specific changes that introduced a bug in your project

There are many great tutorials on git already out there so I will only briefly talk about some specifics 
in regards to using git with this template repository. 

With that said, if you are looking to learn git [here](http://rogerdudler.github.io/git-guide/) is a very brief 
introduction you can read in just a few minutes and [here](https://git-scm.com/book/en/v2) is a *very* 
comprehensive book covering just about anything git related. Personally, I would recommend reading the short 
introduction and then looking stuff up as needed when you run into issues, either via a search engine or, if 
you want to, in the book mentioned above.

If using bare git via the command line sounds intimidating, I can also recommend 
[GitKraken](https://www.gitkraken.com/) which offers a pretty nice visual alternative with its own set of 
[tutorial videos](https://www.gitkraken.com/learn/git/tutorials), though note that the free version is only 
usable for public repositories unless you're a student in which case you can use it for private ones as well.

### What to commit

Generally, I would recommend only committing files that are actually used during Lunar Helper's Build process
using git. This is why there are various paths listed in the included `.gitignore` file that git will not 
track, these files are either not useful for building or are a direct result of the build process itself and 
thus don't carry any important information.

If you're using any different/additional tools, I would recommend likewise adding any files that these tools 
generate during their insertion process to the `.gitignore` file. 

### How to restore the project

After you check out a specific commit/branch, just run Lunar Helper's Build option to build a ROM from the 
currently checked out project state.

### Quick Build or Build?

I would generally recommend using Quick Build when you're working on a commit and doing a clean Build from scratch 
right before you're ready to commit your changes. This way you get the benefits of quicker build times while you're 
working on things but also can be sure that what you've worked on can be reproduced exactly as it was using the 
Build option later if you ever have to return to this exact commit. 

### Avoiding merge conflicts

Merge conflicts should only really be a concern if you're collaborating with other people and/or using branches or forks.

In general, to avoid conflicts, I would recommend not editing:

- the same level(s)
- the overworld, title screen and global data
- shared palettes

in more than one branch. 

The files resulting from changes to these resources, MWL files, BPS files and PAL files respectively, are binary 
files and thus any merge conflicts between them require arduous merging by hand, which is not an enjoyable experience, 
though it can still be accomplished by building a ROM for each conflicting version and manually merging them in Lunar Magic.

For map16, ideally you should not edit the same tile number(s) in multiple branches. As long as you don't do that, 
any map16 file merges between branches should be resolved automatically due to the text-based map16 format this template 
project uses.

If you do accidentally end up editing the same tile number(s) in multiple branches, please consult the readme file 
at `Tools/HumanReadableMap16/README.md` for information on the human readable map16 format and resolve the merge either 
through those text files or by the aforementioned process for merging binary files in Lunar Magic.
