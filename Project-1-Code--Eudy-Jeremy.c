/* ************************************************************************** */
/*                                                                            */
/*                                                            |\              */
/*   Project-1-Code--Eudy-Jeremy.c                      ------| \----         */
/*                                                      |    \`  \  |  p      */
/*   By: jeudy2552 <jeudy2552@floridapoly.edu>          |  \`-\   \ |  o      */
/*                                                      |---\  \   `|  l      */
/*   Created: 2018/05/16 15:39:16 by jeudy2552          | ` .\  \   |  y      */
/*   Updated: 2018/05/24 17:24:54 by jeudy2552          -------------         */
/*                                                                            */
/* ************************************************************************** */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int main(){
    char key[100];
    char message[100];
    char cipher[100];
    char alpha[27] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
        'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ' '};
    int messageLen;
    int keyLen;
    int cipherInt;
    char mLetter;
    char kLetter;

    printf("Welcome to the Vigenere cipher encoder\n");
    printf("Please input a key: ");
    scanf("%[^\n]%*c", key);
    printf("Please input message: ");
    scanf("%[^\n]%*c", message);
    for(int i=0; key[i]; i++){
        key[i] = toupper(key[i]);
    }
    for(int i=0; message[i]; i++){
        message[i] = toupper(message[i]);
    }

    messageLen = strlen (message);
    keyLen = strlen (key);
    for(int i=0, j=0; i<messageLen; i++, j++){
        mLetter = message[i];
        if(isspace(mLetter)){
            j--;
            cipher[i] = alpha[26];
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
        cipherInt = messageInt + keyInt+1;
        if(cipherInt>=26){
            cipherInt = cipherInt%26;
            cipher[i] = alpha[cipherInt];
//            printf("\nCiphertext so far: %s", cipher);
        }
        else{
            cipher[i] = alpha[cipherInt];
//            printf("\nCiphertext so far: %s", cipher);
        }
    }

    printf("Your ciphertext is: %s\n", cipher);
    return 0;
}
