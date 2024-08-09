{\rtf1\ansi\ansicpg1251\cocoartf2761
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
\
# \uc0\u1054 \u1087 \u1088 \u1077 \u1076 \u1077 \u1083 \u1077 \u1085 \u1080 \u1077  \u1076 \u1086 \u1084 \u1072 \u1096 \u1085 \u1077 \u1081  \u1087 \u1072 \u1087 \u1082 \u1080  \u1090 \u1077 \u1082 \u1091 \u1097 \u1077 \u1075 \u1086  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \
USER_HOME=$(eval echo ~$SUDO_USER)\
# \uc0\u1055 \u1091 \u1090 \u1100  \u1082  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1086 \u1084 \u1091  \u1092 \u1072 \u1081 \u1083 \u1091  Xray\
CONFIG_FILE="/usr/local/etc/xray/config.json"\
# \uc0\u1055 \u1091 \u1090 \u1100  \u1076 \u1083 \u1103  \u1089 \u1086 \u1093 \u1088 \u1072 \u1085 \u1077 \u1085 \u1080 \u1103  \u1082 \u1086 \u1087 \u1080 \u1080  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1086 \u1075 \u1086  \u1092 \u1072 \u1081 \u1083 \u1072  \u1074  \u1076 \u1086 \u1084 \u1072 \u1096 \u1085 \u1102 \u1102  \u1087 \u1072 \u1087 \u1082 \u1091  \u1090 \u1077 \u1082 \u1091 \u1097 \u1077 \u1075 \u1086  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \
USER_CONFIG_FILE="$USER_HOME/xray_config.json"\
# \uc0\u1055 \u1091 \u1090 \u1100  \u1076 \u1083 \u1103  \u1089 \u1086 \u1093 \u1088 \u1072 \u1085 \u1077 \u1085 \u1080 \u1103  \u1092 \u1072 \u1081 \u1083 \u1072  \u1089  \u1076 \u1072 \u1085 \u1085 \u1099 \u1084 \u1080  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \
USER_DATA_FILE="$USER_HOME/xray_user_data.txt"\
# \uc0\u1055 \u1091 \u1090 \u1100  \u1076 \u1083 \u1103  \u1089 \u1086 \u1093 \u1088 \u1072 \u1085 \u1077 \u1085 \u1080 \u1103  \u1074 \u1089 \u1077 \u1093  \u1089 \u1089 \u1099 \u1083 \u1086 \u1082  \u1076 \u1083 \u1103  \u1082 \u1083 \u1080 \u1077 \u1085 \u1090 \u1072 \
CLIENT_LINKS_FILE="$USER_HOME/xray_client_links.txt"\
# \uc0\u1055 \u1091 \u1090 \u1100  \u1076 \u1083 \u1103  \u1089 \u1086 \u1079 \u1076 \u1072 \u1085 \u1080 \u1103  \u1087 \u1072 \u1087 \u1082 \u1080  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081  \u1074  \u1082 \u1086 \u1088 \u1085 \u1077 \u1074 \u1086 \u1081  \u1087 \u1072 \u1087 \u1082 \u1077  \u1090 \u1077 \u1082 \u1091 \u1097 \u1077 \u1075 \u1086  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \
USER_DIR="$USER_HOME/xray_users"\
# \uc0\u1055 \u1091 \u1090 \u1100  \u1076 \u1083 \u1103  \u1089 \u1086 \u1093 \u1088 \u1072 \u1085 \u1077 \u1085 \u1080 \u1103  \u1089 \u1089 \u1099 \u1083 \u1086 \u1082  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 \
USER_LINKS_FILE="$USER_HOME/xray_user_links.txt"\
\
# \uc0\u1060 \u1091 \u1085 \u1082 \u1094 \u1080 \u1103  \u1076 \u1083 \u1103  \u1075 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1080  \u1085 \u1086 \u1074 \u1086 \u1075 \u1086  UUID\
generate_uuid() \{\
    uuidgen\
\}\
\
# \uc0\u1060 \u1091 \u1085 \u1082 \u1094 \u1080 \u1103  \u1076 \u1083 \u1103  \u1075 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1080  \u1087 \u1091 \u1073 \u1083 \u1080 \u1095 \u1085 \u1086 \u1075 \u1086  \u1082 \u1083 \u1102 \u1095 \u1072  \u1080 \u1079  \u1087 \u1088 \u1080 \u1074 \u1072 \u1090 \u1085 \u1086 \u1075 \u1086 \
generate_public_key() \{\
    echo "$1" | openssl pkey -pubout -outform DER | openssl base64\
\}\
\
# \uc0\u1060 \u1091 \u1085 \u1082 \u1094 \u1080 \u1103  \u1076 \u1083 \u1103  \u1075 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1080  \u1089 \u1083 \u1091 \u1095 \u1072 \u1081 \u1085 \u1086 \u1075 \u1086  \u1087 \u1072 \u1088 \u1086 \u1083 \u1103  \u1074  \u1092 \u1086 \u1088 \u1084 \u1072 \u1090 \u1077  Base64\
generate_base64_key() \{\
    openssl rand -base64 16\
\}\
\
# \uc0\u1057 \u1087 \u1080 \u1089 \u1086 \u1082  \u1087 \u1086 \u1087 \u1091 \u1083 \u1103 \u1088 \u1085 \u1099 \u1093  \u1089 \u1072 \u1081 \u1090 \u1086 \u1074  \u1074  \u1079 \u1086 \u1085 \u1077  .com\
sites=(\
    "google.com"\
    "facebook.com"\
    "youtube.com"\
    "amazon.com"\
    "microsoft.com"\
    "apple.com"\
    "netflix.com"\
    "twitter.com"\
    "linkedin.com"\
    "instagram.com"\
)\
\
# \uc0\u1060 \u1091 \u1085 \u1082 \u1094 \u1080 \u1103  \u1076 \u1083 \u1103  \u1086 \u1090 \u1086 \u1073 \u1088 \u1072 \u1078 \u1077 \u1085 \u1080 \u1103  \u1089 \u1087 \u1080 \u1089 \u1082 \u1072  \u1089 \u1072 \u1081 \u1090 \u1086 \u1074 \
display_sites() \{\
    echo "\uc0\u1042 \u1099 \u1073 \u1077 \u1088 \u1080 \u1090 \u1077  \u1089 \u1072 \u1081 \u1090  \u1076 \u1083 \u1103  \u1087 \u1086 \u1076 \u1084 \u1077 \u1085 \u1099  (\u1074 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  \u1094 \u1080 \u1092 \u1088 \u1091  \u1086 \u1090  1 \u1076 \u1086  10, \u1080 \u1083 \u1080  0 \u1076 \u1083 \u1103  \u1074 \u1074 \u1086 \u1076 \u1072  \u1089 \u1086 \u1073 \u1089 \u1090 \u1074 \u1077 \u1085 \u1085 \u1086 \u1075 \u1086 ):"\
    for i in "$\{!sites[@]\}"; do\
        echo "$((i + 1)). $\{sites[$i]\}"\
    done\
    echo "0. \uc0\u1042 \u1074 \u1077 \u1089 \u1090 \u1080  \u1089 \u1074 \u1086 \u1081  \u1089 \u1086 \u1073 \u1089 \u1090 \u1074 \u1077 \u1085 \u1085 \u1099 \u1081  \u1076 \u1086 \u1084 \u1077 \u1085 "\
\}\
\
# \uc0\u1047 \u1072 \u1087 \u1088 \u1086 \u1089  \u1074 \u1074 \u1086 \u1076 \u1072  \u1076 \u1072 \u1085 \u1085 \u1099 \u1093  \u1091  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \
read -p "\uc0\u1042 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  IP-\u1072 \u1076 \u1088 \u1077 \u1089  \u1074 \u1072 \u1096 \u1077 \u1075 \u1086  \u1089 \u1077 \u1088 \u1074 \u1077 \u1088 \u1072 : " server_ip\
display_sites\
read -p "\uc0\u1042 \u1072 \u1096  \u1074 \u1099 \u1073 \u1086 \u1088 : " choice\
\
# \uc0\u1054 \u1087 \u1088 \u1077 \u1076 \u1077 \u1083 \u1077 \u1085 \u1080 \u1077  \u1084 \u1072 \u1089 \u1082 \u1080 \u1088 \u1086 \u1074 \u1086 \u1095 \u1085 \u1086 \u1075 \u1086  \u1076 \u1086 \u1084 \u1077 \u1085 \u1072 \
case $choice in\
    [1-9]|10)\
        camouflage_domain="$\{sites[$((choice - 1))]\}"\
        ;;\
    0)\
        read -p "\uc0\u1042 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  \u1084 \u1072 \u1089 \u1082 \u1080 \u1088 \u1086 \u1074 \u1086 \u1095 \u1085 \u1099 \u1081  \u1076 \u1086 \u1084 \u1077 \u1085  (\u1085 \u1072 \u1087 \u1088 \u1080 \u1084 \u1077 \u1088 , example.com): " camouflage_domain\
        ;;\
    *)\
        echo "\uc0\u1053 \u1077 \u1082 \u1086 \u1088 \u1088 \u1077 \u1082 \u1090 \u1085 \u1099 \u1081  \u1074 \u1099 \u1073 \u1086 \u1088 . \u1055 \u1086 \u1078 \u1072 \u1083 \u1091 \u1081 \u1089 \u1090 \u1072 , \u1074 \u1099 \u1073 \u1077 \u1088 \u1080 \u1090 \u1077  \u1094 \u1080 \u1092 \u1088 \u1091  \u1086 \u1090  0 \u1076 \u1086  10."\
        exit 1\
        ;;\
