#!/bin/bash



# si l'utilisateur ne donne aucun argument le programme return 1
if [ $# -eq 0 ] ; then
	echo "Expected arguments, please check initdev --help"
	exit 1
fi


# l’utilisateur du programme exécute le programme avec initdev --help 

if [ "$1" = "--help" ]; then
        echo "Name :       initdev : automating the preconfigurations of a
                           developement project  (initializing a repository
                           git, adding a '.gitignore' file, naming a license, 
                           creating a first source file in the Project folder 
                           with minimal code depending on the project type 
                           (C, Latex, Python or other), etc)."
	      
        echo "syntax:
                            initdev nomprojet : creation of the project nomprojet
                            initdev nomprojet -arg1 -arg2 -arg3 : creation of the project nomprojet
                            with options arg1,arg2,arg3 (the argument's order is not important)"
        echo "arguments: 
                            nomprojet:the Name of the project
                            arg1,arg2,arg3:
                            programming languages taken into consideration by the application: 
                            -C:'language of the projet in C language'
                            -CPP:'language of the projet in C++ language'
                            -C++:'language of the projet in C++ language'
                            -Py:'language of the projet in Python language' 
                            -Latex:'language of the projet in latex language'
                            -BEAMER:'language of the projet in BEAMER language'

                             licenses taken into consideration by the application:
                            -GPL: 'GENERAL PUBLIC LICENSE'
                            -MIT: 'Licence MIT'

                            -git: 'initialisation of a git repository'"
       echo "author : AKRETCHE Kahina -- akretchekahina@outlook.fr"
	exit 1
fi
 

nomprojet=$1

#test de l'existence du réperatoire $nomprojet

if [ -e "$nomprojet" ]; then
	echo "$nomprojet already existes"
	exit 1
fi

#création du répertoire $nomprojet et les filchiers licence et makefile 

mkdir "$nomprojet"
echo " $nomprojet repertory  created successfully."
touch "$nomprojet/LICENSE"
echo "LICENSE file  created successfully."
touch "$nomprojet/Makefile"
echo "Makefile file  created successfully."


#Ajout des options au projet (type du language de programmation,type de licence,initialisation d'un depot git : en rajoutant le shift l'ordre de ces options données par l'utilisateur n'est pas important)

LIC="n"
PROG="n"   #l'ajout de ces variables est nécessaire pour eviter la réexecution des
           #instructions en cas de répétition des options par l'utilisateur
GIT="n"
LANG=""

while [ "$1" != "" ] ; do
	
 case "$1" in
 -C)
	if [ "$PROG" = "n" ]; then
		cp "$INITDEV/sources/main.c" "$nomprojet"
                echo "file main.c copied successfully"
		PROG="o"                                   
		LANG="c"
                                  
	fi
	;;
 -CPP|-C++)
	if [ "$PROG" = "n" ]; then
		cp "$INITDEV/sources/main.cpp" "$nomprojet"
		echo "file main.cpp copied successfully"
		PROG="o"
		LANG="cpp"
                
	fi
	;;
 -Py)
	if [ "$PROG" = "n" ]; then
		cp "$INITDEV/sources/main.py" "$nomprojet"
                echo "file main.py copied successfully"
		PROG="o"
		LANG="Python"
                
	fi
	;;
 -Latex)
	if [ "$PROG" = "n" ]; then
		cp "$INITDEV/sources/latexMin.tex" "$nomprojet/main.tex"
                echo "file latexMin.tex copied successfully"
		PROG="o"
		LANG="tex"
               
	fi
	;;
 -BEAMER)
	if [ "$PROG" = "n" ]; then
		cp "$INITDEV/sources/beamer.tex" "$nomprojet/main.tex"
                echo "file beamer.tex copied successfully"
		PROG="o"
		LANG="tex"
                
	fi
	;;
 -GPL)
	if [ "$LIC" = "n" ]; then
		cp "$INITDEV/licenses/GPL" "$nomprojet/LICENSE"
                echo " GPL license terms copied successfully"
		LIC="o"
                
	fi
	;;
 -MIT)
	if [ "$LIC" = "n" ]; then
		cp "$INITDEV/licenses/MIT" "$nomprojet/LICENSE"
                echo " MIT license terms copied successfully"
		LIC="o"
               
	fi
	;;
 -git)	
 		GIT="o"
	;;
 *)
	echo "Uknown arguments, please check the help : initdev --help"
	exit 1
	;;

 esac
 
shift
done

#comme l'ordre des options n'est pas important on doit savoir le language choisi par l'utilisateur pour créer le fichier .gitgonres approprié a ce language lors de l'initialisation du depot git

if [ "$GIT" = "o" ]; then
	if [ "$PROG" = "o" ]; then
        cp "$INITDEV/gitignores/$LANG" "$nomprojet/.gitignore"		
	git init 
	fi
fi

exit 0
