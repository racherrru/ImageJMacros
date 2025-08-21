path = getDirectory("Choose a Directory "); 
outputFolder = getDirectory("Choose_a_Directory "); 
filelist = getFileList(path); 
 for (i=0; i< filelist.length; i++) {
     // process png files only 
     if (endsWith(filelist[i], ".png")) {
     	open(path + filelist[i]);
		run("8-bit");
		
		selectImage(filelist[i]);
	    run("Duplicate...", "title=epidermis"); 
		selectImage("epidermis");
		run("Auto Threshold", "method=Mean white");
		//run("Threshold...");
		setAutoThreshold("Default dark no-reset");
		setAutoThreshold("Default no-reset");
		run("Analyze Particles...", "size=50000-Infinity show=Overlay display clear include summarize overlay add");
				roiManager("Select", 0);
		roiManager("Save", outputFolder + filelist[i]+ "roi_selection_epidermis"+".roi"); // saves the roi of the epidermis traced

		selectImage(filelist[i]);
		roiManager("Select", 0);
		setAutoThreshold("Default no-reset");
		roiManager("Deselect");
		run("Analyze Particles...", "  show=Overlay display clear include summarize overlay add");
		roiManager("Measure");
		roiManager("Save", outputFolder + filelist[i]+ "roi_selection_WS"+".zip");
		roiManager("Reset")

		close("*");
		    
     }
 }
Table.save(path + "Summary.csv", "Summary");
		close("Results");   
