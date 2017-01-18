ColEdit colormap editor toolbox
Version 1.1  13-Mar-2000

ABSTRACT:
Ever wanted to create your own colormap without explicitly handling
arrays of RGB-values ?  
ColEdit is an easy to use graphical user interface to create your
own colormaps. Colormaps can be saved to m-files and be reloaded
when written with ColEdit. Import of plain ASCII arrays of rgb-values
is also possible.


INSTALLATION:
To make full use of ColEdit create a directory 'colmaps' in your
personal Matlab directory and place the toolbox into it.
ColEdit will search this directory for existing colormaps and will
write new ones into it.
If you do not want the beautiful title page, simply rename or delete
coledit.pcx and coledit.bmp .
This software has been tested with MATLAB 4.2 and MATLAB 5.0/5.1/5.2 on
Linux and Solaris systems. Some routines are using UNIX commands.
Thus there might be problems with other OS. Any help from users of
other OS is highly welcome !


AUTHOR:
G.Krahmann, Paris, Jan 1998
please send any comments, bug-reports or suggestions to
e-mail: krahmann@ldeo.columbia.edu


FILELIST:
cehsv.m               example conversion of hsv colormap
cejet.m               example conversion of jet colormap
cemartin.m	      example of a new colormap
colcontrols.m         function containing callbacks called by coledit.m
coledit.bmp           title page called by Matlab 4
coledit.m	      main file to call colormap editor
coledit.pcx           title page called by Matlab 5
dummyfile.m           dummy m-file, only to check wether directory exists
readme.txt            this file
and other colormap example files
