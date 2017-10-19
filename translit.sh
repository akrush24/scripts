#!/bin/bash
NAME=$1
# sed-ом заменяем символы кирилицы на символы латиницы
 TRS=`echo $NAME | sed "y/абвгдезийклмнопрстуфхцы/abvgdezijklmnoprstufxcy/"`
 TRS=`echo $TRS | sed "y/АБВГДЕЗИЙКЛМНОПРСТУФХЦЫ/ABVGDEZIJKLMNOPRSTUFXCY/"`
 TRS=${TRS//ч/ch};
 TRS=${TRS//Ч/CH} TRS=${TRS//ш/sh};
 TRS=${TRS//Ш/SH} TRS=${TRS//ё/jo};
 TRS=${TRS//Ё/JO} TRS=${TRS//ж/zh};
 TRS=${TRS//Ж/ZH} TRS=${TRS//щ/sh\'};
 TRS=${TRS///SH\'} TRS=${TRS//э/je};
 TRS=${TRS//Э/JE} TRS=${TRS//ю/ju};
 TRS=${TRS//Ю/JU} TRS=${TRS//я/ja};
 TRS=${TRS//Я/JA} TRS=${TRS//ъ/\`};
 TRS=${TRS//ъ\`} TRS=${TRS//ь/\'};
 TRS=${TRS//Ь/\'}
 TRS=${TRS// /_}
 # переименовываем
 echo $TRS
