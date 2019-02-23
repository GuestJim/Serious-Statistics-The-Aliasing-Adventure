import sys,os

droppedPath = sys.argv[1].rsplit("\\",1)[0] + "\\"

#droppedFiles = sys.argv[1:]
#	works for dropping all relevant files onto it, but below is better
droppedFiles = os.listdir(droppedPath)
#	with this one file dropped from the folder is enough
os.chdir(droppedPath)
#	this is necessary for the resulting file names to be correct

if not os.path.exists(droppedPath + "Difference"):
	os.mkdir(droppedPath + "Difference")

for file in droppedFiles:
	if "None" in file and "MLAA" not in file:
		droppedNone00 = file
		
droppedFiles.remove(droppedNone00)

for drop in droppedFiles:
	if ".png" in drop and "MLAA" not in drop:
		os.system("convert \"" + droppedNone00 + "\" \"" + drop + "\" -compose difference -composite \"" + droppedPath + "Difference\\Difference " + drop + "\"")
	
#os.system("pause")