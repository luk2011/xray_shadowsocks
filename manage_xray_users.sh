{\rtf1\ansi\ansicpg1251\cocoartf2761
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 .AppleSystemUIFontMonospaced-Regular;}
{\colortbl;\red255\green255\blue255;\red80\green42\blue24;\red0\green0\blue0;\red13\green100\blue1;
\red73\green17\blue135;\red50\green91\blue97;\red181\green0\blue19;\red151\green0\blue126;}
{\*\expandedcolortbl;;\cssrgb\c39216\c21961\c12549;\csgray\c0;\cssrgb\c0\c45490\c0;
\cssrgb\c36078\c14902\c60000;\cssrgb\c24706\c43137\c45490;\cssrgb\c76863\c10196\c8627;\cssrgb\c66667\c5098\c56863;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f0\fs26 \cf2 #!/bin/bash\
\cf3 \
\cf4 # \uc0\u1054 \u1087 \u1088 \u1077 \u1076 \u1077 \u1083 \u1077 \u1085 \u1080 \u1077  \u1076 \u1086 \u1084 \u1072 \u1096 \u1085 \u1077 \u1081  \u1087 \u1072 \u1087 \u1082 \u1080  \u1090 \u1077 \u1082 \u1091 \u1097 \u1077 \u1075 \u1086  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \cf3 \
USER_HOME=$(\cf5 eval\cf3  \cf5 echo\cf3  ~\cf6 $SUDO_USER\cf3 )\
\cf4 # \uc0\u1055 \u1091 \u1090 \u1100  \u1082  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1086 \u1084 \u1091  \u1092 \u1072 \u1081 \u1083 \u1091  Xray\cf3 \
CONFIG_FILE=\cf7 "/usr/local/etc/xray/config.json"\cf3 \
\cf4 # \uc0\u1055 \u1091 \u1090 \u1100  \u1082  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1086 \u1084 \u1091  \u1092 \u1072 \u1081 \u1083 \u1091  Xray \u1074  \u1076 \u1086 \u1084 \u1072 \u1096 \u1085 \u1077 \u1081  \u1087 \u1072 \u1087 \u1082 \u1077  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \cf3 \
USER_CONFIG_FILE=\cf7 "\cf6 $USER_HOME\cf7 /xray_config.json"\cf3 \
\cf4 # \uc0\u1055 \u1091 \u1090 \u1100  \u1076 \u1083 \u1103  \u1089 \u1086 \u1079 \u1076 \u1072 \u1085 \u1080 \u1103  \u1087 \u1072 \u1087 \u1082 \u1080  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081  \u1074  \u1082 \u1086 \u1088 \u1085 \u1077 \u1074 \u1086 \u1081  \u1087 \u1072 \u1087 \u1082 \u1077  \u1090 \u1077 \u1082 \u1091 \u1097 \u1077 \u1075 \u1086  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \cf3 \
USER_DIR=\cf7 "\cf6 $USER_HOME\cf7 /xray_users"\cf3 \
\cf4 # \uc0\u1055 \u1091 \u1090 \u1100  \u1076 \u1083 \u1103  \u1093 \u1088 \u1072 \u1085 \u1077 \u1085 \u1080 \u1103  \u1089 \u1089 \u1099 \u1083 \u1086 \u1082  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 \cf3 \
USER_LINKS_FILE=\cf7 "\cf6 $USER_HOME\cf7 /xray_user_links.txt"\cf3 \
\
\cf4 # \uc0\u1060 \u1091 \u1085 \u1082 \u1094 \u1080 \u1103  \u1076 \u1083 \u1103  \u1075 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1080  \u1085 \u1086 \u1074 \u1086 \u1075 \u1086  UUID\cf3 \
\cf5 generate_uuid\cf3 () \{\
    uuidgen\
\}\
\
\cf4 # \uc0\u1060 \u1091 \u1085 \u1082 \u1094 \u1080 \u1103  \u1076 \u1083 \u1103  \u1075 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1080  \u1087 \u1091 \u1073 \u1083 \u1080 \u1095 \u1085 \u1086 \u1075 \u1086  \u1082 \u1083 \u1102 \u1095 \u1072  \u1080 \u1079  \u1087 \u1088 \u1080 \u1074 \u1072 \u1090 \u1085 \u1086 \u1075 \u1086 \cf3 \
\cf5 generate_public_key\cf3 () \{\
    \cf5 echo\cf3  \cf7 "\cf6 $1\cf7 "\cf3  | openssl pkey -pubout -outform DER | openssl base64\
\}\
\
\cf4 # \uc0\u1060 \u1091 \u1085 \u1082 \u1094 \u1080 \u1103  \u1076 \u1083 \u1103  \u1089 \u1086 \u1079 \u1076 \u1072 \u1085 \u1080 \u1103  \u1092 \u1072 \u1081 \u1083 \u1086 \u1074  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \cf3 \
\cf5 create_user_files\cf3 () \{\
    \cf5 local\cf3  user_name=\cf7 "\cf6 $1\cf7 "\cf3 \
    \cf5 local\cf3  user_uuid=\cf7 "\cf6 $2\cf7 "\cf3 \
    \cf5 local\cf3  user_private_key=\cf7 "\cf6 $3\cf7 "\cf3 \
    \cf5 local\cf3  user_public_key=\cf7 "\cf6 $4\cf7 "\cf3 \
\
    \cf5 local\cf3  user_folder=\cf7 "\cf6 $USER_DIR\cf7 /\cf6 $user_name\cf7 "\cf3 \
    mkdir -p \cf7 "\cf6 $user_folder\cf7 "\cf3 \
\
    \cf4 # \uc0\u1057 \u1086 \u1079 \u1076 \u1072 \u1085 \u1080 \u1077  \u1092 \u1072 \u1081 \u1083 \u1072  \u1089  \u1076 \u1072 \u1085 \u1085 \u1099 \u1084 \u1080  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \cf3 \
    cat > \cf7 "\cf6 $user_folder\cf7 /user_data.txt"\cf3  <<EOF\
\uc0\u1048 \u1084 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 : \cf6 $user_name\cf3 \
UUID: \cf6 $user_uuid\cf3 \
\uc0\u1055 \u1088 \u1080 \u1074 \u1072 \u1090 \u1085 \u1099 \u1081  \u1082 \u1083 \u1102 \u1095 : \cf6 $user_private_key\cf3 \
\uc0\u1055 \u1091 \u1073 \u1083 \u1080 \u1095 \u1085 \u1099 \u1081  \u1082 \u1083 \u1102 \u1095 : \cf6 $user_public_key\cf3 \
EOF\
\
    \cf5 echo\cf3  \cf7 "\uc0\u1060 \u1072 \u1081 \u1083 \u1099  \u1076 \u1083 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \cf6 $user_name\cf7  \uc0\u1089 \u1086 \u1079 \u1076 \u1072 \u1085 \u1099  \u1074  \cf6 $user_folder\cf7 ."\cf3 \
\}\
\
\cf4 # \uc0\u1060 \u1091 \u1085 \u1082 \u1094 \u1080 \u1103  \u1076 \u1083 \u1103  \u1076 \u1086 \u1073 \u1072 \u1074 \u1083 \u1077 \u1085 \u1080 \u1103  \u1085 \u1086 \u1074 \u1086 \u1075 \u1086  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1074  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1102  Xray\cf3 \
\cf5 add_user\cf3 () \{\
    \cf5 local\cf3  user_name=\cf7 "\cf6 $1\cf7 "\cf3 \
    \cf5 local\cf3  user_uuid=\cf7 "\cf6 $2\cf7 "\cf3 \
    \cf5 local\cf3  user_private_key=\cf7 "\cf6 $3\cf7 "\cf3 \
    \cf5 local\cf3  user_public_key=\cf7 "\cf6 $4\cf7 "\cf3 \
\
    \cf5 echo\cf3  \cf7 "\uc0\u1044 \u1086 \u1073 \u1072 \u1074 \u1083 \u1077 \u1085 \u1080 \u1077  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \cf6 $user_name\cf7  \uc0\u1089  UUID \cf6 $user_uuid\cf7 ..."\cf3 \
\
    \cf4 # \uc0\u1044 \u1086 \u1073 \u1072 \u1074 \u1083 \u1077 \u1085 \u1080 \u1077  \u1085 \u1086 \u1074 \u1086 \u1075 \u1086  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1074  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1099 \u1081  \u1092 \u1072 \u1081 \u1083  Xray\cf3 \
    jq --arg uuid \cf7 "\cf6 $user_uuid\cf7 "\cf3  --arg email \cf7 "\cf6 $user_name\cf7 "\cf3  \\\
        \cf7 '.inbounds[0].settings.clients += [\{"id": $uuid, "email": $email\}]'\cf3  \\\
        \cf6 $CONFIG_FILE\cf3  > \cf6 $USER_CONFIG_FILE\cf3 \
\
    \cf4 # \uc0\u1054 \u1073 \u1085 \u1086 \u1074 \u1083 \u1077 \u1085 \u1080 \u1077  \u1086 \u1088 \u1080 \u1075 \u1080 \u1085 \u1072 \u1083 \u1100 \u1085 \u1086 \u1075 \u1086  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1086 \u1075 \u1086  \u1092 \u1072 \u1081 \u1083 \u1072 \cf3 \
    mv \cf6 $USER_CONFIG_FILE\cf3  \cf6 $CONFIG_FILE\cf3 \
    systemctl restart xray\
\
    \cf4 # \uc0\u1060 \u1086 \u1088 \u1084 \u1080 \u1088 \u1086 \u1074 \u1072 \u1085 \u1080 \u1077  \u1089 \u1089 \u1099 \u1083 \u1082 \u1080  \u1076 \u1083 \u1103  VLESS\cf3 \
    vless_link=\cf7 "vless://\cf6 $user_uuid\cf7 @\cf6 $(hostname -I | awk '\{print $1\}')\cf7 :443/?encryption=none&type=http&sni=example.com&host=somefakedummytext.com&path=%2F0J3QsNCy0LDQu9GM0L3Ri9C5&fp=chrome&security=reality&alpn=h2&pbk=\cf6 $user_public_key\cf7 &packetEncoding=xudp"\cf3 \
\
    \cf4 # \uc0\u1060 \u1086 \u1088 \u1084 \u1080 \u1088 \u1086 \u1074 \u1072 \u1085 \u1080 \u1077  \u1089 \u1089 \u1099 \u1083 \u1082 \u1080  \u1076 \u1083 \u1103  Shadowsocks\cf3 \
    ss_link=\cf7 "ss://2022-blake3-aes-128-gcm:\cf6 $ss_password\cf7 @\cf6 $(hostname -I | awk '\{print $1\}')\cf7 :54321"\cf3 \
\
    \cf4 # \uc0\u1047 \u1072 \u1087 \u1080 \u1089 \u1100  \u1089 \u1089 \u1099 \u1083 \u1086 \u1082  \u1074  \u1092 \u1072 \u1081 \u1083 \cf3 \
    \cf5 echo\cf3  \cf7 "VLESS Link for \cf6 $user_name\cf7 : \cf6 $vless_link\cf7 "\cf3  >> \cf7 "\cf6 $USER_LINKS_FILE\cf7 "\cf3 \
    \cf5 echo\cf3  \cf7 "Shadowsocks Link for \cf6 $user_name\cf7 : \cf6 $ss_link\cf7 "\cf3  >> \cf7 "\cf6 $USER_LINKS_FILE\cf7 "\cf3 \
\
    \cf4 # \uc0\u1057 \u1086 \u1079 \u1076 \u1072 \u1085 \u1080 \u1077  \u1092 \u1072 \u1081 \u1083 \u1086 \u1074  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \cf3 \
    create_user_files \cf7 "\cf6 $user_name\cf7 "\cf3  \cf7 "\cf6 $user_uuid\cf7 "\cf3  \cf7 "\cf6 $user_private_key\cf7 "\cf3  \cf7 "\cf6 $user_public_key\cf7 "\cf3 \
\}\
\
\cf4 # \uc0\u1060 \u1091 \u1085 \u1082 \u1094 \u1080 \u1103  \u1076 \u1083 \u1103  \u1091 \u1076 \u1072 \u1083 \u1077 \u1085 \u1080 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1080 \u1079  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1080  Xray\cf3 \
\cf5 remove_user\cf3 () \{\
    \cf5 local\cf3  user_uuid=\cf7 "\cf6 $1\cf7 "\cf3 \
\
    \cf5 echo\cf3  \cf7 "\uc0\u1059 \u1076 \u1072 \u1083 \u1077 \u1085 \u1080 \u1077  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1089  UUID \cf6 $user_uuid\cf7 ..."\cf3 \
\
    \cf4 # \uc0\u1059 \u1076 \u1072 \u1083 \u1077 \u1085 \u1080 \u1077  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1080 \u1079  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1086 \u1075 \u1086  \u1092 \u1072 \u1081 \u1083 \u1072  Xray\cf3 \
    jq --arg uuid \cf7 "\cf6 $user_uuid\cf7 "\cf3  \cf7 '\
        .inbounds[0].settings.clients |= map(select(.id != $uuid))\
    '\cf3  \cf6 $CONFIG_FILE\cf3  > \cf6 $USER_CONFIG_FILE\cf3 \
\
    \cf4 # \uc0\u1054 \u1073 \u1085 \u1086 \u1074 \u1083 \u1077 \u1085 \u1080 \u1077  \u1086 \u1088 \u1080 \u1075 \u1080 \u1085 \u1072 \u1083 \u1100 \u1085 \u1086 \u1075 \u1086  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1086 \u1075 \u1086  \u1092 \u1072 \u1081 \u1083 \u1072 \cf3 \
    mv \cf6 $USER_CONFIG_FILE\cf3  \cf6 $CONFIG_FILE\cf3 \
    systemctl restart xray\
\
    \cf4 # \uc0\u1059 \u1076 \u1072 \u1083 \u1077 \u1085 \u1080 \u1077  \u1092 \u1072 \u1081 \u1083 \u1086 \u1074  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1080 \u1079  \u1087 \u1072 \u1087 \u1082 \u1080 \cf3 \
    \cf5 local\cf3  user_folder=$(find \cf7 "\cf6 $USER_DIR\cf7 "\cf3  -\cf5 type\cf3  d -name \cf7 "*\cf6 $user_uuid\cf7 *"\cf3  | head -n 1)\
    \cf8 if\cf3  [ -n \cf7 "\cf6 $user_folder\cf7 "\cf3  ]; \cf8 then\cf3 \
        rm -rf \cf7 "\cf6 $user_folder\cf7 "\cf3 \
        \cf5 echo\cf3  \cf7 "\uc0\u1060 \u1072 \u1081 \u1083 \u1099  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1089  UUID \cf6 $user_uuid\cf7  \uc0\u1091 \u1076 \u1072 \u1083 \u1077 \u1085 \u1099  \u1080 \u1079  \cf6 $USER_DIR\cf7 ."\cf3 \
    \cf8 fi\cf3 \
\
    \cf4 # \uc0\u1059 \u1076 \u1072 \u1083 \u1077 \u1085 \u1080 \u1077  \u1089 \u1089 \u1099 \u1083 \u1086 \u1082  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1080 \u1079  \u1092 \u1072 \u1081 \u1083 \u1072 \cf3 \
    sed -i \cf7 "/\cf6 $user_uuid\cf7 /d"\cf3  \cf7 "\cf6 $USER_LINKS_FILE\cf7 "\cf3 \
\}\
\
\cf4 # \uc0\u1060 \u1091 \u1085 \u1082 \u1094 \u1080 \u1103  \u1076 \u1083 \u1103  \u1086 \u1090 \u1086 \u1073 \u1088 \u1072 \u1078 \u1077 \u1085 \u1080 \u1103  \u1074 \u1089 \u1077 \u1093  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 \cf3 \
\cf5 list_users\cf3 () \{\
    \cf5 echo\cf3  \cf7 "\uc0\u1057 \u1087 \u1080 \u1089 \u1086 \u1082  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 :"\cf3 \
    jq -r \cf7 '.inbounds[0].settings.clients[] | "\\(.email) - \\(.id)"'\cf3  \cf6 $CONFIG_FILE\cf3 \
\}\
\
\cf4 # \uc0\u1055 \u1088 \u1086 \u1074 \u1077 \u1088 \u1082 \u1072  \u1085 \u1072 \u1083 \u1080 \u1095 \u1080 \u1103  \u1087 \u1088 \u1072 \u1074  \u1089 \u1091 \u1087 \u1077 \u1088 \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \cf3 \
\cf8 if\cf3  [ \cf7 "\cf6 $EUID\cf7 "\cf3  -ne 0 ]; \cf8 then\cf3 \
    \cf5 echo\cf3  \cf7 "\uc0\u1055 \u1086 \u1078 \u1072 \u1083 \u1091 \u1081 \u1089 \u1090 \u1072 , \u1079 \u1072 \u1087 \u1091 \u1089 \u1090 \u1080 \u1090 \u1077  \u1101 \u1090 \u1086 \u1090  \u1089 \u1082 \u1088 \u1080 \u1087 \u1090  \u1089  \u1087 \u1088 \u1072 \u1074 \u1072 \u1084 \u1080  \u1089 \u1091 \u1087 \u1077 \u1088 \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  (sudo)."\cf3 \
    \cf5 exit\cf3  1\
\cf8 fi\cf3 \
\
\cf4 # \uc0\u1055 \u1088 \u1086 \u1074 \u1077 \u1088 \u1082 \u1072  \u1085 \u1072 \u1083 \u1080 \u1095 \u1080 \u1103  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1086 \u1075 \u1086  \u1092 \u1072 \u1081 \u1083 \u1072 \cf3 \
\cf8 if\cf3  [ ! -f \cf7 "\cf6 $CONFIG_FILE\cf7 "\cf3  ]; \cf8 then\cf3 \
    \cf5 echo\cf3  \cf7 "\uc0\u1060 \u1072 \u1081 \u1083  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1080  Xray \u1085 \u1077  \u1085 \u1072 \u1081 \u1076 \u1077 \u1085 : \cf6 $CONFIG_FILE\cf7 "\cf3 \
    \cf5 exit\cf3  1\
\cf8 fi\cf3 \
\
\cf4 # \uc0\u1057 \u1086 \u1079 \u1076 \u1072 \u1085 \u1080 \u1077  \u1087 \u1072 \u1087 \u1082 \u1080  \u1076 \u1083 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 , \u1077 \u1089 \u1083 \u1080  \u1085 \u1077  \u1089 \u1091 \u1097 \u1077 \u1089 \u1090 \u1074 \u1091 \u1077 \u1090 \cf3 \
mkdir -p \cf7 "\cf6 $USER_DIR\cf7 "\cf3 \
\
\cf4 # \uc0\u1052 \u1077 \u1085 \u1102  \u1076 \u1083 \u1103  \u1091 \u1087 \u1088 \u1072 \u1074 \u1083 \u1077 \u1085 \u1080 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \u1084 \u1080 \cf3 \
\cf5 echo\cf3  \cf7 "\uc0\u1042 \u1099 \u1073 \u1077 \u1088 \u1080 \u1090 \u1077  \u1076 \u1077 \u1081 \u1089 \u1090 \u1074 \u1080 \u1077 :"\cf3 \
\cf5 echo\cf3  \cf7 "1. \uc0\u1055 \u1088 \u1086 \u1089 \u1084 \u1086 \u1090 \u1088 \u1077 \u1090 \u1100  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 "\cf3 \
\cf5 echo\cf3  \cf7 "2. \uc0\u1044 \u1086 \u1073 \u1072 \u1074 \u1080 \u1090 \u1100  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 "\cf3 \
\cf5 echo\cf3  \cf7 "3. \uc0\u1059 \u1076 \u1072 \u1083 \u1080 \u1090 \u1100  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 "\cf3 \
\cf5 read\cf3  -p \cf7 "\uc0\u1042 \u1072 \u1096  \u1074 \u1099 \u1073 \u1086 \u1088 : "\cf3  action\
\
\cf8 case\cf3  \cf6 $action\cf3  \cf8 in\cf3 \
    1)\
        list_users\
        ;;\
    2)\
        \cf4 # \uc0\u1042 \u1074 \u1086 \u1076  \u1076 \u1072 \u1085 \u1085 \u1099 \u1093  \u1076 \u1083 \u1103  \u1085 \u1086 \u1074 \u1086 \u1075 \u1086  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \cf3 \
        \cf5 read\cf3  -p \cf7 "\uc0\u1042 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  \u1080 \u1084 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 : "\cf3  user_name\
        user_uuid=$(generate_uuid)\
        private_key=$(openssl genpkey -algorithm X25519)\
        public_key=$(generate_public_key \cf7 "\cf6 $private_key\cf7 "\cf3 )\
        ss_password=$(openssl rand -base64 16)  \cf4 # \uc0\u1043 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1103  \u1087 \u1072 \u1088 \u1086 \u1083 \u1103  \u1076 \u1083 \u1103  Shadowsocks\cf3 \
