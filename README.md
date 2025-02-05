# Datoma's CLI-based tool template
This document will guide you to migrate your CLI tool to Datoma.

If forking this template, feel free to change your new repository's name to match your project's name.

## What can you find on this repository?
[**.gitignore**](/.gitignore): No need to modify this file, it will keep the project clean of unnecessary files.

[**datomaconfig.yml**](/datomaconfig.yml): You only need to modify the [`taskname`](/datomaconfig.yml#L16) parameter to suit your project. 
- Choose one of the possible architectures, depending on your project needs ([keep only x86 or arm64](/datomaconfig.yml#L3C3-L12C14), if unsure, keep x86) and delete the other.
- You must execute your tool's CLI comand from within a python script. If your main python script has a name different than **"script.py"**, change [line **19**](/datomaconfig.yml#L19) accordingly.
- If the folder where your code outputs the results file is not named "**results**", change [line **20**](/datomaconfig.yml#L20) accordingly.
- Keep in mind that the [in_file](/datomaconfig.yml#L25) parameter will be used later.

[**description.taskname.md**](/description.taskname.md): You need to modify this file's name and change "taskname" for the name you defined on the previous file ([line **16**](/datomaconfig.yml#L16)).
- Then, add a description and citation.

[**Dockerfile**](/Dockerfile): This file should be modified according to the needs of your tool. You can modify the base image and the dependencies installed. Also, the name of your main python script can be modified if you wish. If your project requires additional files, please copy them to the **/app/** directory as you can see on [line **19**](/Dockerfile#L19).
- To test that the project works, we recommend that you also copy an input file to the **/app/** directory.

[**install_jobrunner_and_run.sh**](/install_jobrunner_and_run.sh): This file should only be modified if you have to set some environment variables (as shown on the [line **7** example](/install_jobrunner_and_run.sh#L7)).
- While testing, you will need to comment [line 4](/install_jobrunner_and_run.sh#L4) and also change [line **9**](/install_jobrunner_and_run.sh#L9) for **python script.py** or similar. This is because it won't work outside the Datoma infrastructure.

[**install_jobrunner.py**](/install_jobrunner.py): This file doesn't have to be modified.

[**layout.taskname.json**](/layout.taskname.json): This is the file used on Datoma's web to specify the parameters and attach the input files. Modify according to your project's needs.
- Please, modify the **filename**, replacing `taskname` for the same name you have already defined on [**datomaconfig.yml**](/datomaconfig.yml#L16).
- The [`key`](/layout.taskname.json#L24) parameter must be the same as the one on [**datomaconfig.yml**](/datomaconfig.yml#L25). 

[**script.py**](/script.py): This is a mere example. The part you need to keep is the [`datoma_entrypoint()`](/script.py#L3) function declaration.
- [Line **5**](/script.py#L5) shows how to get the filename of the input file.
- [Line **6**](/script.py#L6) shows how to get the value of a parameter.
- [Line **7**](/script.py#L7) exemplifies how to get the number of cores that are available for this experiment.
- [Line **10**](/script.py#L10) is an example on how to set the bash command to execute your CLI tool.
- When testing, we recommend to set up a [main](/script.py#L30-L31) on the file that calls for the `datoma_entrypoint()` function.
- While testing, we also recommend to modify proprietary functions such as [`get_vcpu()`](/script.py#L7), since they only work on Datoma's infrastructure.

## How to test?
1. Inside this template's folder, execute the command `docker build -t toolname`
2. Then, run `docker run --rm toolname`
    - Alternatively, you can run `docker run --rm -it --entrypoint="bash" toolname` to run the container interactively.
3. If you have any issue while in this process, you can contact us: `contact` at `datoma.cloud`
4. When your project is working, please undo all modifications made for testing purposes and forward the whole project to the Datoma team: `releases` at `datoma.cloud`
