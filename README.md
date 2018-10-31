# densitystudy
encounter-traffic

Code for "Learning the Relation Between Mobile Encounters and Web Traffic Patterns: A Data-driven Study" MSWiM 2018 (Tech Report: https://arxiv.org/abs/1808.03842)

Please feel free to contact the authors:
Mimonah Alqathrady mimonahalqathrady@gmail.com
Ahmed Helmy helmy@ufl.edu

Note: If you use any of these tools, code or data, please make sure to cite our correspnding paper(s).

Pre-built Docker image

Link:https://hub.docker.com/r/nomadsgroupm/densitystudy/

To run the image:

To run the docker image, run the following command line instruction:
docker run -e PASSWORD=NOMAD -p 8787:8787 nomadsgroupm/densitystudy:demo

Then leave the terminal running.

open browser, write in the address bar:
localhost:8787
The rstudio page will open, and asks for username and password.
username: rstudio
password: NOMAD
The rstudio now is running and all files (codes, data, and packages) are there,

Rstudio:
Just use the console on the left, write the following command:

setwd("~/densityCodes")

source("densityPred.R")

HourlyPrediction.1.5()# To run the code that uses one week to predict five weeks, it will output the error of each method for each building, and plot the figure on the right.

HourlyPrediction.5.1() #This uses five weeks to predict one week.

Please note that the Docker image includes the code, and a sample of data.

Code License

Apache License 2.0

Data License

By accessing the Docker image or any of the data files associated with this project, you (the "Researcher") agree to the following terms and conditions:

Researcher shall use the data only for non-commercial research and educational purposes.
University of Florida makes no representations or warranties regarding the data, including but not limited to warranties of non-infringement or fitness for a particular purpose.
Researcher accepts full responsibility for his or her use of the data and shall defend and indemnify the Mobile Networking Laboratory team, and University of Florida, including their employees, Trustees, officers and agents, against any and all claims arising from Researcher's use of the data, including but not limited to Researcher's use of any copies of copyrighted images that he or she may create from the data.
Researcher may provide research associates and colleagues with access to the data provided that they first agree to be bound by these terms and conditions.
University of Florida reserves the right to terminate Researcher's access to the data at any time.
If Researcher is employed by a for-profit, commercial entity, Researcher's employer shall also be bound by these terms and conditions, and Researcher hereby represents that he or she is fully authorized to enter into this agreement on behalf of such employer.
The law of the State of Florida shall apply to all disputes under this agreement.
(Data license adapted from ImageNet)