\
        \cf4 # \uc0\u1044 \u1086 \u1073 \u1072 \u1074 \u1083 \u1077 \u1085 \u1080 \u1077  \u1085 \u1086 \u1074 \u1086 \u1075 \u1086  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \cf3 \
        add_user \cf7 "\cf6 $user_name\cf7 "\cf3  \cf7 "\cf6 $user_uuid\cf7 "\cf3  \cf7 "\cf6 $private_key\cf7 "\cf3  \cf7 "\cf6 $public_key\cf7 "\cf3 \
        \cf5 echo\cf3  \cf7 "\uc0\u1055 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1100  \cf6 $user_name\cf7  \uc0\u1091 \u1089 \u1087 \u1077 \u1096 \u1085 \u1086  \u1076 \u1086 \u1073 \u1072 \u1074 \u1083 \u1077 \u1085 ."\cf3 \
        ;;\
    3)\
        \cf4 # \uc0\u1042 \u1074 \u1086 \u1076  UUID \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1076 \u1083 \u1103  \u1091 \u1076 \u1072 \u1083 \u1077 \u1085 \u1080 \u1103 \cf3 \
        \cf5 read\cf3  -p \cf7 "\uc0\u1042 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  UUID \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1076 \u1083 \u1103  \u1091 \u1076 \u1072 \u1083 \u1077 \u1085 \u1080 \u1103 : "\cf3  user_uuid\