esac\
\
# \uc0\u1047 \u1072 \u1087 \u1088 \u1086 \u1089  \u1086 \u1089 \u1090 \u1072 \u1083 \u1100 \u1085 \u1099 \u1093  \u1076 \u1072 \u1085 \u1085 \u1099 \u1093 \
read -p "\uc0\u1042 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  \u1087 \u1091 \u1090 \u1100  \u1076 \u1083 \u1103  WebSocket (\u1085 \u1072 \u1087 \u1088 \u1080 \u1084 \u1077 \u1088 , mypath): " path\
read -p "\uc0\u1042 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  \u1087 \u1088 \u1080 \u1074 \u1072 \u1090 \u1085 \u1099 \u1081  \u1082 \u1083 \u1102 \u1095  Reality (\u1080 \u1083 \u1080  \u1086 \u1089 \u1090 \u1072 \u1074 \u1100 \u1090 \u1077  \u1087 \u1091 \u1089 \u1090 \u1099 \u1084  \u1076 \u1083 \u1103  \u1075 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1080  \u1085 \u1086 \u1074 \u1086 \u1075 \u1086 ): " private_key\
read -p "\uc0\u1042 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  UUID \u1076 \u1083 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  (\u1080 \u1083 \u1080  \u1086 \u1089 \u1090 \u1072 \u1074 \u1100 \u1090 \u1077  \u1087 \u1091 \u1089 \u1090 \u1099 \u1084  \u1076 \u1083 \u1103  \u1075 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1080  \u1085 \u1086 \u1074 \u1086 \u1075 \u1086 ): " user_uuid\
\
# \uc0\u1043 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1103  \u1087 \u1088 \u1080 \u1074 \u1072 \u1090 \u1085 \u1086 \u1075 \u1086  \u1082 \u1083 \u1102 \u1095 \u1072 , \u1077 \u1089 \u1083 \u1080  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1100  \u1085 \u1077  \u1091 \u1082 \u1072 \u1079 \u1072 \u1083  \u1089 \u1074 \u1086 \u1081 \
if [[ -z "$private_key" ]]; then\
    private_key=$(openssl genpkey -algorithm X25519 | openssl pkey -pubout -outform DER | openssl base64)\
    echo "\uc0\u1057 \u1075 \u1077 \u1085 \u1077 \u1088 \u1080 \u1088 \u1086 \u1074 \u1072 \u1085  \u1087 \u1088 \u1080 \u1074 \u1072 \u1090 \u1085 \u1099 \u1081  \u1082 \u1083 \u1102 \u1095 : $private_key"\
