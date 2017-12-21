How to Run the API:	
	Open the GradPlanSSU folder on blue. On the command line run
	
		./GradPlanApiInstaller.sh

	This will install all necessary dependencies. Next change to
	GradPlanSSUAPI directory. At the command prompt run ./GradPlanApi.sh
	This will run the API on port 8000 on blue.

How to Run Application:

	Open the AppCode Folder

	This app is optimized to run on the iPhone 8 PLUS emulator. Please
	do so for best results.

	Find the SSUSchedulePlanner.xcworkspace file and open it. 
	There is an SSUSchedulePlanner.xcodeproj file. This file 
	will not work because it does not include all the dependencies 
	necessary for building the project.

	Open the workspace file and press play.

	Note: There have been instances in the past where the app 
	will crash upon first loading or not compiling at all. We have
	fixed this by deleting the Derived Data folder and/or deleting
	the app from the phone before running the emulator again to clear
	the cache. However, this should not happen when you run the app.