\
        \cf4 # \uc0\u1059 \u1076 \u1072 \u1083 \u1077 \u1085 \u1080 \u1077  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \cf3 \
        remove_user \cf7 "\cf6 $user_uuid\cf7 "\cf3 \
        \cf5 echo\cf3  \cf7 "\uc0\u1055 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1100  \u1089  UUID \cf6 $user_uuid\cf7  \uc0\u1091 \u1089 \u1087 \u1077 \u1096 \u1085 \u1086  \u1091 \u1076 \u1072 \u1083 \u1077 \u1085 ."\cf3 \
        ;;\
    *)\
        \cf5 echo\cf3  \cf7 "\uc0\u1053 \u1077 \u1082 \u1086 \u1088 \u1088 \u1077 \u1082 \u1090 \u1085 \u1099 \u1081  \u1074 \u1099 \u1073 \u1086 \u1088 . \u1055 \u1086 \u1078 \u1072 \u1083 \u1091 \u1081 \u1089 \u1090 \u1072 , \u1074 \u1099 \u1073 \u1077 \u1088 \u1080 \u1090 \u1077  \u1094 \u1080 \u1092 \u1088 \u1091  \u1086 \u1090  1 \u1076 \u1086  3."\cf3 \
        \cf5 exit\cf3  1\
        ;;\
\cf8 esac\cf3 \
\
\cf5 echo\cf3  \cf7 "\uc0\u1057 \u1089 \u1099 \u1083 \u1082 \u1080  \u1076 \u1083 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081  \u1089 \u1086 \u1093 \u1088 \u1072 \u1085 \u1077 \u1085 \u1099  \u1074  \u1092 \u1072 \u1081 \u1083 : \cf6 $USER_LINKS_FILE\cf7 "}