fi\
\
# \uc0\u1043 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1103  UUID, \u1077 \u1089 \u1083 \u1080  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1100  \u1085 \u1077  \u1091 \u1082 \u1072 \u1079 \u1072 \u1083  \u1089 \u1074 \u1086 \u1081 \
if [[ -z "$user_uuid" ]]; then\
    user_uuid=$(generate_uuid)\
    echo "\uc0\u1057 \u1075 \u1077 \u1085 \u1077 \u1088 \u1080 \u1088 \u1086 \u1074 \u1072 \u1085  UUID: $user_uuid"\
fi\
\
# \uc0\u1043 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1103  \u1087 \u1091 \u1073 \u1083 \u1080 \u1095 \u1085 \u1086 \u1075 \u1086  \u1082 \u1083 \u1102 \u1095 \u1072  \u1080 \u1079  \u1087 \u1088 \u1080 \u1074 \u1072 \u1090 \u1085 \u1086 \u1075 \u1086 \
public_key=$(generate_public_key "$private_key")\
\
# \uc0\u1043 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1103  \u1087 \u1072 \u1088 \u1086 \u1083 \u1103  \u1076 \u1083 \u1103  Shadowsocks\
ss_password=$(generate_base64_key)\
\
# \uc0\u1047 \u1072 \u1087 \u1088 \u1086 \u1089  \u1087 \u1086 \u1088 \u1090 \u1072  \u1076 \u1083 \u1103  Shadowsocks\
read -p "\uc0\u1042 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  \u1087 \u1086 \u1088 \u1090  \u1076 \u1083 \u1103  Shadowsocks (\u1085 \u1072 \u1087 \u1088 \u1080 \u1084 \u1077 \u1088 , 54321): " ss_port\
\
# \uc0\u1047 \u1072 \u1087 \u1088 \u1086 \u1089  \u1085 \u1072  \u1080 \u1079 \u1084 \u1077 \u1085 \u1077 \u1085 \u1080 \u1077  \u1087 \u1086 \u1088 \u1090 \u1072  SSH\
read -p "\uc0\u1061 \u1086 \u1090 \u1080 \u1090 \u1077  \u1080 \u1079 \u1084 \u1077 \u1085 \u1080 \u1090 \u1100  \u1087 \u1086 \u1088 \u1090  SSH? (y/n): " change_ssh_port\
if [[ "$change_ssh_port" == "y" ]]; then\
    read -p "\uc0\u1042 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  \u1085 \u1086 \u1074 \u1099 \u1081  \u1087 \u1086 \u1088 \u1090  \u1076 \u1083 \u1103  SSH (\u1085 \u1072 \u1087 \u1088 \u1080 \u1084 \u1077 \u1088 , 2222): " ssh_port\
    \
    # \uc0\u1055 \u1088 \u1086 \u1074 \u1077 \u1088 \u1082 \u1072 , \u1095 \u1090 \u1086  \u1087 \u1086 \u1088 \u1090  \u1085 \u1077  \u1079 \u1072 \u1085 \u1103 \u1090 \
    if netstat -tuln | grep -q ":$ssh_port "; then\
        echo "\uc0\u1054 \u1096 \u1080 \u1073 \u1082 \u1072 : \u1055 \u1086 \u1088 \u1090  $ssh_port \u1091 \u1078 \u1077  \u1080 \u1089 \u1087 \u1086 \u1083 \u1100 \u1079 \u1091 \u1077 \u1090 \u1089 \u1103 ."\
        exit 1\
    fi\
