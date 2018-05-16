/* ************************************************************************** */
/*                                                                            */
/*                                                            |\              */
/*   VEncode.c                                          ------| \----         */
/*                                                      |    \`  \  |  p      */
/*   By: jeudy2552 <jeudy2552@floridapoly.edu>          |  \`-\   \ |  o      */
/*                                                      |---\  \   `|  l      */
/*   Created: 2018/05/16 15:39:16 by jeudy2552          | ` .\  \   |  y      */
/*   Updated: 2018/05/16 17:29:22 by jeudy2552          -------------         */
/*                                                                            */
/* ************************************************************************** */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//This almost works 100%, just fix the bad offset, add support for spaces, punctuation, and caps.

char * repeatString(int n, const char * s){
    size_t slen = strlen(s);
    char * dest = malloc(n*slen+1);
    int i; char * p;
    for ( i=0, p = dest; i < n; ++i, p += slen ) {
        memcpy(p, s, slen);
    }
    *p = '\0';
    return dest;
}

int main(){
    char key[100];
    char message[100];
    char cipher[100];
    char alpha[26] = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
    int messageLen;
    int keyLen;
    int cipherInt[100];
    printf("Welcome to the Vigenere cipher encoder\n");
    printf("Please input a key: ");
    scanf("%s", key);
    printf("\nPlease input message: ");
    scanf("%s", message);
    messageLen = strlen (message);
    keyLen = strlen (key);
    if(messageLen != keyLen){
        char longKey[100];
        for(int i=0, j=0; i<messageLen; i++, j++){
            if(j >= keyLen){
                j=0;
            }
            int messageInt = message[i] - '0';
            int keyInt = key[j] - '0';
            cipherInt[i] = messageInt + keyInt;
            if(cipherInt[i]>26){
                cipherInt[i] = cipherInt[i]%26;
                cipher[i] = alpha[cipherInt[i]];
            }
            else{
                cipher[i] = alpha[cipherInt[i]];
            }
        }
    }
    else{
        for (int i=0; i<messageLen; i++){
            int messageInt = message[i] - '0';
            int keyInt = key[i] - '0';
            cipherInt[i] = messageInt + keyInt;
            if(cipherInt[i]>26){
                cipherInt[i] = cipherInt[i]%26;
                cipher[i] = alpha[cipherInt[i]];
            }
            else{
                cipher[i] = alpha[cipherInt[i]];
            }
        }
    }
    printf("\nYour ciphertext is: %s\n", cipher);
    return 0;
}
