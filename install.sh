#!/bin/bash

# bash system
C_CYAN='\033[0;36m'
C_GREEN='\033[0;32m'
C_RED='\033[0;31m'
C_NC='\033[0m'

# Dynamic Hardware Detection
ADMIN="krovixa"
# Grabs the actual model (e.g., SM-T225) and Brand
MODEL=$(getprop ro.product.model)
BRAND=$(getprop ro.product.brand)
OS_VER=$(getprop ro.build.version.release)

function boot_sequence() {
    clear
    echo -e "${C_CYAN}"
    cat << "EOF"
                                                                 
                        ##  ######  ##                           
                      ##### ##  #### #               #####       
                   ####  ## #       #             ###########    
                # ##    # # ##  # ###         ## ##############  
             #####  ###  #   ###              # ####       ####  
            ###   ###     ################      ###         ###  
           ###   #    ########################  ###         ###  
         ####  ##  #########            ######## ####      ####  
         #   ##  #######               #######################   
         ## ##  #####                ########## ### #########    
       ### ## #####                 ######  ##### ###    # #     
    #  #  ## ####                  ####        #######   ##      
    #### ## ####                   ###          ## ####    # #   
    ##  ##  ###                    ###         ###  ####   # #   
     ####  ###                      ####     #####   ###      #  
           ###    ####              #############     ###   # #  
    # #    ##     ####                #########       ###   #    
    # #    ##     ####      ####   #### #########     ###    ##  
    # #    ##     ####      #####  #### ###   ####    ###   # #  
    # #    ###    ####      ## ##  #### ### ### ##    ###   # #  
           ###    ####      ## ##  #######    # ##   ###    # #  
     # #    ###   ############ ## ############# ##   ###    ###  
      # #   ####  ####     # ################## ### ###   ##     
      #  #   #### ##############  ######### ###### ####   # #    
       # #    ####  ########  ######     ##### ## ####  ## ##    
       ## ##   ######                          #####    # #      
            #    ######                     #######   ## ##      
          ## ###   ########             #########                
             # #     #########################    ##  ##         
             ###  ##     ##################       # #            
                     ###                          ###            
                  ## #    #### ###  ####                         
                     ###  ## # # # ## ##                         
EOF
    echo -e "${C_NC}"
    echo -e "${C_GREEN}[SYSTEM] NYX_HYPERVISOR_BOOT_LOG${C_NC}"
    echo -e "${C_CYAN}[IDENT] ROOT_ADMIN: $ADMIN${C_NC}"
    echo -e "${C_CYAN}[IDENT] HARDWARE:   ${BRAND^^}_${MODEL}${C_NC}"
    echo -e "${C_CYAN}[IDENT] OS_KERN:   ANDROID_$OS_VER${C_NC}"
    echo "-----------------------------------------------"
    echo -e "GM, $ADMIN. NYX SYSTEM IS VIRTUALIZED ON YOUR $MODEL."
}

boot_sequence

# Permissions
chmod +x cli.lua
chmod +x z.lua
mkdir -p build logs

echo -e "\n${C_GREEN}[+] HARDWARE_HANDSHAKE_SUCCESSFUL.${C_NC}"
