#!/bin/bash 


INITDEV=""
CMD=""
ALS=""


#on se deplace dans le home de l'utilisateur
cd /home/"$USER"/ 


#On test si le répertoire .initdev existe deja
if [ -e ".initdev" ] ;then 
         echo "the reperetory already existes"
         exit 1
fi 


#création du répertoire .initdev
mkdir ".initdev"



#copier les fichiers gitignores,sources,licenses,makefiles,bin dans .initdev

echo "copiying the files gitgnores,sources,licenses,Makefiles in .initdev"
cp "~/Téléchargements/Initdev_L3Kahina-master/gitignores"   "~/.initdev/gitignores"
cp "~/Téléchargements/Initdev_L3Kahina-master/bin"          "~/.initdev/bin"
cp "~/Téléchargements/Initdev_L3Kahina-master/sources"      "~/.initdev/Sources" 
cp "~/Téléchargements/Initdev_L3Kahina-master/licenses"     "~/.initdev/Licences"
cp "~/Téléchargements/Initdev_L3Kahina-master/makefiles"    "~/.initdev/Makefiles"


#On utilise cette variable pour garder le chemin qu'on va utiliser dans main.sh      
 INITDEV="$PATH:/home/"$USER"/.initdev"
 export INITDEV

#sauvegarder la modification de la variable PATH dans le fichier .bashrc si l'utilisateur utilise bash 
                 
if [ -e .bashrc ]; then

                 PATH="$PATH:/home/"$USER"/.initdev"
                 export PATH
                 CMD=`which initdev`  

          #vérification si l'alias initdev de l'app existe déja sinon le repmlacer par initdev2
          if [ CMD=""]; then

                     alias initdev= 'bash /home/"$USER"/.initdev/main.sh' >> ~/.bashrc
                     source ~/.bashrc
                     ALS="initdev"
         else 
                    alias initdev2= 'bash /home/"$USER"/.initdev/main.sh' >> ~/.bashrc
                    source ~/.bashrc
                    ALS="initdev2"
          fi

                 INITDEV="$PATH:/home/"$USER"/.initdev"
                 export INITDEV
fi

#sauvegarder la modification de la variable PATH dans le fichier .bashrc si l'utilisateur utilise zsh

if [ -e .zsh ]; t
                 PATH="$PATH:/home/"$USER"/.initdev"hen

                 export PATH
                 CMD=`which initdev`

           #vérification si l'alias initdev de l'app existe déja sinon le repmlacer par initdev2
           if [ CMD=""]; then

                     alias initdev='bash /home/"$USER"/.initdev/main.sh' >> ~/zshrc
                     source ~/.zshrc
                     ALS="initdev"
         else 
                    alias initdev2='bash /home/"$USER"/.initdev/main.sh' >> ~/.zshrc
                    source ~/.zshrc
                    ALS="initdev2"
          fi
               

                 
fi
echo " initdev installed successfully use the commande $ALS to execute the application"

exit 0
