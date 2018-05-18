/* ************************************************************************** */
/*                                                                            */
/*                                                            |\              */
/*   VEncode.c                                          ------| \----         */
/*                                                      |    \`  \  |  p      */
/*   By: jeudy2552 <jeudy2552@floridapoly.edu>          |  \`-\   \ |  o      */
/*                                                      |---\  \   `|  l      */
/*   Created: 2018/05/16 15:39:16 by jeudy2552          | ` .\  \   |  y      */
/*   Updated: 2018/05/17 23:57:55 by jeudy2552          -------------         */
/*                                                                            */
/* ************************************************************************** */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
//This almost works 100%, just fix the bad offset, add support for spaces, punctuation, and caps.

int main(){
    char key[100];
    char message[100];
    char cipher[100];
    char alpha[26] = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
    int messageLen;
    int keyLen;
    int cipherInt;
    char mLetter;
    char kLetter;

    printf("Welcome to the Vigenere cipher encoder\n");
    printf("Please input a key: ");
    scanf("%s", key);
    printf("\nPlease input message: ");
    scanf("%s", message);

    messageLen = strlen (message);
    keyLen = strlen (key);
    for(int i=0, j=0; i<messageLen; i++, j++){
        mLetter = message[i];
        if(isspace(mLetter)){
            j--;
            cipher[i] = " ";
            continue;
        }
        if(j >= keyLen){
            j=0;
        }
        kLetter = key[j];
        const char *mPtr = strchr(alpha, message[i]);
        const char *kPtr = strchr(alpha, key[j]);
        int messageInt = mPtr - alpha;
        int keyInt = kPtr - alpha;
        cipherInt = messageInt + keyInt;
        if(cipherInt>=26){
            cipherInt = cipherInt%26;
            cipher[i] = alpha[cipherInt];
        }
        else{
            cipher[i] = alpha[cipherInt];
        }
    }

    printf("\nYour ciphertext is: %s\n", cipher);
    return 0;
}