\
    # \uc0\u1048 \u1079 \u1084 \u1077 \u1085 \u1077 \u1085 \u1080 \u1077  \u1087 \u1086 \u1088 \u1090 \u1072  SSH\
    echo "\uc0\u1048 \u1079 \u1084 \u1077 \u1085 \u1077 \u1085 \u1080 \u1077  \u1087 \u1086 \u1088 \u1090 \u1072  SSH \u1085 \u1072  $ssh_port..."\
    sed -i "s/^#Port 22/Port $ssh_port/" /etc/ssh/sshd_config\
    sed -i "s/^Port 22/Port $ssh_port/" /etc/ssh/sshd_config\
    systemctl restart sshd\
    echo "\uc0\u1055 \u1086 \u1088 \u1090  SSH \u1091 \u1089 \u1087 \u1077 \u1096 \u1085 \u1086  \u1080 \u1079 \u1084 \u1077 \u1085 \u1077 \u1085  \u1085 \u1072  $ssh_port."\
fi\
\
# \uc0\u1047 \u1072 \u1087 \u1088 \u1086 \u1089  \u1085 \u1072  \u1076 \u1086 \u1073 \u1072 \u1074 \u1083 \u1077 \u1085 \u1080 \u1077  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 \
read -p "\uc0\u1061 \u1086 \u1090 \u1080 \u1090 \u1077  \u1076 \u1086 \u1073 \u1072 \u1074 \u1080 \u1090 \u1100  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 ? (y/n): " add_users\
if [[ "$add_users" == "y" ]]; then\
    # \uc0\u1057 \u1086 \u1079 \u1076 \u1072 \u1085 \u1080 \u1077  \u1087 \u1072 \u1087 \u1082 \u1080  \u1076 \u1083 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 \
    mkdir -p "$USER_DIR"\
    \
    # \uc0\u1048 \u1085 \u1080 \u1094 \u1080 \u1072 \u1083 \u1080 \u1079 \u1072 \u1094 \u1080 \u1103  \u1087 \u1077 \u1088 \u1077 \u1084 \u1077 \u1085 \u1085 \u1099 \u1093  \u1076 \u1083 \u1103  \u1093 \u1088 \u1072 \u1085 \u1077 \u1085 \u1080 \u1103  \u1076 \u1072 \u1085 \u1085 \u1099 \u1093  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 \
    users_config=""\
    \
    # \uc0\u1054 \u1095 \u1080 \u1089 \u1090 \u1082 \u1072  \u1092 \u1072 \u1081 \u1083 \u1072  \u1089 \u1089 \u1099 \u1083 \u1086 \u1082  \u1076 \u1083 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 \
    : > "$USER_LINKS_FILE"\
    \
    while true; do\
        # \uc0\u1042 \u1074 \u1086 \u1076  \u1080 \u1084 \u1077 \u1085 \u1080  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \
        read -p "\uc0\u1042 \u1074 \u1077 \u1076 \u1080 \u1090 \u1077  \u1080 \u1084 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  (\u1080 \u1083 \u1080  \u1086 \u1089 \u1090 \u1072 \u1074 \u1100 \u1090 \u1077  \u1087 \u1091 \u1089 \u1090 \u1099 \u1084  \u1076 \u1083 \u1103  \u1079 \u1072 \u1074 \u1077 \u1088 \u1096 \u1077 \u1085 \u1080 \u1103 ): " user_name\
        \
        if [[ -z "$user_name" ]]; then\
            break\
        fi\
        \
        # \uc0\u1043 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1103  UUID \u1076 \u1083 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \
        user_id=$(generate_uuid)\
        \
        # \uc0\u1044 \u1086 \u1073 \u1072 \u1074 \u1083 \u1077 \u1085 \u1080 \u1077  \u1076 \u1072 \u1085 \u1085 \u1099 \u1093  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  \u1074  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1102 \
        users_config+=$(cat <<EOF\
        \{\
          "id": "$user_id",\
          "email": "$user_name"\
        \},\
EOF\
        )\
        \
        # \uc0\u1057 \u1086 \u1079 \u1076 \u1072 \u1085 \u1080 \u1077  \u1092 \u1072 \u1081 \u1083 \u1072  \u1089  \u1076 \u1072 \u1085 \u1085 \u1099 \u1084 \u1080  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \
        user_file="$USER_DIR/$\{user_name\}_data.txt"\
        cat > "$user_file" <<EOF\
