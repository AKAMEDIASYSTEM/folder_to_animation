/*
Created by AKA by combining the Processing DirectoryList example online with a MovieMaker class demo
 */

import processing.video.*;
MovieMaker mm;
PImage currentFrame;
String filenames;
String sketchPath = selectFolder("Show me the img folder");  // Opens file chooser
String[] images;
String timecode[] = new String[7];
String fullTime;

// we'll have a look in the data folder
java.io.File folder = new java.io.File(dataPath(sketchPath));
 
// let's set a filter (which returns true if file's extension is .jpg)
java.io.FilenameFilter jpgFilter = new java.io.FilenameFilter() {
  boolean accept(File dir, String name) {
    return name.toLowerCase().endsWith(".jpg");
  }
};











void setup() {
size(720,640);

  //set up date and time string
  timecode[0] = String.valueOf(year());
  timecode[1] = String.valueOf(month());
  timecode[2] = String.valueOf(day());
  timecode[3] = String.valueOf(hour());
  timecode[4] = String.valueOf(minute());
  timecode[5] = String.valueOf(second());
  timecode[6] = "pc.mov";
  fullTime = join(timecode, "_");


  println("Listing all filenames in a directory: ");
  //String[] filenames = listFileNames(sketchPath);
  //println(filenames);
  images = listFileNames(sketchPath, jpgFilter);

  /*
  println("\nListing info about all files in a directory: ");
   File[] files = listFiles(sketchPath);
   for (int i = 0; i < files.length; i++) {
   File f = files[i];    
   println("Name: " + f.getName());
   println("Is directory: " + f.isDirectory());
   println("Size: " + f.length());
   String lastModified = new Date(f.lastModified()).toString();
   println("Last Modified: " + lastModified);
   println("-----------------------");
   }
   */
  /*
  println("\nListing info about all files in a directory and all subdirectories: ");
   ArrayList allFiles = listFilesRecursive(path);
   
   for (int i = 0; i < allFiles.size(); i++) {
   File f = (File) allFiles.get(i);    
   println("Name: " + f.getName());
   println("Full path: " + f.getAbsolutePath());
   println("Is directory: " + f.isDirectory());
   println("Size: " + f.length());
   String lastModified = new Date(f.lastModified()).toString();
   println("Last Modified: " + lastModified);
   println("-----------------------");
   }
   */

  //make sure the directory only has images in it
  //  String[] images = filterByExtension(filenames, "jpg");

  //  //get number of image files in directory
  //  //get array of all image file names
  //  //cycle through array names (in date order?)
  //  for(int i=0; i < images.length; i++){
  //    PImage currentFrame = loadImage(images[i]);
  //    mm.addFrame(currentFrame);
  //  }
  //  
  //  mm.finish();
  //  //for each array entry, add a frame to the movie



  noLoop();
}

// Nothing is drawn in this program and the draw() doesn't loop because
// of the noLoop() in setup()
void draw() {


  println(fullTime);
  // Save uncompressed, at 15 frames per second
  //mm = new MovieMaker(this, width, height, "drawing.mov");
  // Or, set specific compression and frame rate options
  mm = new MovieMaker(this, width, height, fullTime, 30, 
  MovieMaker.ANIMATION, MovieMaker.LOSSLESS);
  //get number of image files in directory
  //get array of all image file names
  //cycle through array names (in date order?)
  for(int i=0; i < images.length; i++) {
    PImage currentFrame;
   currentFrame = loadImage(sketchPath+"/"+images[i]); 
    image(currentFrame,0,0);
    mm.addFrame();
  }
println("done");
  mm.finish();
}


// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list ofall files in a directory and all subdirectories
ArrayList listFilesRecursive(String dir) {
  ArrayList fileList = new ArrayList(); 
  recurseDir(fileList,dir);
  return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a,subfiles[i].getAbsolutePath());
    }
  } 
  else {
    a.add(file);
  }
}


/*
String[] filterByExtension(String[] folderNames, String extension) {
  String[] returnThis = null;
  String[] tempStr = null;
  for(int j=0; j<folderNames.length;j++) {
    String[] ext = split(folderNames[j],".");  // split the string into substrings separated by periods
    String currentExt = ext[ext.length-1];   // pick the last string in the array to get the extension
    if(currentExt.equals(extension)) {          // if the filename's extension matches our type, add it to the returned array
      returnThis = append(returnThis, folderNames[j]);
    }
  }
  return returnThis;
}
*/

// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir, java.io.FilenameFilter extension) {
  println("dir is "+dir);
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list(extension);
    return names;
  } else {
    // If it's not a directory
    println("it's not a tumor");
    return null;
  }
}

