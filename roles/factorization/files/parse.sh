#! /bin/bash

echo "[packages]"

    CONTADOR=0
    LINEA=""

    for LINEA in `rpm -qa` #LINEA guarda el resultado del rpm -qa
    do


          NOMBRE=`echo $LINEA | cut -f1` #Extrae linea

        if [ $CONTADOR -lt 10 ]
        then

        echo package00$CONTADOR=$NOMBRE

        fi

        if [ $CONTADOR -ge 10 ];
         then
                if [ $CONTADOR -lt 100 ];
                 then

                  echo package0$CONTADOR=$NOMBRE

        fi
        fi
         if [ $CONTADOR -ge 100 ]
        then

        echo package$CONTADOR=$NOMBRE

        fi


        let CONTADOR=CONTADOR+1

    done

  echo "[number of packages]"

  echo "number=$CONTADOR"