UUID: $user_id\
Private Key: $private_key\
Public Key: $public_key\
EOF\
\
        echo "\uc0\u1044 \u1072 \u1085 \u1085 \u1099 \u1077  \u1076 \u1083 \u1103  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103  $user_name \u1089 \u1086 \u1093 \u1088 \u1072 \u1085 \u1077 \u1085 \u1099  \u1074  $user_file"\
        \
        # \uc0\u1060 \u1086 \u1088 \u1084 \u1080 \u1088 \u1086 \u1074 \u1072 \u1085 \u1080 \u1077  \u1089 \u1089 \u1099 \u1083 \u1082 \u1080  \u1076 \u1083 \u1103  VLESS\
        user_vless_link="vless://$user_id@$server_ip:443/?encryption=none&type=http&sni=$camouflage_domain&host=somefakedummytext.com&path=%2F0J3QsNCy0LDQu9GM0L3Ri9C5&fp=chrome&security=reality&alpn=h2&pbk=$public_key&packetEncoding=xudp"\
        # \uc0\u1060 \u1086 \u1088 \u1084 \u1080 \u1088 \u1086 \u1074 \u1072 \u1085 \u1080 \u1077  \u1089 \u1089 \u1099 \u1083 \u1082 \u1080  \u1076 \u1083 \u1103  Shadowsocks\
        user_ss_link="ss://2022-blake3-aes-128-gcm:$ss_password@$server_ip:$ss_port"\
        \
        # \uc0\u1047 \u1072 \u1087 \u1080 \u1089 \u1100  \u1089 \u1089 \u1099 \u1083 \u1086 \u1082  \u1074  \u1092 \u1072 \u1081 \u1083 \
        echo "VLESS Link for $user_name: $user_vless_link" >> "$USER_LINKS_FILE"\
        echo "Shadowsocks Link for $user_name: $user_ss_link" >> "$USER_LINKS_FILE"\
    done\
\
    # \uc0\u1059 \u1076 \u1072 \u1083 \u1077 \u1085 \u1080 \u1077  \u1087 \u1086 \u1089 \u1083 \u1077 \u1076 \u1085 \u1077 \u1081  \u1079 \u1072 \u1087 \u1103 \u1090 \u1086 \u1081  \u1080  \u1076 \u1086 \u1073 \u1072 \u1074 \u1083 \u1077 \u1085 \u1080 \u1077  \u1079 \u1072 \u1082 \u1088 \u1099 \u1074 \u1072 \u1102 \u1097 \u1077 \u1081  \u1089 \u1082 \u1086 \u1073 \u1082 \u1080 \
    users_config=$(echo "$users_config" | sed '$ s/,$//')\
fi\
\
# \uc0\u1057 \u1086 \u1079 \u1076 \u1072 \u1085 \u1080 \u1077  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1086 \u1075 \u1086  \u1092 \u1072 \u1081 \u1083 \u1072 \
cat > $CONFIG_FILE <<EOF\
\{\
  "log": \{\
    "loglevel": "info"\
  \},\
  "inbounds": [\
    \{\
      "listen": "$server_ip",\
      "port": 443,\
      "protocol": "vless",\
      "tag": "reality-in",\
      "settings": \{\
        "clients": [\
          $users_config\
        ],\
        "decryption": "none"\
      \},\
      "streamSettings": \{\
        "network": "http",\
        "httpSettings": \{\
          "host": ["somefakedummytext.com"],\
          "path": "/0J3QsNCy0LDQu9GM0L3Ri9C5",\
          "read_idle_timeout": 10,\
          "health_check_timeout": 15,\
          "method": "GET"\
        \},\
        "security": "reality",\
        "realitySettings": \{\
          "show": false,\
          "dest": "$camouflage_domain:443",\
          "xver": 0,\
          "serverNames": [\
            "$camouflage_domain"\
          ],\
          "privateKey": "$private_key",\
          "minClientVer": "",\
          "maxClientVer": "",\
          "maxTimeDiff": 0,\
          "shortIds": [""]\
        \}\
      \},\
      "sniffing": \{\
        "enabled": true,\
        "destOverride": [\
          "http",\
          "tls",\
          "quic"\
        ]\
      \}\
    \},\
    \{\
      "port": $ss_port,\
      "tag": "ss-in",\
      "protocol": "shadowsocks",\
      "settings": \{\
        "method": "2022-blake3-aes-128-gcm",\
        "password": "$ss_password",\
        "network": "tcp,udp"\
      \},\
      "sniffing": \{\
        "enabled": true,\
        "destOverride": [\
          "http",\
          "tls",\
          "quic"\
        ]\
      \}\
    \}\
  ],\
  "outbounds": [\
    \{\
      "protocol": "freedom",\
      "tag": "direct"\
    \},\
    \{\
      "protocol": "blackhole",\
      "tag": "block"\
    \}\
  ],\
  "routing": \{\
    "rules": [\
      \{\
        "type": "field",\
        "protocol": "bittorrent",\
        "outboundTag": "block"\
      \}\
    ],\
    "domainStrategy": "IPIfNonMatch"\
  \}\
\}\
EOF\
\
# \uc0\u1050 \u1086 \u1087 \u1080 \u1088 \u1086 \u1074 \u1072 \u1085 \u1080 \u1077  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1086 \u1075 \u1086  \u1092 \u1072 \u1081 \u1083 \u1072  \u1074  \u1076 \u1086 \u1084 \u1072 \u1096 \u1085 \u1102 \u1102  \u1087 \u1072 \u1087 \u1082 \u1091  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 \
cp $CONFIG_FILE $USER_CONFIG_FILE\
\
# \uc0\u1043 \u1077 \u1085 \u1077 \u1088 \u1072 \u1094 \u1080 \u1103  \u1080  \u1089 \u1086 \u1093 \u1088 \u1072 \u1085 \u1077 \u1085 \u1080 \u1077  \u1074 \u1089 \u1077 \u1093  \u1089 \u1089 \u1099 \u1083 \u1086 \u1082  \u1074  \u1092 \u1072 \u1081 \u1083 \
cat > $CLIENT_LINKS_FILE <<EOF\
VLESS Link: vless://$user_uuid@$server_ip:443/?encryption=none&type=http&sni=$camouflage_domain&host=somefakedummytext.com&path=%2F0J3QsNCy0LDQu9GM0L3Ri9C5&fp=chrome&security=reality&alpn=h2&pbk=$public_key&packetEncoding=xudp\
Shadowsocks Link: ss://2022-blake3-aes-128-gcm:$ss_password@$server_ip:$ss_port\
EOF\
\
# \uc0\u1055 \u1088 \u1080 \u1084 \u1077 \u1085 \u1077 \u1085 \u1080 \u1077  \u1085 \u1086 \u1074 \u1099 \u1093  \u1085 \u1072 \u1089 \u1090 \u1088 \u1086 \u1077 \u1082  \u1089 \u1080 \u1089 \u1090 \u1077 \u1084 \u1085 \u1086 \u1075 \u1086  \u1091 \u1088 \u1086 \u1074 \u1085 \u1103 \
echo -e "\\n\uc0\u1053 \u1072 \u1089 \u1090 \u1088 \u1086 \u1081 \u1082 \u1072  \u1089 \u1080 \u1089 \u1090 \u1077 \u1084 \u1085 \u1099 \u1093  \u1087 \u1072 \u1088 \u1072 \u1084 \u1077 \u1090 \u1088 \u1086 \u1074 ..."\
echo -e "net.core.default_qdisc=fq\\nnet.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf\
sysctl -p\
\
echo -e "\\n\uc0\u1050 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1103  Xray \u1091 \u1089 \u1087 \u1077 \u1096 \u1085 \u1086  \u1089 \u1086 \u1079 \u1076 \u1072 \u1085 \u1072  \u1080  \u1087 \u1088 \u1080 \u1084 \u1077 \u1085 \u1077 \u1085 \u1072 !"\
echo "IP-\uc0\u1072 \u1076 \u1088 \u1077 \u1089  \u1089 \u1077 \u1088 \u1074 \u1077 \u1088 \u1072 : $server_ip"\
echo "\uc0\u1052 \u1072 \u1089 \u1082 \u1080 \u1088 \u1086 \u1074 \u1086 \u1095 \u1085 \u1099 \u1081  \u1076 \u1086 \u1084 \u1077 \u1085 : $camouflage_domain"\
echo "\uc0\u1055 \u1088 \u1080 \u1074 \u1072 \u1090 \u1085 \u1099 \u1081  \u1082 \u1083 \u1102 \u1095  Reality: $private_key"\
echo "UUID \uc0\u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 : $user_uuid"\
echo "\uc0\u1055 \u1086 \u1088 \u1090  \u1076 \u1083 \u1103  Shadowsocks: $ss_port"\
echo "\uc0\u1055 \u1086 \u1088 \u1090  \u1076 \u1083 \u1103  SSH: $\{ssh_port:-22\}"\
echo "\uc0\u1057 \u1086 \u1093 \u1088 \u1072 \u1085 \u1077 \u1085 \u1085 \u1099 \u1077  \u1082 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1099 \u1077  \u1092 \u1072 \u1081 \u1083 \u1099  \u1080  \u1089 \u1089 \u1099 \u1083 \u1082 \u1080 :"\
echo "\uc0\u1050 \u1086 \u1085 \u1092 \u1080 \u1075 \u1091 \u1088 \u1072 \u1094 \u1080 \u1086 \u1085 \u1085 \u1099 \u1081  \u1092 \u1072 \u1081 \u1083 : $USER_CONFIG_FILE"\
echo "\uc0\u1060 \u1072 \u1081 \u1083  \u1089  \u1076 \u1072 \u1085 \u1085 \u1099 \u1084 \u1080  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1103 : $USER_DATA_FILE"\
echo "\uc0\u1060 \u1072 \u1081 \u1083  \u1089  \u1089 \u1089 \u1099 \u1083 \u1082 \u1072 \u1084 \u1080  \u1076 \u1083 \u1103  \u1082 \u1083 \u1080 \u1077 \u1085 \u1090 \u1072 : $CLIENT_LINKS_FILE"\
echo "\uc0\u1060 \u1072 \u1081 \u1083  \u1089  \u1089 \u1089 \u1099 \u1083 \u1082 \u1072 \u1084 \u1080  \u1087 \u1086 \u1083 \u1100 \u1079 \u1086 \u1074 \u1072 \u1090 \u1077 \u1083 \u1077 \u1081 : $USER_LINKS_FILE"}